#requires -Version 7.0
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
. (Join-Path $root 'scripts\Tooling.ps1')
Get-ChildItem (Join-Path $root 'scripts\*.ps1'), (Join-Path $PSScriptRoot '*.ps1') | ForEach-Object {
    $tokens = $null
    $parseErrors = $null
    [Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$tokens, [ref]$parseErrors) | Out-Null
    if ($parseErrors.Count) { throw ($parseErrors | Out-String) }
}
& (Get-WorkspaceNode) --test (Join-Path $PSScriptRoot 'validate-skill.test.mjs')
if ($LASTEXITCODE -ne 0) { throw 'Skill validation tests failed.' }
$temporary = Join-Path ([IO.Path]::GetTempPath()) "skill-packaging-$([guid]::NewGuid().ToString('N'))"
New-Item $temporary -ItemType Directory | Out-Null
try {
    & (Join-Path $root 'scripts\Build-Packages.ps1') -OutputPath (Join-Path $temporary 'packages') | Out-Null
    $metadata = Get-Content (Join-Path $temporary 'packages\artifacts.json') -Raw | ConvertFrom-Json
    if ($metadata.skill -ne 'meeting-notes' -or $metadata.artifacts.Count -ne 3) { throw 'Incomplete artifact metadata.' }
    $expected = @{
        'skill' = 'SKILL.md'
        'github-repository' = '.github/skills/meeting-notes/SKILL.md'
        'github-marketplace' = 'skills/meeting-notes/SKILL.md'
    }
    foreach ($kind in $expected.Keys) {
        $zip = Join-Path $temporary "packages\$kind-$($metadata.version).zip"
        $archive = [IO.Compression.ZipFile]::OpenRead($zip)
        try {
            $entry = $archive.GetEntry($expected[$kind])
            if (-not $entry -or $entry.Length -eq 0) { throw "Incorrect archive root for $kind." }
            if (@($archive.Entries | Where-Object { $_.FullName -match '(^|/)(input|expected-behavior|edge-cases)\.md$' }).Count) {
                throw "Test fixtures were included in the $kind skill package."
            }
            if ($kind -eq 'github-marketplace') {
                foreach ($path in @('.claude-plugin/marketplace.json', 'plugin.json')) {
                    if (-not $archive.GetEntry($path)) { throw "Missing $path" }
                }
            }
        } finally { $archive.Dispose() }
    }
    $extracted = Join-Path $temporary 'marketplace'
    [IO.Compression.ZipFile]::ExtractToDirectory((Join-Path $temporary "packages\github-marketplace-$($metadata.version).zip"), $extracted)
    $bundledMarketplace = Get-Content (Join-Path $extracted '.claude-plugin\marketplace.json') -Raw | ConvertFrom-Json
    $bundledPluginPath = Join-Path $extracted $bundledMarketplace.plugins[0].source
    if (-not (Test-Path (Join-Path $bundledPluginPath 'plugin.json')) -or
        -not (Test-Path (Join-Path $bundledPluginPath 'skills\meeting-notes\SKILL.md'))) {
        throw 'Packaged marketplace source does not resolve to its plugin and skill.'
    }
    $mutated = Join-Path $temporary 'changed\meeting-notes'
    New-Item $mutated -ItemType Directory -Force | Out-Null
    $canonical = Join-Path $root 'samples\meeting-notes\skills\meeting-notes\SKILL.md'
    Copy-Item $canonical (Join-Path $mutated 'SKILL.md')
    Add-Content (Join-Path $mutated 'SKILL.md') "`nA changed instruction."
    & (Join-Path $root 'scripts\Build-Packages.ps1') -SkillPath $mutated -OutputPath (Join-Path $temporary 'changed-output') | Out-Null
    $changed = Get-Content (Join-Path $temporary 'changed-output\artifacts.json') -Raw | ConvertFrom-Json
    if ($changed.canonicalSha256 -eq $metadata.canonicalSha256) { throw 'Content drift was not reflected in provenance.' }
    $siteSkill = Join-Path $root 'samples\sharepoint\skills\sharepoint-site-review'
    $hostRoot = Join-Path $temporary 'host-packages'
    & (Join-Path $root 'scripts\Build-HostExamples.ps1') -OutputPath $hostRoot | Out-Null
    $hostSamples = @(
        @('excel', 'excel-pipeline-review'),
        @('powerpoint', 'powerpoint-executive-story'),
        @('sharepoint', 'sharepoint-site-review'),
        @('sharepoint', 'sharepoint-personal-brief'),
        @('word', 'word-project-brief')
    )
    foreach ($sample in $hostSamples) {
        $record = Get-Content (Join-Path $hostRoot "$($sample[0])\$($sample[1])\artifacts.json") -Raw | ConvertFrom-Json
        $source = Join-Path $root "samples\$($sample[0])\skills\$($sample[1])\SKILL.md"
        if ($record.skill -ne $sample[1] -or $record.artifacts.Count -ne 2 -or
            $record.canonicalSha256 -ne (Get-FileHash $source).Hash.ToLowerInvariant()) {
            throw "Host sample was not packaged from its canonical source: $($sample[1])"
        }
    }
    if (@(Get-ChildItem $hostRoot -Filter artifacts.json -Recurse).Count -ne $hostSamples.Count) {
        throw 'Host build produced an unexpected set of sample packages.'
    }
    $hostOutput = Join-Path $hostRoot 'sharepoint\sharepoint-site-review'
    $hostMetadata = Get-Content (Join-Path $hostOutput 'artifacts.json') -Raw | ConvertFrom-Json
    if ($hostMetadata.skill -ne 'sharepoint-site-review' -or $hostMetadata.artifacts.Count -ne 2) {
        throw 'Selected host packages have incorrect provenance or count.'
    }
    foreach ($kind in @('skill', 'onedrive-skill')) {
        $archive = [IO.Compression.ZipFile]::OpenRead((Join-Path $hostOutput "$kind-$($hostMetadata.version).zip"))
        try {
            $entryPath = if ($kind -eq 'skill') { 'SKILL.md' } else { 'sharepoint-site-review/SKILL.md' }
            $entry = $archive.GetEntry($entryPath)
            if (-not $entry) { throw "Incorrect host archive root: $entryPath" }
            $stream = $entry.Open()
            $hasher = [Security.Cryptography.SHA256]::Create()
            try {
                $hash = [Convert]::ToHexString($hasher.ComputeHash($stream))
                if ($hash -ne (Get-FileHash (Join-Path $siteSkill 'SKILL.md')).Hash) {
                    throw "Host archive content drift: $entryPath"
                }
            } finally {
                $hasher.Dispose()
                $stream.Dispose()
            }
        } finally { $archive.Dispose() }
    }
    $excelFixture = Join-Path $temporary 'pipeline.xlsx'
    & (Join-Path $root 'scripts\Build-ExcelFixture.ps1') -OutputPath $excelFixture | Out-Null
    $archive = [IO.Compression.ZipFile]::OpenRead($excelFixture)
    try {
        $documents = @{}
        foreach ($part in @('xl/worksheets/sheet1.xml', 'xl/tables/table1.xml')) {
            $entry = $archive.GetEntry($part)
            if (-not $entry) { throw "Excel fixture is missing $part." }
            $reader = [IO.StreamReader]::new($entry.Open())
            try { $documents[$part] = [xml]$reader.ReadToEnd() } finally { $reader.Dispose() }
        }
        $sheet = $documents['xl/worksheets/sheet1.xml']
        $namespace = [Xml.XmlNamespaceManager]::new($sheet.NameTable)
        $namespace.AddNamespace('m', 'http://schemas.openxmlformats.org/spreadsheetml/2006/main')
        $amounts = @($sheet.SelectNodes('//m:c/m:v', $namespace))
        $total = [decimal]0
        foreach ($amount in $amounts) {
            $total += [decimal]::Parse($amount.InnerText, [Globalization.CultureInfo]::InvariantCulture)
        }
        if ($amounts.Count -ne 6 -or $total -ne 35000) { throw 'Excel fixture numeric amounts were changed or lost.' }
        if ($sheet.SelectSingleNode('//m:c[@r="D8"]/m:v', $namespace).InnerText -ne '0' -or
            $sheet.SelectSingleNode('//m:c[@r="D7"]/m:is/m:t', $namespace).InnerText -ne 'not-a-number' -or
            $sheet.SelectSingleNode('//m:c[@r="E7"]/m:is/m:t', $namespace).InnerText -ne 'not-a-date' -or
            $sheet.SelectSingleNode('//m:c[@r="B3"]', $namespace)) {
            throw 'Excel fixture did not preserve zero, invalid inputs and missing ownership.'
        }
        if ($sheet.worksheet.sheetData.row.Count -ne 8 -or
            $documents['xl/tables/table1.xml'].table.ref -ne 'A1:E8') {
            throw 'Excel fixture table does not cover every source record and header.'
        }
    } finally { $archive.Dispose() }
    $marketplace = Get-Content (Join-Path $root '.claude-plugin\marketplace.json') -Raw | ConvertFrom-Json
    $pluginPath = Join-Path $root $marketplace.plugins[0].source
    $plugin = Get-Content (Join-Path $pluginPath 'plugin.json') -Raw | ConvertFrom-Json
    $package = Get-Content (Join-Path $root 'package.json') -Raw | ConvertFrom-Json
    if ($plugin.version -ne $package.version) { throw 'Plugin and package release versions disagree.' }
    $policy = Get-Content (Join-Path $root 'platforms\github-copilot\enterprise-policy\managed-settings.json') -Raw | ConvertFrom-Json
    if (-not (Test-Path (Join-Path $pluginPath 'skills\meeting-notes\SKILL.md'))) { throw 'Marketplace source has no canonical skill.' }
    if ($marketplace.plugins[0].name -ne $plugin.name -or
        $policy.enabledPlugins."$($plugin.name)@$($marketplace.name)" -ne $true) {
        throw 'Marketplace, plugin and enterprise-policy identifiers disagree.'
    }
    & (Join-Path $root 'scripts\Invoke-FoundrySkill.ps1') -ProjectEndpoint 'https://example.services.ai.azure.com/api/projects/example' -Operation CreateVersion -WhatIf
    Write-Host 'PASS: metadata, archive roots, packaged content hashes, manifests, and changed-source provenance.'
} finally {
    Remove-Item -LiteralPath $temporary -Recurse -Force
}
