[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path -PathType Leaf $_ }, ErrorMessage = 'File not found')]
  [string]
  $ConfigFilename
)

$Config = Import-PowerShellDataFile $ConfigFilename
$TemplatePath = Join-Path $MyInvocation.MyCommand.Module.ModuleBase .templates
$BasicFilePath = Join-Path $Config.ConfigPath basic.cfg
$ServerFilePath = Join-Path $Config.ConfigPath server.cfg
$MissionsPath = Join-Path $Config.MasterPath mpmissions
if($null -eq $Config.DefaultMission) {
  $Config.DefaultMission = (Get-ChildItem $MissionsPath -Filter *.pbo | Select-Object -First 1).BaseName
  Write-Verbose "Default mission not set, detected: $($Config.DefaultMission)"
}

# Initiliaze configuration
Write-Verbose "Removing old configurations from $($Config.ConfigPath)"
New-Item $Config.ConfigPath -ItemType Directory -Force | Out-Null
Get-ChildItem $Config.ConfigPath -Filter *.cfg | Remove-Item -Force
Write-Verbose "Update configurations from ${TemplatePath}"
Copy-Item $TemplatePath/basic.cfg $BasicFilePath
$TemplateContent = Get-Content $TemplatePath/server.cfg -Raw
$TemplateContent = $ExecutionContext.InvokeCommand.ExpandString($TemplateContent)
$TemplateContent | Set-Content $ServerFilePath
