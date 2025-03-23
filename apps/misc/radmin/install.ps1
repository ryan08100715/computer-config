#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1
. $PSScriptRoot\..\..\..\utils\apt.ps1

$PackageName = "Radmin"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  $WingetPackageID = "Famatech.RadminVPN"

  Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID
}
elseif ($osInfo.OS -eq 'ubuntu') {
  $ppa = "ppa:git-core/ppa"
  Add-AptRepository -PPA $ppa
  Install-AptPackage -PackageName $PackageName -Package "git"
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
