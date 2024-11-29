#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "PowerShell"
$WingetPackageID = "Microsoft.PowerShell"

# * 安裝 PowerShell
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID

# * 安裝模組
Install-Module PSReadLine

# * 配置設定檔
Write-Host "開始進行配置"
$folderPath = Split-Path -Path $PROFILE -Parent
if (-not (Test-Path $folderPath)) {
  New-Item -ItemType Directory -Path $folderPath
}
Copy-Item -Path "$PSScriptRoot\config\Microsoft.PowerShell_profile.ps1" -Destination "$PROFILE" -Force
