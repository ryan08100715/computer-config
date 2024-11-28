#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "Docker Desktop"
$WingetPackageID = "Docker.DockerDesktop"

# * 安裝 Docker Desktop
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID $false
