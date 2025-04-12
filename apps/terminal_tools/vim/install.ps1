#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1

$PackageName = "Vim"
$WingetPackageID = "vim.vim"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID
$envPath = "C:\Program Files\Vim\vim91"
Add-EnvPath -Path $envPath

Write-MyInfo ""
