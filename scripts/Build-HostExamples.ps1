#requires -Version 7.0
[CmdletBinding()]
param(
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\out\host-examples')
)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
foreach ($platform in Get-ChildItem (Join-Path $root 'platforms') -Directory | Sort-Object Name) {
    $skillsPath = Join-Path $root "samples\$($platform.Name)\skills"
    if (-not (Test-Path -LiteralPath $skillsPath -PathType Container)) { continue }
    foreach ($skill in Get-ChildItem $skillsPath -Directory | Sort-Object Name) {
        & (Join-Path $PSScriptRoot 'Build-Packages.ps1') -SkillPath $skill.FullName `
            -Kinds skill,onedrive-skill -OutputPath (Join-Path $OutputPath "$($platform.Name)\$($skill.Name)")
    }
}
