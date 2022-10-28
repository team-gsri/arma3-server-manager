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

$TaskArguments = @{
    ExecutionPolicy = 'Bypass'
    File            = Join-Path $PSScriptRoot .functions/Start-ArmaServerProcess.ps1
    ConfigFilename  = $ConfigFilename
}

$PwshExe = 'C:\Program Files\PowerShell\7\pwsh.exe'
$ArgumentString = ($TaskArguments.Keys | ForEach-Object { "-$_ $($TaskArguments[$_])" }) -Join ' '

$SchedulerArguments = @{
    Action    = New-ScheduledTaskAction -Execute -Argument $ArgumentString
    Principal = New-ScheduledTaskPrincipal -UserId $UserId -LogonType ServiceAccount
    Trigger   = New-ScheduledTaskTrigger -Daily -At $At
    TaskName  = (Get-Item $ConfigFilename).BaseName
    TaskPath  = /Arma3
}

Write-Debug "$PwshExe $ArgumentString"
Register-ScheduledTask @SchedulerArguments
