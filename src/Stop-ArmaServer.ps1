[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Filename not found')]
  [string]
  $ConfigFilename
) 

End {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  if (-Not $isAdmin) {
    throw 'This operation requires administrator privileges'
  }
  
  Write-Verbose 'Stopping server process from PID files'
  $Config = Import-PowerShellDataFile $ConfigFilename
  @(
    $(Join-Path $Config.ConfigPath headless.pid)
    $(Join-Path $Config.ConfigPath server.pid)
  ) | ArmaServer-StopProcessFromPidFile
}