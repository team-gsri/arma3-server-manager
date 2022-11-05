[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter()]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-SteamSecretFile not found' } })]
    [string]
    $SteamSecretFile = $(Join-Path $env:USERPROFILE .secrets/steam.txt),

    [Parameter()]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-SteamcmdExe not found' } })]
    [string]
    $SteamcmdExe = $env:Steamcmd,

    [Parameter()]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-SteamGuardExe not found' } })]
    [string]
    $SteamguardExe = $env:Steamguard,

    [Parameter(Mandatory)]
    [string]
    $Path,

    [Parameter(ValueFromPipeline)]
    [string]
    $Command,

    [Parameter()]
    [switch]
    $Quit
)

Begin {
    $CommandsFilename = $(New-TemporaryFile) ?? 'New-TemporaryFile'
    Write-Debug "Commands file: $CommandsFilename"
    Write-Debug "Install directory: $Path"
    @(
        "force_install_dir ${Path}"
        "login $(Get-Content ${SteamSecretFile}) $(& ${SteamguardExe})"
    ) | Set-Content $CommandsFilename
}

Process {
    Write-Debug $Command
    $Command | Add-Content $CommandsFilename
}

End {
    If ($Quit) { 'quit' | Add-Content "$CommandsFilename" }
    If ($PSCmdlet.ShouldProcess("$CommandsFilename", 'steamcmd runscript')) {
        & "${SteamcmdExe}" +runscript $CommandsFilename
    }
    If (Test-Path $CommandsFilename) {
        Remove-Item $CommandsFilename
    }
}