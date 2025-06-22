#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1

$PackageName = "Msty"

Write-MyInfo "開始執行 $PackageName 解除安裝腳本..."

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  $WingetPackageID = "CloudStack.Msty"

  Uninstall-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}

Write-MyInfo ""
