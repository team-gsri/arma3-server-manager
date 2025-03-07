[CmdletBinding()]
param (
  [Parameter(Mandatory)]
  [semver]
  $Version,

  [Parameter(Mandatory)]
  [string]
  $ApiKey
)

$ModuleName = 'ArmaServer'
$Root = Join-Path $PSScriptRoot '..' | Convert-Path
$Module = Join-Path $Root src, $ModuleName
$ManifestFile = Join-Path $Module "$ModuleName.psd1"

Update-ModuleManifest -ModuleVersion $Version $ManifestFile
Publish-Module -Path $Module -NuGetApiKey $ApiKey
