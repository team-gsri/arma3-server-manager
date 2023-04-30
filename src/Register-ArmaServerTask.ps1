[CmdletBinding()]
param (
  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = 'File not found')]
  [string]
  $ConfigFilename,

  [Parameter()]
  [string]
  $UserId = 'LOCALSERVICE',

  [Parameter()]
  [System.DateTime]
  $At = '5am',

  [Parameter()]
  [switch]
  $Force
)

$PwshExe = (Get-Command pwsh).Path
$ConfigFilename = Resolve-Path $ConfigFilename
$ArgumentString = "-ExecutionPolicy Bypass -Command { Start-ArmaServer -ConfigFilename $ConfigFilename -Verbose }"

$SchedulerArguments = @{
  Action    = New-ScheduledTaskAction -Execute $PwshExe -Argument $ArgumentString
  Principal = New-ScheduledTaskPrincipal -UserId $UserId -LogonType ServiceAccount
  Trigger   = New-ScheduledTaskTrigger -Daily -At $At
  TaskName  = (Get-Item $ConfigFilename).BaseName
  TaskPath  = '\Arma3\'
}

Register-ScheduledTask -Force:$Force @SchedulerArguments
