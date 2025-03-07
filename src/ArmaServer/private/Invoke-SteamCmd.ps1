[CmdletBinding(SupportsShouldProcess)]
param (
  [string[]]
  [Parameter(Mandatory)]
  $Commands,

  [string]
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  $Path,

  [string]
  [Parameter()]
  $Username = $env:STEAM_USERNAME
)

$Commands = @(
  '@NoPromptForPassword 1'
  "force_install_dir ${Path}"
  "login ${Username}"
) + $Commands + @('quit')

$CommandsFilename = $(New-TemporaryFile) ?? 'New-TemporaryFile'
$Commands | Set-Content $CommandsFilename
$Commands | Write-Debug

If ($PSCmdlet.ShouldProcess("$CommandsFilename", 'steamcmd runscript')) {
  & steamcmd +runscript $CommandsFilename
}

Remove-Item $CommandsFilename -Force -ErrorAction SilentlyContinue
