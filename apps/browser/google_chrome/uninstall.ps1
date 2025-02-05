#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1

$PackageName = "Google Chrome"
$WingetPackageID = "Google.Chrome"
$Package = Get-WinGetPackage -Id $WingetPackageID

Write-MyInfo "開始執行 $PackageName 解除安裝腳本..."

# 檢查是否已經安裝
if ($null -eq $Package) {
  Write-MyError -Icon "$PackageName 尚未安裝"
}
else {
  $UninstallInfo = Uninstall-WinGetPackage -Id $WingetPackageID

  if ("Ok" -eq $UninstallInfo.Status) {
    Write-MySuccess -Icon "解除安裝完成"
  }
  else {
    Write-MyError -Icon "解除安裝失敗"
    $UninstallInfo
  }
}

Write-MyInfo ""
