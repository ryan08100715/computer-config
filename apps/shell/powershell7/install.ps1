#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

EnsureAdminRun

$PackageName = "PowerShell"
$WingetPackageID = "Microsoft.PowerShell"

# * 安裝 PowerShell
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID

# * 配置設定檔
Write-Host "開始進行配置"
$pwshProfilePath = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$pwshProfileDir = Split-Path -Path $pwshProfilePath -Parent
if (-not (Test-Path $pwshProfileDir)) {
  New-Item -ItemType Directory -Path $pwshProfileDir
}
New-Item -ItemType SymbolicLink -Force -Path $pwshProfilePath -Target "$PSScriptRoot\config\Microsoft.PowerShell_profile.ps1"