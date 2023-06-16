[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory, ValueFromPipeline)]
  [string]
  $Addon,

  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  [string]
  $MasterPath,

  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  [string]
  $WorkshopPath,

  [Parameter()]
  [switch]
  $Quit,

  [Parameter()]
  [string]
  $Username = $env:STEAM_USERNAME,

  [Parameter()]
  [string]
  $WorkshopPattern = '^[0-9]+$'
)

Begin {
  $MasterPath = Convert-Path $MasterPath
  $WorkshopPath = Convert-Path $WorkshopPath
  $CommandsFilename = $(New-TemporaryFile) ?? 'New-TemporaryFile'
}

Process {
  if ($Addon -match $WorkshopPattern) {
    "workshop_download_item 107410 $Addon validate" | Add-Content $CommandsFilename
  }
}

End {
  if (Test-Path $CommandsFilename) {
    Get-Content -Raw $CommandsFilename | Write-Debug
  }

  If ($PSCmdlet.ShouldProcess("$CommandsFilename", 'steamcmd runscript')) {
    'app_update 233780 validate' | ArmaServer-InvokeSteamCmd -Path $MasterPath -Quit -Username $Username
    Get-Content -Raw $CommandsFilename | ArmaServer-InvokeSteamCmd -Path $WorkshopPath -Quit:$Quit -Username $Username
  }

  Remove-Item $CommandsFilename -Force -ErrorAction SilentlyContinue
}
