[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory, ValueFromPipeline)]
  [string]
  $AddonName,

  [Parameter(Mandatory)]
  [string]
  $DestinationPath,

  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  [string]
  $WorkshopPath,

  [Parameter()]
  [string]
  $WorkshopPattern = '^[0-9]+$'
)

Process {
  $AddonPath = switch ($true) {
    ($AddonName -match $WorkshopPattern) {
      Write-Debug "$AddonName is a workshop mod"
      Join-Path $WorkshopPath "steamapps\workshop\content\107410\$AddonName"
    }
    Default {
      Write-Debug "$AddonName is an absolute path"
      $AddonName
    }
  }

  Write-Verbose "Copy addon keys from $AddonPath"
  Get-ChildItem $AddonPath -Recurse -Filter '*.bikey' | Copy-Item -Destination $DestinationPath
}
