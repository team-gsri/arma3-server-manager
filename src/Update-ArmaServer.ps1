[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename,

    [Parameter()]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-GithubSecretFile not found' } })]
    [string]
    $GithubSecretFile = $(Join-Path $env:USERPROFILE .secrets/github.txt)
)

# Configuration
$Config = Import-PowerShellDataFile $ConfigFilename
$TemplatePath = Join-Path $PSScriptRoot .templates
$FunctionsPath = Join-Path $PSScriptRoot .functions
$MissionPath = Join-Path $Config.MasterPath mpmissions
$KeyPath = Join-Path $Config.MasterPath keys
$Addons = $config.Mods + $config.ClientMods + $config.ServerMods | Select-Object -Unique

#  Update content
& "$PSScriptRoot/Stop-ArmaServer.ps1" -ConfigFilename $ConfigFilename
& "$PSScriptRoot/Start-Download.ps1" -ConfigFilename $ConfigFilename -Quit
$Addons | & "$FunctionsPath/Copy-BohemiaKeys.ps1" -WorkshopPath $Config.WorkshopPath -DestinationPath $KeyPath
& "$FunctionsPath/Copy-Mission.ps1" -MissionPath $MissionPath -GithubSecretFile $GithubSecretFile -Type $config.Mission.Type -Path $config.Mission.Path

# Generate server config
If (-Not(Test-Path $Config.ConfigPath)) { New-Item $Config.ConfigPath -ItemType Directory | Out-Null }
If (Test-Path $Config.ConfigPath) { Get-ChildItem $Config.ConfigPath -Filter *.cfg | Remove-Item -Force }
Copy-Item $TemplatePath/basic.cfg $(Join-Path $Config.ConfigPath basic.cfg)
$Mission = Get-ChildItem $MissionPath -Filter *.pbo | Select-Object -First 1
$ServerConfig = @{
    Hostname         = $Config.Hostname
    Password         = $Config.Password
    Players          = $Config.Players
    Admins           = $Config.Admins
    Mission          = $Mission.BaseName
    VerifySignatures = $Config.VerifySignatures
    DisableChannels  = $Config.DisableChannels
    File             = Join-Path $Config.ConfigPath server.cfg
}
Write-Debug 'Updating server configuration with these parameters:'
$ServerConfig | ConvertTo-Json -Compress -AsArray | Write-Debug
& "$FunctionsPath/New-ArmaServerConfig.ps1" @ServerConfig