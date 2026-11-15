#requires -Version 7.0
[CmdletBinding()]
param(
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\out\host-fixtures\OGE-Pipeline-Skill-Demo.xlsx')
)
$ErrorActionPreference = 'Stop'
$records = @(Import-Csv (Join-Path $PSScriptRoot '..\samples\excel\pipeline.csv'))
$headers = @('LeadID', 'Owner', 'Stage', 'Amount', 'TargetDate')
if ($records.Count -eq 0 -or (($records[0].PSObject.Properties.Name -join ',') -ne ($headers -join ','))) {
    throw 'Pipeline fixture must contain records with the expected columns.'
}
$culture = [Globalization.CultureInfo]::InvariantCulture
$rows = [Collections.Generic.List[string]]::new()
$headerCells = for ($column = 0; $column -lt $headers.Count; $column++) {
    $cell = "$([char](65 + $column))1"
    "<c r=`"$cell`" t=`"inlineStr`"><is><t>$($headers[$column])</t></is></c>"
}
$rows.Add("<row r=`"1`">$($headerCells -join '')</row>")
for ($index = 0; $index -lt $records.Count; $index++) {
    $rowNumber = $index + 2
    $cells = for ($column = 0; $column -lt $headers.Count; $column++) {
        $value = [string]$records[$index].($headers[$column])
        if ($value.Length -eq 0) { continue }
        $cell = "$([char](65 + $column))$rowNumber"
        $number = [decimal]0
        if ($headers[$column] -eq 'Amount' -and [decimal]::TryParse($value, [Globalization.NumberStyles]::Number, $culture, [ref]$number)) {
            "<c r=`"$cell`"><v>$($number.ToString($culture))</v></c>"
        } else {
            $escaped = [Security.SecurityElement]::Escape($value)
            "<c r=`"$cell`" t=`"inlineStr`"><is><t xml:space=`"preserve`">$escaped</t></is></c>"
        }
    }
    $rows.Add("<row r=`"$rowNumber`">$($cells -join '')</row>")
}
$range = "A1:E$($records.Count + 1)"
$tableColumns = for ($column = 0; $column -lt $headers.Count; $column++) {
    "<tableColumn id=`"$($column + 1)`" name=`"$($headers[$column])`"/>"
}
# Keep date text and deliberately invalid values intact for the review fixture.
$parts = [ordered]@{
    '[Content_Types].xml' = '<?xml version="1.0" encoding="UTF-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/><Override PartName="/xl/tables/table1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.table+xml"/></Types>'
    '_rels/.rels' = '<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>'
    'xl/workbook.xml' = '<?xml version="1.0" encoding="UTF-8"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="Pipeline" sheetId="1" r:id="rId1"/></sheets></workbook>'
    'xl/_rels/workbook.xml.rels' = '<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/></Relationships>'
    'xl/worksheets/sheet1.xml' = "<?xml version=`"1.0`" encoding=`"UTF-8`"?><worksheet xmlns=`"http://schemas.openxmlformats.org/spreadsheetml/2006/main`" xmlns:r=`"http://schemas.openxmlformats.org/officeDocument/2006/relationships`"><dimension ref=`"$range`"/><sheetViews><sheetView workbookViewId=`"0`"/></sheetViews><cols><col min=`"1`" max=`"5`" width=`"20`" customWidth=`"1`"/></cols><sheetData>$($rows -join '')</sheetData><tableParts count=`"1`"><tablePart r:id=`"rId1`"/></tableParts></worksheet>"
    'xl/worksheets/_rels/sheet1.xml.rels' = '<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/table" Target="../tables/table1.xml"/></Relationships>'
    'xl/tables/table1.xml' = "<?xml version=`"1.0`" encoding=`"UTF-8`"?><table xmlns=`"http://schemas.openxmlformats.org/spreadsheetml/2006/main`" id=`"1`" name=`"PipelineData`" displayName=`"PipelineData`" ref=`"$range`" totalsRowShown=`"0`"><autoFilter ref=`"$range`"/><tableColumns count=`"5`">$($tableColumns -join '')</tableColumns><tableStyleInfo name=`"TableStyleMedium2`" showFirstColumn=`"0`" showLastColumn=`"0`" showRowStripes=`"1`" showColumnStripes=`"0`"/></table>"
}
$destination = [IO.Path]::GetFullPath($OutputPath)
New-Item (Split-Path $destination -Parent) -ItemType Directory -Force | Out-Null
$stream = [IO.File]::Create($destination)
try {
    $archive = [IO.Compression.ZipArchive]::new($stream, [IO.Compression.ZipArchiveMode]::Create, $true)
    try {
        foreach ($part in $parts.GetEnumerator()) {
            $writer = [IO.StreamWriter]::new($archive.CreateEntry($part.Key).Open(), [Text.UTF8Encoding]::new($false))
            try { $writer.Write($part.Value) } finally { $writer.Dispose() }
        }
    } finally { $archive.Dispose() }
} finally { $stream.Dispose() }
Write-Host "Synthetic Excel workbook ready: $destination"
