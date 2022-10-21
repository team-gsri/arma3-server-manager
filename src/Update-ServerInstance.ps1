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

# Stop server if running
& "$PSScriptRoot/Stop-ServerInstance.ps1" -ConfigFilename $ConfigFilename

# Download arma 3 updates
& "$PSScriptRoot/Start-Download.ps1" -ConfigFilename $ConfigFilename -Quit

# Install addons keys
Get-ChildItem -Recurse -Filter *.bikey $KeyPath | Remove-Item -Force
$Addons | ForEach-Object {
    $Path = $_
    If ($_ -Match '[0-9]+') {
        $Path = Join-Path $Config.WorkshopPath steamapps\workshop\content\107410\$_
    }
    Write-Debug "Copy BI keys from $Path"
    Get-ChildItem $Path -Recurse -Filter *.bikey | Copy-Item -Destination $KeyPath
}

# Download and install mission
Get-ChildItem ${MissionPath} -Filter *.pbo | Remove-Item
If ($null -ne $Config.GithubRepository) {
    Write-Debug "Downloading mission from GitHub repository $($Config.GithubRepository)"
    Get-Content ${GithubSecretFile} | & gh auth login --with-token
    & gh release download --repo $Config.GithubRepository --pattern *.pbo --dir ${MissionPath}
}
Else {
    $Mission = Get-ChildItem . -Filter *.pbo | Select-Object -First 1
    Write-Debug "Installing mission $Mission"
    Copy-Item $Mission $MissionPath
}

# Generate server config
If (-Not(Test-Path $Config.ConfigPath)) { New-Item $Config.ConfigPath -ItemType Directory }
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
$ServerConfig | ConvertTo-Json | Write-Debug
& "$FunctionsPath/New-ArmaServerConfig.ps1" @ServerConfig