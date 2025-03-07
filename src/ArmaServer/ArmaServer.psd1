@{
  Author            = 'GSRI'
  CompanyName       = 'GSRI'
  Copyright         = '(c) GSRI. All rights reserved.'

  ModuleVersion     = '0.0.0'
  GUID              = '2d3966b5-34c7-47ac-9263-29ee72bf31b1'
  Description       = 'A powershell module used to manage Arma 3 dedicated servers'
  HelpInfoURI       = 'https://github.com/team-gsri/arma3-server-manager#README'

  PrivateData       = @{
    ProjectUri = 'https://github.com/team-gsri/arma3-server-manager'
    LicenseUri = 'https://github.com/team-gsri/arma3-server-manager/blob/master/LICENSE'
  }

  RootModule        = 'ArmaServer.psm1'

  FunctionsToExport = @(
    'Install-ArmaServer'
    'Update-ArmaServer'
    'Start-ArmaServer'
    'Stop-ArmaServer'
  )
}
