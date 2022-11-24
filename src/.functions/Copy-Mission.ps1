[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $MissionPath,

    [Parameter()]
    [string]
    $Type,

    [Parameter()]
    [string]
    $Path,

    [Parameter()]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-GithubSecretFile not found' } })]
    [string]
    $GithubSecretFile = $(Join-Path $env:USERPROFILE .secrets/github.txt)
)

# Remove existing missions
Get-ChildItem $MissionPath -Filter *.pbo | Remove-Item

switch ($Type) {
    'Github' {
        Write-Debug "Downloading mission from GitHub repository $($Path)"
        Get-Content ${GithubSecretFile} | & gh auth login --with-token
        & gh release download --repo $Path --pattern *.pbo --dir ${MissionPath}
    }
    'Local' {
        $Mission = Get-ChildItem $Path -Filter *.pbo | Select-Object -First 1
        Write-Debug "Installing mission $Mission"
        Copy-Item $Mission $MissionPath
    }
}
