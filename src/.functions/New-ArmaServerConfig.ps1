[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Hostname,

    [Parameter()]
    [string]
    $Password,

    [Parameter()]
    [int]
    $Players,

    [Parameter()]
    [long[]]
    $Admins,

    [Parameter()]
    [string]
    $Mission,

    [Parameter()]
    [switch]
    $VerifySignatures,

    [Parameter()]
    [int[]]
    $DisableChannels,

    [Parameter()]
    [string]
    $File
)

$PasswordAdmin = (1..32 | ForEach-Object { '{0:x2}' -f (Get-Random -Maximum 256) }) -join ''

$_Hostname = """$Hostname"""
$_Password = """$Password"""
$_MaxPlayers = $Players
$_Admins   = "{ ""$($Admins -Join '","')"" }"
$_PasswordAdmin = """$PasswordAdmin"""
$_Mission = """$Mission"""
$_DisableChannels = "{ $($DisableChannels -Join ',') }"
$_VerifySignatures = $VerifySignatures ? 2 : 0

'' | Set-Content $File
Get-Content ../.templates/server.cfg | ForEach-Object {
    $ExecutionContext.InvokeCommand.ExpandString($_) | Add-Content $File
}
