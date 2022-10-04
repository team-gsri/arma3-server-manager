[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename
)

function Stop-ProcessFromPidFile {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Filename
    )

    Process {
        If (Test-Path -PathType Leaf $Filename) {
            Get-Process -Id $(Get-Content $Filename) | Stop-Process
        }
    }

    End {
        If (Test-Path -PathType Leaf $Filename) {
            Remove-Item -Force $Filename
        }
    }
}

$Config = Import-PowerShellDataFile $ConfigFilename
Stop-ProcessFromPidFile -Filename $(Join-Path $Config.ConfigPath headless.pid)
Stop-ProcessFromPidFile -Filename $(Join-Path $Config.ConfigPath server.pid)