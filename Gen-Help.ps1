Write-Verbose 'Clearing old files'

if ((Test-Path .\docs) -eq $false) {
   # Notice that I'm assigning the result of New-Item to $null,
   # to avoid sending any unwanted data down the pipeline.
   $null = New-Item -ItemType Directory -Name .\docs
}

Get-ChildItem .\docs | Remove-Item

Write-Verbose 'Merging Markdown files'

if (-not (Get-Module Trackyon.Markdown -ListAvailable)) {
   Install-Module Trackyon.Markdown -Scope CurrentUser -Force
}

Merge-Markdown -InPath "$PSScriptRoot\.docs" -OutPath "$PSScriptRoot\docs"

Write-Verbose 'Creating new file'

if (-not (Get-Module platyPS -ListAvailable)) {
   Install-Module platyPS -Scope CurrentUser -Force
}

$null = New-ExternalHelp .\docs -OutputPath .\Source\en-US -Force