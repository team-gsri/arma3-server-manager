@{
  ModuleVersion     = '0.0.1'
  
  RootModule        = 'ArmaServer.psm1'
  GUID              = '2d3966b5-34c7-47ac-9263-29ee72bf31b1'
  Author            = 'www.gsri.team'
  CompanyName       = 'GSRI'
  Copyright         = '(c) GSRI. All rights reserved.'
  Description       = 'This module handles Arma 3 dedicated servers'
  VariablesToExport = '*'
  FunctionsToExport = @(
    'Install-ArmaServer'
    'Start-ArmaServer'
    'Stop-ArmaServer'
    'Register-ArmaServerTask'
    'Get-ArmaServerTask'
  )
  PrivateData       = @{
    ProjectUri = 'https://github.com/team-gsri/arma3-server-manager'
    LicenseUri = 'https://github.com/team-gsri/arma3-server-manager/blob/master/LICENSE'
  }
}
