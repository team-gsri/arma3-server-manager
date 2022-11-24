@{
    Port             = 2302
    ServerAffinity   = 5
    HeadlessAffinity = 10

    Hostname         = '[FR] SIEGE DE CALAIS | LFA | www.gsri.team'
    Password         = 'dynamo'
    Players          = 32
    VerifySignatures = $false
    Update           = $true
    Headless         = $true
    DisableChannels  = @()

    Admins           = @(
        76561197967609383 # Arwyn
    )

    Mods             = @(
        450814997
        583496184
        1779063631
        463939057
        2648308937
        1868302880
        894678801
        2018593688
        333310405
        623475643
        2699465073
        641305739
        1380910978
        891433622
        1878095865
        773759919
        828493030
        2020372071
        2811202098
        1310692379
        2423977008
        2842504702
        2066111722
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