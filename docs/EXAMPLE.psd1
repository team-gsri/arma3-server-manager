@{
  # main port used by the server
  Port             = 2302

  # bitmask for CPU affinity of the server
  # recommended 2 physical threads
  # do not share ALU if multithreaded
  ServerAffinity   = 5

  # bitmask for CPU affinity of the headless client
  # recommended 2 physical threads
  # do not share ALU if multithreaded
  HeadlessAffinity = 10

  # name of the server visible on the launcher
  Hostname         = '[FR] SERVER NAME'

  # name of the mission the server will load at start
  DefaultMission   = 'CONT_Orion.Malden'

  # password for client connection
  Password         = 'bouh!'

  # max players for the server
  Players          = 32

  # wether the server should verify clients pbo signatures
  VerifySignatures = $true

  # wether to start a headless client with the server
  Headless         = $true

  # radio channels to disable, see https://community.bistudio.com/wiki/enableChannel
  DisableChannels  = @(0, 1, 2, 3, 4, 5)

  # optional steam beta channel
  Beta             = 'creatordlc'

  # Path where workshop mods get downloaded
  WorkshopPath     = 'C:\Arma3'

  # Path for the Arma3 server executable
  MasterPath       = 'C:\Arma3\instances\abcd\master'

  # Path for server.cfg, basic.cfg, and pid files
  ConfigPath       = 'C:\Arma3\instances\abcd\config'

  # Path for the server profile
  ProfilePath      = 'C:\Arma3\instances\abcd\profile'

  # steamid of players allowed to login as admin on the server
  Admins           = @(
    76561197967609383 # Arwyn
  )

  # list of mods used both on clients and server
  Mods             = @(
    # workshop item id
    450814997 # CBA

    # absolute path to a local mod
    'C:\mods\@GSRI'

    # relative path to master (useful for CDLC)
    'spe'
  )

  # list of mods whose keys get added to the server
  ClientMods       = @()

  # list of mods used on the server but not by clients
  ServerMods       = @()

  # missions to install on the server
  Missions         = @(
    # github repository
    # will download .pbo files from latest GitHub Release
    'team-gsri/Orion'

    # absolute path to directory
    # will copy all .pbo files recursively
    'C:\Arma3\instances\abcd\missions'
  )
}
