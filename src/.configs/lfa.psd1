@{
    Port             = 2302
    ServerAffinity   = 5
    HeadlessAffinity = 10

    Hostname         = '[FR] NE-VOYENNI | LFA | www.gsri.team'
    Password         = 'vyborg'
    Players          = 32
    VerifySignatures = $false
    Update           = $true
    Headless         = $true
    DisableChannels  = @()

    Admins           = @(
        76561197967609383 # Arwyn
    )

    Mods             = @(
        583496184
        450814997
        843425103
        843577117
        1779063631
        463939057
        2822052002
        843632231
        843593391
        894678801
        2018593688
        2699465073
        333310405
        623475643
        1923321700
        2178398365
        2162043396
        1926513010
        2034767030
        773131200
        773125288
        2753746058
        2899715306
        905191399
        2841411653
        2145354279
    )
    ClientMods       = @(
    )
    ServerMods       = @(
    )

    Mission          = @{
        Type = 'Local'
        Path = 'C:\Arma3\instances\lfa\mission'
    }

    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\instances\lfa\master'
    ConfigPath       = 'C:\Arma3\instances\lfa\config'
    ProfilePath      = 'C:\Arma3\instances\lfa\profile'
}