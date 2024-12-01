#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

EnsureAdminRun

$PackageName = "AutoHotkey"
$WingetPackageID = "AutoHotkey.AutoHotkey"

# * 安裝 AutoHotkey
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
if (CheckInstalledByWingetId $WingetPackageID) {
  Write-Host "套件 - $PackageName 已經安裝"
}
else {
  Write-Host "尚未安裝 $package, 即將開始安裝"
  winget install --id $WingetPackageID
}

# * 配置 script 到啟動腳本
Write-Host "開始進行配置"
$startupDir = Get-Startup-Directory

New-Item -ItemType SymbolicLink -Force -Path "$startupDir\keyboard_shortcuts.ahk" -Target "$PSScriptRoot\config\keyboard_shortcuts.ahk"
New-Item -ItemType SymbolicLink -Force -Path "$startupDir\change-cap-to-ctrl.ahk" -Target "$PSScriptRoot\config\change-cap-to-ctrl.ahk"
