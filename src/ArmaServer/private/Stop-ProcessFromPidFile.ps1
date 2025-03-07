[CmdletBinding(SupportsShouldProcess)]
param (
  [string]
  [Parameter(Mandatory, ValueFromPipeline)]
  $Filename
)

Process {
  If (Test-Path -PathType Leaf $Filename) {
    $ProcessId = Get-Content $Filename
    Write-Verbose "$Filename found, attempting to stop process $ProcessId"
    Get-Process -Id $ProcessId -ErrorAction SilentlyContinue | Stop-Process -Force
    Remove-Item -Force $Filename
  }
}
