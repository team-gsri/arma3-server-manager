[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Filename not found')]
  [string]
  $ConfigFilename
)

Begin {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  if (-Not $isAdmin) {
    throw 'This operation requires administrator privileges'
  }
  
  $Config = Import-PowerShellDataFile $ConfigFilename
  $TranscriptPath = Join-Path $Config.ProfilePath pslogs
  Start-Transcript -OutputDirectory $TranscriptPath
}

Process {
  Stop-ArmaServer -ConfigFilename $ConfigFilename
  Install-ArmaServer -ConfigFilename $ConfigFilename
  ArmaServer-InvokeServerProcess -ConfigFilename $ConfigFilename
  ArmaServer-InvokeHeadlessProcess -ConfigFilename $ConfigFilename
}

End {
  Stop-Transcript
}
