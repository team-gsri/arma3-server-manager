[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory, ValueFromPipeline)]
    [string]
    $AddonName,

    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Container) { $true } Else { Throw '-WorkshopPath must be a valid directory' } })]
    [string]
    $WorkshopPath,

    [Parameter(Mandatory)]
    [ValidateScript({ If (Test-Path $_ -PathType Container) { $true } Else { Throw '-DestinationPath must be a valid directory' } })]
    [string]
    $DestinationPath
)

Begin {
    $WorkshopPattern = '^[0-9]+$'
}

Process {
    $AddonPath = switch ($true) {
            ($AddonName -match $WorkshopPattern) {
            Join-Path $WorkshopPath "steamapps\workshop\content\107410\$AddonName"
        }
        Default {
            $AddonName
        }
    }

    Write-Debug "Copy BI keys from $AddonPath"
    Get-ChildItem $AddonPath -Recurse -Filter *.bikey | Copy-Item -Destination $DestinationPath
}