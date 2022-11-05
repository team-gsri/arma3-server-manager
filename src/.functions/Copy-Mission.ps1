[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $MissionPath,

    [Parameter()]
    [string]
    $GithubRepository,

    [Parameter()]
    [ValidateScript({ If (Test-Path $_ -PathType Leaf) { $true } Else { Throw '-GithubSecretFile not found' } })]
    [string]
    $GithubSecretFile = $(Join-Path $env:USERPROFILE .secrets/github.txt)
)

# Create directory if not exist
if (-Not (Test-Path $MissionPath)) {
    New-Item -ItemType Directory $MissionPath
}

# Remove existing missions
Get-ChildItem $MissionPath -Filter *.pbo | Remove-Item

switch ($true) {
    ($null -ne $GithubRepository) {
        # Download from GitHub
        Write-Debug "Downloading mission from GitHub repository $($GithubRepository)"
        Get-Content ${GithubSecretFile} | & gh auth login --with-token
        & gh release download --repo $GithubRepository --pattern *.pbo --dir ${MissionPath}
    }
    Default {
        $Mission = Get-ChildItem . -Filter *.pbo | Select-Object -First 1
        Write-Debug "Installing mission $Mission"
        Copy-Item $Mission $MissionPath
    }

}