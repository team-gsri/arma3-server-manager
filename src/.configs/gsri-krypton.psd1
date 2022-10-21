@{
    Port             = 2402
    ServerAffinity   = 10
    HeadlessAffinity = 5
    
    Hostname         = '[FR] www.gsri.team | MILSIM + MODS | Krypton'
    GithubRepository = 'team-gsri/Entrainement'
    Password         = ''
    Players          = 32
    VerifySignatures = $true
    DisableChannels  = @(0,1,2,3,4,5)
    
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
        'mods\@GSRI'
    )
    ClientMods       = @(
    )
    ServerMods       = @(
    )

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\master'
    ConfigPath       = 'C:\Arma3\instances\gsri.krypton\config'
    ProfilePath      = 'C:\Arma3\instances\gsri.krypton\profile'
}