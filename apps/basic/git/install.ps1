#!/usr/bin/env pwsh

$PackageName = "Git"
$WingetPackageID = "Git.Git"

Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
if (winget list --id $WingetPackageID | Select-String -Pattern $WingetPackageID) {
  Write-Host "套件 - $PackageName 已經安裝"
}
else {
  Write-Host "尚未安裝 $package, 即將開始安裝"
  winget install -i --id $WingetPackageID
}

Write-Host "開始進行配置"
$ConfigPath = "$env:USERPROFILE\.gitconfig"

if (Test-Path $ConfigPath) {
  Move-Item $ConfigPath "$ConfigPath.backup" -Force
}
sudo New-Item -ItemType SymbolicLink -Path $ConfigPath -Target "$PSScriptRoot\config"
