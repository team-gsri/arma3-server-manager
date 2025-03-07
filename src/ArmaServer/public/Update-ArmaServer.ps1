function Update-ArmaServer {
  [CmdletBinding(PositionalBinding)]
  param (
    [string]
    [Parameter(Mandatory, Position = 0)]
    [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
    $ConfigFilename
  )

  $Config = Import-PowerShellDataFile $ConfigFilename
  if (!((Test-Path $Config.MasterPath -PathType Container) -and (Test-Path $Config.ConfigPath -PathType Container))) {
    throw 'Server is not installed properly'
  }

  Stop-ArmaServer @PSBoundParameters
  & $PSScriptRoot/../private/Install-Missions.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Install-Configuration.ps1 @PSBoundParameters
}
