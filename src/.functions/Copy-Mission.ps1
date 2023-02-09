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
    $Path
)

# Remove existing missions
Get-ChildItem $MissionPath -Filter *.pbo | Remove-Item

switch ($Type) {
    'Github' {
        Write-Debug "Downloading mission from GitHub repository $($Path)"
        & gh release download --repo $Path --pattern *.pbo --dir ${MissionPath}
    }
    'Local' {
        Write-Debug "Copying missions from $Path to $MissionPath"
        Get-ChildItem $Path -Filter *.pbo | Copy-Item -Destination $MissionPath
    }
}
