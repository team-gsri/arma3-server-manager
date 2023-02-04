@{
    Port             = 2602
    ServerAffinity   = 5
    HeadlessAffinity = 10

    Hostname         = '[FR] www.gsri.team | MILSIM + MODS | Xeon'
    Password         = ''
    Players          = 32
    VerifySignatures = $true
    Update           = $true
    Headless         = $false
    DisableChannels  = @(0, 2, 3, 4, 5)

    Admins           = @(
        76561197967609383 # Arwyn
        76561198060544259 # Tyypal
    )

    Mods             = @(
        'C:\Arma3\mods\@GSRI'
        1252091296
    )
    ClientMods       = @(
        'C:\Arma3\mods\@VileHUD'
        'C:\Arma3\mods\@Soundscape'
        'C:\Arma3\mods\@Blastcore'
        'C:\Arma3\mods\@JSRS'
    )
    ServerMods       = @(
    )

    Mission          = @{
        Type = 'Local'
        Path = 'C:\Arma3\instances\gsri.xeon\mission'
    }

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\instances\gsri.xeon\master'
    ConfigPath       = 'C:\Arma3\instances\gsri.xeon\config'
    ProfilePath      = 'C:\Arma3\instances\gsri.xeon\profile'
}