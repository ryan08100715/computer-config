#!/usr/bin/env pwsh

param(
  [ValidateSet("Winget", "Chocolatey")]
  [string]$InstallMethod = "Winget"
)

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1
. $PSScriptRoot\..\..\..\utils\apt.ps1
. $PSScriptRoot\..\..\..\utils\choco.ps1

$PackageName = "Git"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  if ($InstallMethod -eq "Winget") {
    $WingetPackageID = "Git.Git"
    Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID
  }
  elseif ($InstallMethod -eq "Chocolatey") {
    $chocoPackageID = "git.install"
    Install-MyChocoPackage -PackageName $PackageName -ChocoPackageID $chocoPackageID
  }
  else {
    Write-MyWarning -Icon "不支援的安裝方法: $InstallMethod"
  }
}
elseif ($osInfo.OS -eq 'ubuntu') {
  $ppa = "ppa:git-core/ppa"
  Add-AptRepository -PPA $ppa
  Install-AptPackage -PackageName $PackageName -Package "git"
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
