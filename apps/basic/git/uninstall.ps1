#!/usr/bin/env pwsh

param(
  [ValidateSet("Winget", "Chocolatey")]
  [string]$UninstallMethod = "Winget"
)

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1
. $PSScriptRoot\..\..\..\utils\choco.ps1

$PackageName = "Git"

Write-MyInfo "開始執行 $PackageName 解除安裝腳本..."

if ($UninstallMethod -eq "Winget") {
  $WingetPackageID = "Git.Git"
  Uninstall-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID
}
elseif ($UninstallMethod -eq "Chocolatey") {
  $chocoPackageID = "git.install"
  Uninstall-MyChocoPackage -PackageName $PackageName -ChocoPackageID $chocoPackageID
}
else {
  Write-MyWarning -Icon "不支援的解除安裝方法: $UninstallMethod"
}

Write-MyInfo ""
