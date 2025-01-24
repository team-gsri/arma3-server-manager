[CmdletBinding()]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'File not found')]
  [string]
  $ConfigFilename
)

$TaskInfo = @{
  TaskName = (Get-Item $ConfigFilename).BaseName
  TaskPath = '\Arma3\'
}

Get-ScheduledTask @TaskInfo