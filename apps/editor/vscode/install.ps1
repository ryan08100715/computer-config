#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1

$PackageName = "VSCode"
$WingetPackageID = "Microsoft.VisualStudioCode"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID -Override "/silent /suppressmsgboxes /mergetasks='!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath'"

Write-MyInfo ""
