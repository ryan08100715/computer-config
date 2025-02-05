#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1

$PackageName = "Arc"
$WingetPackageID = "TheBrowserCompany.Arc"

Write-MyInfo "開始執行 $PackageName 解除安裝腳本..."

Uninstall-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID

Write-MyInfo ""
