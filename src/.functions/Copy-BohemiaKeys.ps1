[CmdletBinding()]
param (
    [Parameter(ValueFromPipeline)]
    [string]
    $Addon,

    [Parameter(Mandatory)]
    [string]
    $DestinationPath,

    [Parameter(Mandatory)]
    [string]
    $WorkshopPath,

    [Parameter()]
    [uri]
    $OfficialKeysUri = 'https://arma.gsri.team/legacy/keys.zip'
)

Begin {
    if (-Not (Test-Path $WorkshopPath)) {
        New-Item -ItemType Directory $WorkshopPath
    }

    # Remove existing keys
    Get-ChildItem -Recurse -Filter *.bikey $DestinationPath | Remove-Item -Force

    # Download official BI keys
    $KeysZip = New-TemporaryFile
    Invoke-WebRequest -Uri $OfficialKeysUri -OutFile $KeysZip
    Expand-Archive -Path $KeysZip -DestinationPath $DestinationPath
    Remove-Item -Force $KeysZip
}

Process {
    # Copy addon keys
    $Addon | & "$PSScriptRoot/Copy-AddonKey.ps1" -WorkshopPath $Config.WorkshopPath -DestinationPath $DestinationPath
}