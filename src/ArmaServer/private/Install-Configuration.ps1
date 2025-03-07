[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
New-Item $Config.ConfigPath -ItemType Directory -Force | Out-Null
"Install configuration to $($Config.ConfigPath)" | Write-Verbose

$TemplatePath = Join-Path $PSScriptRoot '../templates'
$BasicFilePath = Join-Path $Config.ConfigPath basic.cfg
$ServerFilePath = Join-Path $Config.ConfigPath server.cfg
$MissionsPath = Join-Path $Config.MasterPath 'mpmissions'
$Config.DefaultMission ??= & $PSScriptRoot/Get-DefaultMission.ps1 -MissionsPath $MissionsPath

$TemplateContent = Get-Content $TemplatePath/server.cfg -Raw
$TemplateContent = $ExecutionContext.InvokeCommand.ExpandString($TemplateContent)
$TemplateContent | Set-Content $ServerFilePath
Copy-Item $TemplatePath/basic.cfg $BasicFilePath
