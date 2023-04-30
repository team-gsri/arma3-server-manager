[CmdletBinding(SupportsShouldProcess)]
param (
  [Parameter(Mandatory, ValueFromPipeline)]
  [string]
  $AddonName,

  [Parameter(Mandatory)]
  [string]
  $DestinationPath,

  [Parameter(Mandatory)]
  [ValidateScript({ Test-Path $_ -PathType Container }, ErrorMessage = 'Path must be a valid directory')]
  [string]
  $WorkshopPath,

  [Parameter()]
  [string]
  $WorkshopPattern = '^[0-9]+$',

  [Parameter()]
  [uri]
  $OfficialKeysUri = 'https://arma.gsri.team/legacy/keys.zip'
)

Begin {
  Write-Verbose "Removing old keys from $DestinationPath"
  New-Item $DestinationPath -ItemType Directory -Force | Out-Null
  Get-ChildItem -Recurse -Filter *.bikey $DestinationPath | Remove-Item -Force
}

Process {
  $AddonPath = switch ($true) {
    ($AddonName -match $WorkshopPattern) {
      Write-Debug "$AddonName is a workshop mod"
      Join-Path $WorkshopPath "steamapps\workshop\content\107410\$AddonName"
    }
    Default {
      Write-Debug "$AddonName is an absolute path"
      $AddonName
    }
  }

  Write-Verbose "Copy addon keys from $AddonPath"
  Get-ChildItem $AddonPath -Recurse -Filter '*.bikey' | Copy-Item -Destination $DestinationPath
}

End {
  $KeysZip = New-TemporaryFile
  Write-Verbose "Download official BI keys from $OfficialKeysUri"
  Invoke-WebRequest -Uri $OfficialKeysUri -OutFile $KeysZip
  Expand-Archive -Path $KeysZip -DestinationPath $DestinationPath
  Remove-Item -Force $KeysZip
}
