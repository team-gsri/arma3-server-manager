[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory, ValueFromPipeline)]
  [string]
  $Path,
    
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  [string]
  $WorkshopPath,

  [Parameter()]
  [string]
  $WorkshopPattern = '^[0-9]+$'
)

Process {
  return ($Path -match $WorkshopPattern) ? (Join-Path $WorkshopPath "steamapps/workshop/content/107410/$Path") : $Path
}