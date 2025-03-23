#!/usr/bin/env pwsh

$wslDir = "$env:USERPROFILE\wsl"

if (!(Test-Path $wslDir)) {
  New-Item -ItemType Directory -Path $wslDir
}

wsl --import Ubuntu_Jellyfin "$wslDir\ubuntu_jellyfin" "$PSScriptRoot\distros\ubuntu_2404.tar"
