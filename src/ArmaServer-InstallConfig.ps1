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

# Initiliaze configuration
Write-Verbose "Removing old configurations from $($Config.ConfigPath)"
New-Item $Config.ConfigPath -ItemType Directory -Force | Out-Null
Get-ChildItem $Config.ConfigPath -Filter *.cfg | Remove-Item -Force
Write-Verbose "Update configurations from ${TemplatePath}"
Copy-Item $TemplatePath/basic.cfg $BasicFilePath
$TemplateContent = Get-Content $TemplatePath/server.cfg -Raw
$TemplateContent = $ExecutionContext.InvokeCommand.ExpandString($TemplateContent)
$TemplateContent | Set-Content $ServerFilePath
