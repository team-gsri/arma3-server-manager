[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Filename not found')]
  [string]
  $ConfigFilename,

  [switch]
  $NoDownload
)

Begin {
  $Config = Import-PowerShellDataFile $ConfigFilename
  $KeysPath = Join-Path $Config.MasterPath keys
  $MissionsPath = Join-Path $Config.MasterPath mpmissions
  $Addons = $Config.Mods + $Config.ClientMods + $Config.ServerMods | Select-Object -Unique
}

End {
  Stop-ArmaServer -ConfigFilename $ConfigFilename
  New-Item $Config.MasterPath -ItemType Directory -Force | Out-Null
  New-Item $Config.WorkshopPath -ItemType Directory -Force | Out-Null
  New-Item $KeysPath -ItemType Directory -Force | Out-Null
  Get-ChildItem -Recurse -Filter *.bikey $KeysPath | Remove-Item -Force
  if (-not $NoDownload) {
    $Addons | ArmaServer-InvokeDownload -MasterPath $Config.MasterPath -WorkshopPath $Config.WorkshopPath -Beta $Config.Beta -Quit
  }
  $Addons | ArmaServer-InstallBohemiaKeys -DestinationPath $KeysPath -WorkshopPath $Config.WorkshopPath
  $Config.Missions | ArmaServer-InstallMission -DestinationPath $MissionsPath
  ArmaServer-InstallConfig -ConfigFilename $ConfigFilename
}
