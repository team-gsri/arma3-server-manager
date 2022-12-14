@{
    Port             = 2302
    ServerAffinity   = 5
    HeadlessAffinity = 10

    Hostname         = '[FR] www.gsri.team | MILSIM + MODS | Argon'
    Password         = ''
    Players          = 32
    VerifySignatures = $true
    Update           = $false
    Headless         = $false
    DisableChannels  = @(0, 1, 2, 3, 4, 5)

    Admins           = @(
        76561197967609383 # Arwyn
        76561198060544259 # Tyypal
    )

    Mods             = @(
        'mods\@GSRI'
    )
    ClientMods       = @(
    )
    ServerMods       = @(
    )

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\master'
    ConfigPath       = 'C:\Arma3\instances\gsri.argon\config'
    ProfilePath      = 'C:\Arma3\instances\gsri.argon\profile'
}