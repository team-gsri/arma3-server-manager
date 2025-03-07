function Install-ArmaServer {
  [CmdletBinding(PositionalBinding)]
  param (
    [string]
    [Parameter(Mandatory, Position = 0)]
    [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
    $ConfigFilename
  )

  Stop-ArmaServer @PSBoundParameters
  & $PSScriptRoot/../private/Remove-Keys.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Remove-Missions.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Install-Master.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Install-Addons.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Install-Keys.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Install-Missions.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Install-Configuration.ps1 @PSBoundParameters
}
