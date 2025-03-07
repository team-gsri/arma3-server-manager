[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  $MissionsPath
)

'No default mission set' | Write-Verbose
$Mission = Get-ChildItem $MissionsPath -File -Filter '*.pbo' | Select-Object -First 1
if ($null -eq $Mission) {
  'No mission was installed on the server !' | Write-Error
}

"Default mission set to $Mission" | Write-Verbose
return $Mission
