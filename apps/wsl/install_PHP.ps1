#!/usr/bin/env pwsh

$wslDir = "$env:USERPROFILE\wsl"

if (!(Test-Path $wslDir)) {
  New-Item -ItemType Directory -Path $wslDir
}

wsl --import Ubuntu_PHP "$wslDir\ubuntu_php" "$PSScriptRoot\distros\ubuntu_2404.tar"
