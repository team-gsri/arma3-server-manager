[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory, ValueFromPipeline)]
  [string]
  $Mission,

  [Parameter(Mandatory)]
  [string]
  $DestinationPath,

  [Parameter()]
  [string]
  $GitHubPattern = '^[\w-]+/[\w-]+$'
)

Begin {
  Write-Verbose "Removing old missions from $DestinationPath"
  New-Item $DestinationPath -ItemType Directory -Force | Out-Null
  Get-ChildItem $DestinationPath -Filter *.pbo | Remove-Item
}

Process {
  switch ($true) {
    ($Mission -match $GitHubPattern) {
      Write-Verbose "Download mission from https://github.com/$Mission"
      if ($PSCmdlet.ShouldProcess($Mission, 'gh release download')) {
        & gh release download --repo $Mission --pattern *.pbo --dir $DestinationPath
      }
    }
    Default {
      Write-Verbose "Copy mission from $Mission to $DestinationPath"
      Get-ChildItem $Mission -Filter *.pbo -Recurse | Copy-Item -Destination $DestinationPath
    }
  }
}