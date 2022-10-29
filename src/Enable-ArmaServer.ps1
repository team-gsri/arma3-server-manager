[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-ConfigFilename not found' } })]
    [string]
    $ConfigFilename
)

$TaskInfo = @{
    TaskName = (Get-Item $ConfigFilename).BaseName
    TaskPath = '\Arma3\'
}


$Measure = Get-ScheduledTask | Where-Object {
    ($_.TaskPath -eq $TaskInfo.TaskPath) -and
    ($_.TaskName -eq $TaskInfo.TaskName)
} | Measure-Object

if ($Measure.Count -eq 0) {
    & "$PSScriptRoot/.functions/New-ArmaServerTask.ps1" -ConfigFilename $ConfigFilename
}

Enable-ScheduledTask @TaskInfo