@{
    Port             = 2402
    ServerAffinity   = 10
    HeadlessAffinity = 5

    Hostname         = '[FR] www.gsri.team | MILSIM + MODS | Krypton'
    GithubRepository = 'team-gsri/Entrainement'
    Password         = ''
    Players          = 32
    VerifySignatures = $true
    Update           = $true
    Headless         = $false
    DisableChannels  = @()

    Admins           = @(
        76561198117240462 # Atta
        76561197967609383 # Arwyn
        76561198141945831 # Cheitan
        76561198117399118 # Josh
        76561198132293246 # Phileas
        76561198029681169 # Seenri
        76561198012668905 # Syh
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

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\instances\gsri.krypton\master'
    ConfigPath       = 'C:\Arma3\instances\gsri.krypton\config'
    ProfilePath      = 'C:\Arma3\instances\gsri.krypton\profile'
}