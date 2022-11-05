[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename,

    [Parameter()]
    [string]
    $UserId = 'LOCALSERVICE',

    [Parameter()]
    [System.DateTime]
    $At = '5am'
)

$ConfigFilename = Resolve-Path $ConfigFilename
$PwshExe = '"C:\Program Files\PowerShell\7\pwsh.exe"'
$File = Join-Path $PSScriptRoot New-ArmaServerProcess.ps1
$ArgumentString = "-ExecutionPolicy Bypass -File $File -ConfigFilename $ConfigFilename"

$SchedulerArguments = @{
    Action    = New-ScheduledTaskAction -Execute $PwshExe -Argument $ArgumentString
    Principal = New-ScheduledTaskPrincipal -UserId $UserId -LogonType ServiceAccount
    Trigger   = New-ScheduledTaskTrigger -Daily -At $At
    TaskName  = (Get-Item $ConfigFilename).BaseName
    TaskPath  = '\Arma3\'
}

Write-Debug "$PwshExe $ArgumentString"
Register-ScheduledTask @SchedulerArguments
