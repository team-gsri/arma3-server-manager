[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [string]
    $Target,

    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('Github', 'Local')]
    [string]
    $SourceType,

    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Source
)

Begin {
    # Remove existing missions
    If (-Not(Test-Path $Target)) { New-Item $Target -ItemType Directory | Out-Null }
    Get-ChildItem $Target -Filter *.pbo | Remove-Item
}

Process {
    switch ($SourceType) {
        'Github' {
            Write-Debug "Downloading mission from GitHub repository $Source"
            if ($PSCmdlet.ShouldProcess("github.com/$Source", 'release download *.pbo')) {
                & gh release download --repo $Source --pattern *.pbo --dir $Target
            }
        }
        'Local' {
            Write-Debug "Copying missions from $Source to $Target"
            Get-ChildItem $Source -Filter *.pbo -Recurse | Copy-Item -Destination $Target
        }
    }
}