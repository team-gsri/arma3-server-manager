[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory, ValueFromPipeline)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'File not found')]
  [string]
  $Path,

  [Parameter(Mandatory)]
  [string]
  $DestinationPath,

  [Parameter()]
  [switch]
  $Force
)

Begin {
  if (Test-Path $DestinationPath) {
    if ($Force) {
      Write-Debug 'Overwrite existing destination file'
      '' | Set-Content $DestinationPath
    } else {
      throw "$DetinationPath already exist, use -Force to overwrite"
    }
  }
}

Process {
  Write-Verbose "Add $Path to $DestinationPath"
  @(
    "function $(Split-Path $Path -LeafBase) {"
    (Get-Content $Path -Raw)
    '}') | Add-Content $DestinationPath
}