[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Filename not found')]
  [string]
  $ConfigFilename
)

Begin {
  $Config = Import-PowerShellDataFile $ConfigFilename
  $TranscriptPath = Join-Path $Config.ProfilePath pslogs
  Start-Transcript -OutputDirectory $TranscriptPath
}

Process {
  Stop-ArmaServer -ConfigFilename $ConfigFilename
  Install-ArmaServer -ConfigFilename $ConfigFilename
  ArmaServer-InvokeServerProcess -ConfigFilename $ConfigFilename
  if ($Config.Headless) {
    ArmaServer-InvokeHeadlessProcess -ConfigFilename $ConfigFilename
  }
}

End {
  Stop-Transcript
}
