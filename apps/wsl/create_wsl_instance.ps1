#!/usr/bin/env pwsh

param(
  [Parameter(Mandatory)]
  [string]$WSLName
)

. $PSScriptRoot\..\..\utils\wsl.ps1

# 下載 Ubuntu 24.04 image
$downloadImageOptions = @{
  ImageUri = "https://cloud-images.ubuntu.com/wsl/releases/24.04/current/ubuntu-noble-wsl-amd64-wsl.rootfs.tar.gz"
  FileName = "ubuntu_2404.tar.gz"
}
Download-WSLImage @downloadImageOptions

# 註冊 WSL
$wslDir = "$env:USERPROFILE\wsl"
if (!(Test-Path $wslDir)) {
  New-Item -ItemType Directory -Path $wslDir
}
$wslImagePath = "$(Get-WSLImageDirectory)\$($downloadImageOptions.FileName)"

$wslDirName = $WSLName.ToLower()
wsl --import $WSLName "$wslDir\$wslDirName" "$wslImagePath"
