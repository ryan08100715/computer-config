#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

EnsureAdminRun

$PackageName = "Git"
$WingetPackageID = "Git.Git"

Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID

Write-Host "開始進行配置"
$ConfigPath = "$env:USERPROFILE\.gitconfig"

if (Test-Path $ConfigPath) {
  Move-Item $ConfigPath "$ConfigPath.backup" -Force
}
New-Item -ItemType SymbolicLink -Path $ConfigPath -Target "$PSScriptRoot\config\config"
