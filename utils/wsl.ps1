#!/usr/bin/env pwsh

function Get-WSLImageDirectory {
  return "$PSScriptRoot\..\wsl_images"
}

function Download-WSLImage {
  param (
    [Parameter(Mandatory = $true)]
    [string]$ImageUri,
    [Parameter(Mandatory = $true)]
    [string]$FileName
  )

  $wslImageDir = Get-WSLImageDirectory
  $imagePath = "$wslImageDir\$FileName"

  # 資料夾不存在則建立
  if (-not (Test-Path $wslImageDir)) {
    New-Item -ItemType Directory -Path $wslImageDir
  }

  # 檔案存在則不下載
  if (Test-Path "$wslImageDir\$FileName") {
    return
  }

  # 下載 image
  $downloadImageOptions = @{
    Uri     = $ImageUri
    OutFile = $imagePath
  }
  Invoke-WebRequest @downloadImageOptions
}
