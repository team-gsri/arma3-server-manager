[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, ValueFromPipeline)]
  $Addon,

  [string]
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  $WorkshopPath,

  [string]
  [Parameter()]
  $WorkshopPattern = '^[0-9]+$',

  [int]
  [Parameter()]
  $AppId = 107410
)

Process {
  return ($Addon -match $WorkshopPattern) ? (Join-Path $WorkshopPath "steamapps/workshop/content/$AppId/$Addon") : $Addon
}
