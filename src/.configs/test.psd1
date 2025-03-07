@{
    Port             = 2302
    ServerAffinity   = 5
    HeadlessAffinity = 10

    Hostname         = 'test server'
    DefaultMission   = 'CONT_Scorpion.Malden'
    Password         = 'password'
    Players          = 32
    VerifySignatures = $true
    Headless         = $false
    DisableChannels  = @(0, 2, 3, 4, 5)

    Admins           = @(
        76561197967609383
    )

    Mods             = @(
        450814997  # CBA
    )
    ClientMods       = @(
        1538673636 # VileHUD
    )
    ServerMods       = @(
    )

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\instances\gsri.argon\master'
    ConfigPath       = 'C:\Arma3\instances\gsri.argon\config'
    ProfilePath      = 'C:\Arma3\instances\gsri.argon\profile'

    Missions         = @(
        'team-gsri/Scorpion'
    )
}
