[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory, ValueFromPipeline)]
    [string]
    $Filename
)

Process {
    If (Test-Path -PathType Leaf $Filename) {
        Get-Process -Id $(Get-Content $Filename) -ErrorAction SilentlyContinue | Stop-Process -Force
        Remove-Item -Force $Filename
    }
}
