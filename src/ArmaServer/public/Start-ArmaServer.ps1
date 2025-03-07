function Start-ArmaServer {
  [CmdletBinding(PositionalBinding)]
  param (
    [string]
    [Parameter(Mandatory, Position = 0)]
    [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
    $ConfigFilename
  )

  Stop-ArmaServer @PSBoundParameters
  & $PSScriptRoot/../private/Invoke-ArmaServer.ps1 @PSBoundParameters
  & $PSScriptRoot/../private/Invoke-ArmaHeadless.ps1 @PSBoundParameters
}
