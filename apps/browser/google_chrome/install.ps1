#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1

$PackageName = "Google Chrome"
$WingetPackageID = "Google.Chrome"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID

Write-MyInfo ""
