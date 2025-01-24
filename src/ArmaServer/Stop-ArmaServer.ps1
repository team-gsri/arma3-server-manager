[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Filename not found')]
  [string]
  $ConfigFilename
)

End {
  Write-Verbose 'Stopping server process from PID files'
  $Config = Import-PowerShellDataFile $ConfigFilename
  @(
    $(Join-Path $Config.ConfigPath headless.pid)
    $(Join-Path $Config.ConfigPath server.pid)
  ) | ArmaServer-StopProcessFromPidFile
}
