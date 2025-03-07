function Stop-ArmaServer {
  [CmdletBinding(PositionalBinding)]
  param (
    [string]
    [Parameter(Mandatory, Position = 0)]
    [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
    $ConfigFilename
  )

  Write-Verbose 'Stopping server process from PID files'
  $Config = Import-PowerShellDataFile $ConfigFilename
  @(
    $(Join-Path $Config.ConfigPath headless.pid)
    $(Join-Path $Config.ConfigPath server.pid)
  ) | & $PSScriptRoot/../private/Stop-ProcessFromPidFile.ps1
}
