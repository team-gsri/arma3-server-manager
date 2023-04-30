@{
    Port             = 2402
    ServerAffinity   = 10
    HeadlessAffinity = 5

    Hostname         = '[FR] www.gsri.team | Argon'
    DefaultMission   = 'FORM_Entrainement.Malden'
    Password         = ''
    Players          = 32
    VerifySignatures = $true
    Headless         = $false
    DisableChannels  = @(0, 2, 3, 4, 5)

    Admins           = @(
        76561198117240462 # Atta
        76561197967609383 # Arwyn
        76561198141945831 # Cheitan
        76561198117399118 # Josh
        76561198132293246 # Phileas
    )

    Mods             = @(
        1936413749 # R_unfold
        450814997  # CBA
        463939057  # ACE
        1413218487 # Lesh towing mod
        1779063631 # Zeus Enhanced
        820924072  # Backpack on chest
        333310405  # Enhanced Movement
        751965892  # ACRE
        730310357  # Advanced Urban Rappeling
        1962620806 # Advanced Urban Rappeling ACE
        615007497  # Advanced Sling Loading
        1378046829 # Advanced Weapon Mounting
        346726922  # ASCZ_Heads
        2822758266 # Deformer
        2034363662 # Enhanced Movement Rework
        2911467399 # GSRI Skydiving
        2868536090 # GSRI VIP Identification and Protection
        2876103099 # GSRI Zeus Manager
        2020940806 # KAT - Advanced Medical
        313041182  # L3-GPNVG18 Panoramic Night Vision
        1858075458 # LAMBS_Danger.fsm
        1808238502 # LAMBS_Suppression
        2273016995 # Marshall's ACE 3 Tandem Mod
        1508091616 # Metis Marker
        561177050  # Mission Enhanced Little Bird
        1310581330 # MRH Satellite
        887302721  # Paddle
        504690333  # PLP Containers
        1481341874 # Radio animations for ACRE
        1644515857 # RKSL Studios - Airfield Support Tug
        2422853226 # Seb's Briefing Table
        699630614  # Specialist Military Arms
        508476583  # TF47 Launchers
        1381327410 # vurtual's Car Seat
        2018593688 # Zeus Enhanced - ACE3 Compatibility
        2963740003 # GSRI Gear
    )
    ClientMods       = @(        
        861133494  # JSRS
        1429098683 # JSRS reloading
        2071633001 # JSRS SMA
        825179978  # Enhanced Soundscape
        2938312887 # Enhanced Soundscape Plus
        2257686620 # Blastcore
        1538673636 # VileHUD
    )
    ServerMods       = @(
        'C:\Arma3\mods\@AIDC'
        'C:\Arma3\mods\@CFBAI'
    )
    
    WorkshopPath     = 'C:\Arma3'
    MasterPath       = 'C:\Arma3\instances\gsri.krypton\master'
    ConfigPath       = 'C:\Arma3\instances\gsri.krypton\config'
    ProfilePath      = 'C:\Arma3\instances\gsri.krypton\profile'

    Missions         = @(
        'team-gsri/Entrainement'
    )
}