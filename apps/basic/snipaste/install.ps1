#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\utils.ps1

$PackageName = "Snipaste"
$WingetPackageID = "9P1WXPKB68KX"

# * 安裝 Snipaste
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
if (CheckInstalledByWingetId $WingetPackageID) {
  Write-Host "套件 - $PackageName 已經安裝"
}
else {
  Write-Host "尚未安裝 $package, 即將開始安裝"
  winget install --id $WingetPackageID
}
