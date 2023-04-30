[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'Filename not found')]
  [string]
  $ConfigFilename
)

Begin {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  if (-Not $isAdmin) {
    throw 'This operation requires administrator privileges'
  }

  $Config = Import-PowerShellDataFile $ConfigFilename
  $KeysPath = Join-Path $Config.MasterPath keys
  $MissionsPath = Join-Path $Config.MasterPath mpmissions
  $Addons = $Config.Mods + $Config.ClientMods + $Config.ServerMods | Select-Object -Unique
}

End {
  Stop-ArmaServer -ConfigFilename $ConfigFilename
  $Addons | ArmaServer-InvokeDownload -MasterPath $Config.MasterPath -WorkshopPath $Config.WorkshopPath -Quit
  $Addons | ArmaServer-InstallBohemiaKeys -DestinationPath $KeysPath -WorkshopPath $Config.WorkshopPath
  $Config.Missions | ArmaServer-InstallMission -DestinationPath $MissionsPath
  ArmaServer-InstallConfig -ConfigFilename $ConfigFilename
}
