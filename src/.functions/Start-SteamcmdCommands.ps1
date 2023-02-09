[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [string]
    $Path,

    [Parameter(ValueFromPipeline)]
    [string]
    $Command,

    [Parameter()]
    [switch]
    $Quit,

    [Parameter()]
    [string]
    $Username = $env:STEAM_USERNAME
)

Begin {
    $CommandsFilename = $(New-TemporaryFile) ?? 'New-TemporaryFile'
    Write-Debug "Commands file: $CommandsFilename"
    Write-Debug "Install directory: $Path"
    Write-Debug "Username: ${Username}"
    @(
        "force_install_dir ${Path}"
        "login ${Username}"
    ) | Set-Content $CommandsFilename
}

Process {
    Write-Debug $Command
    $Command | Add-Content $CommandsFilename
}

End {
    If ($Quit) { 'quit' | Add-Content "$CommandsFilename" }
    If ($PSCmdlet.ShouldProcess("$CommandsFilename", 'steamcmd runscript')) {
        & steamcmd +runscript $CommandsFilename
    }
    If (Test-Path $CommandsFilename) {
        Remove-Item $CommandsFilename
    }
}