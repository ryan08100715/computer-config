#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "PowerShell"
$WingetPackageID = "Microsoft.PowerShell"

# * 安裝 PowerShell
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID

# * 配置設定檔
Update-EnvPath
Write-Host "開始進行配置"
pwsh "$PSScriptRoot\config.ps1"
