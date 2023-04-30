[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [semver]
    $Version,

    [Parameter(Mandatory)]
    [string]
    $ApiKey
)

$Root = Convert-Path $PSScriptRoot/..
$Sources = Join-Path $Root src
$Builds = Join-Path $Root build
$Destination = Join-Path $Root out/ArmaServer

Copy-Item $Sources/.templates $Destination/.templates -Recurse -Force
Copy-Item $Builds/ArmaServer.psd1 $Destination/ArmaServer.psd1 -Force
Get-ChildItem $Sources -Filter '*.ps1' | & $Builds/New-PowershellModuleFile.ps1 -DestinationPath $Destination/ArmaServer.psm1 -Force
Import-PowerShellDataFile $Destination/ArmaServer.psd1 | ConvertTo-Json | Write-Verbose
Get-ChildItem -Recurse $Destination
Update-ModuleManifest -ModuleVersion $Version $Destination/ArmaServer.psd1
Publish-Module -Path $Destination -NuGetApiKey $ApiKey