@{
    Port             = 2302
    ServerAffinity   = 5
    HeadlessAffinity = 10

    Hostname         = '[FR] GROUPE DE COMBAT AEROPORTE | www.gsri.team'
    Password         = ''
    Players          = 32
    VerifySignatures = $true
    Update           = $true
    Headless         = $true
    DisableChannels  = @(0, 1, 2, 3, 4, 5)

    Admins           = @(
        76561197967609383 # Arwyn
        76561198060544259 # Tyypal
    )

    Mods             = @(
        450814997   # CBA
        463939057   # ACE
        333310405   # Enhanced Movement
        2034363662  # Enhanced Movement Rework
        894678801   # TFAR beta
        1781990846  # AMF
        583496184   # CUP core
        583544987   # CUP maps
        633789490   # Fallujah
    )
    ClientMods       = @(
        1937479604  # GSRI Zeus Manager
        1779063631  # Zeus Enhanced
        2018593688  # Zeus Enhanced ACE 3 compat
        721359761   # VCOM AI
    )
    ServerMods       = @(
        1937479604  # GSRI Zeus Manager
        1779063631  # Zeus Enhanced
        2018593688  # Zeus Enhanced ACE 3 compat
        721359761   # VCOM AI
    )

    Mission          = @{
        Type = 'Github'
        Path = 'team-gsri/Scorpion'
    }

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\instances\gcap\master'
    ConfigPath       = 'C:\Arma3\instances\gcap\config'
    ProfilePath      = 'C:\Arma3\instances\gcap\profile'
}