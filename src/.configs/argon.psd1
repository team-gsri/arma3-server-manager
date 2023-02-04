@{
    Port             = 2302
    ServerAffinity   = 5
    HeadlessAffinity = 10

    Hostname         = '[FR] www.gsri.team | MILSIM + MODS | Argon'
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
    )
    ClientMods       = @(
        'C:\Arma3\mods\@Soundscape'
        'C:\Arma3\mods\@VileHUD'
        'C:\Arma3\mods\@Blastcore'
        'C:\Arma3\mods\@JSRS'
    )
    ServerMods       = @(
    )

    Mission          = @{
        Type = 'Github'
        Path = 'team-gsri/Orion'
    }

    Missions         = @{
        Github = @(
            'team-gsri/Orion'
        )
        Local  = @(            
        )
    }

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\instances\gsri.argon\master'
    ConfigPath       = 'C:\Arma3\instances\gsri.argon\config'
    ProfilePath      = 'C:\Arma3\instances\gsri.argon\profile'
}