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
  @(
    '@NoPromptForPassword 1'
    "force_install_dir ${MasterPath}"
    "login ${Username}"
    'app_update 233780 validate'
    "force_install_dir ${WorkshopPath}"
  ) | Add-Content $CommandsFilename
}

Process {
  if ($Addon -match $WorkshopPattern) {
    "workshop_download_item 107410 $Addon validate" | Add-Content $CommandsFilename
  }
}

End {
  if ($Quit) {
    'quit' | Add-Content $CommandsFilename
  }

  if (Test-Path $CommandsFilename) {
    Get-Content -Raw $CommandsFilename | Write-Debug
  }

  If ($PSCmdlet.ShouldProcess("$CommandsFilename", 'steamcmd runscript')) {
    & steamcmd +runscript $CommandsFilename
  }

  Remove-Item $CommandsFilename -Force -ErrorAction SilentlyContinue
}
