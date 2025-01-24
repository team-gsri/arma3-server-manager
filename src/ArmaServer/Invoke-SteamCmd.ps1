[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory, ValueFromPipeline)]
  [string]
  $Command,

  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  [string]
  $Path,

  [Parameter()]
  [switch]
  $Quit,

  [Parameter()]
  [string]
  $Username = $env:STEAM_USERNAME
)

Begin {
  $Path = Convert-Path $Path
  $CommandsFilename = $(New-TemporaryFile) ?? 'New-TemporaryFile'
  @(
    '@NoPromptForPassword 1'
    "force_install_dir ${Path}"
    "login ${Username}"
  ) | Add-Content $CommandsFilename
}

Process {
  $Command | Add-Content $CommandsFilename
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
