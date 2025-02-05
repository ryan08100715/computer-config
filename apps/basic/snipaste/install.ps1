#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1

$PackageName = "Snipaste"
$WingetPackageID = "9P1WXPKB68KX"
$Package = Get-WinGetPackage -Query $WingetPackageID -Id $WingetPackageID

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

# 檢查是否已經安裝
if ($null -eq $Package) {
  Write-MyInfo "$PackageName 尚未安裝，開始進行安裝"
  
  $InstallInfo = Install-WinGetPackage -Id $WingetPackageID

  if ("Ok" -eq $InstallInfo.Status) {
    Write-MySuccess -Icon "安裝完成"
  }
  else {
    Write-MyError -Icon "安裝失敗"
    $InstallInfo
  }
}
else {
  Write-MySuccess -Icon "$PackageName 已安裝"

  Write-MyInfo "檢查是否需要更新"
  if ($Package.IsUpdateAvailable) {
    Write-MyWarning -Icon "有新版本可供安裝，開始進行更新"

    $UpdateInfo = Update-WinGetPackage -Id $WingetPackageID

    if ("Ok" -eq $UpdateInfo.Status) {
      Write-MySuccess -Icon "更新完成"
    }
    else {
      Write-MyError -Icon "更新失敗"
      $UpdateInfo
    }
  }
  else {
    Write-MySuccess -Icon "已經是最新版本"
  }
}

Write-MyInfo ""

