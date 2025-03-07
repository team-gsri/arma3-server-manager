[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, Position = 0)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Path must be a valid file')]
  $ConfigFilename
)

$GitHubPattern = '^[\w-]+/[\w-]+$'
$Config = Import-PowerShellDataFile $ConfigFilename
$MissionsPath = Join-Path $Config.MasterPath 'mpmissions'
"Install missions into $MissionsPath" | Write-Verbose

$Config.Missions | ForEach-Object {
  if ($_ -match $GitHubPattern) {
    Write-Verbose "Download mission from https://github.com/$_"
    if ($PSCmdlet.ShouldProcess($_, 'gh release download')) {
      & gh release download --repo $_ --pattern *.pbo --dir $MissionsPath --clobber
    }
  } else {
    Write-Verbose "Copy mission from $_ to $MissionsPath"
    Get-ChildItem $_ -Filter *.pbo -Recurse | Copy-Item -Destination $MissionsPath
  }
}
