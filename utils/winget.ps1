#!/usr/bin/env pwsh

. $PSScriptRoot\output.ps1

function Install-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$PackageName,
    [Parameter(Mandatory)]
    [string]$WingetPackageID,
    [switch]$Interactive
  )

  $Package = Get-WinGetPackage -Id $WingetPackageID -MatchOption Equals

  # 安裝或更新的參數
  $params = @{}
  if ($Interactive) {
    $params['Mode'] = "Interactive"
  }
    
  # 檢查是否已經安裝
  if ($null -eq $Package) {
    Write-MyInfo "$PackageName 尚未安裝，開始進行安裝"
  
    $InstallInfo = Install-WinGetPackage -Id $WingetPackageID @params
    $InstallInfo

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

      $UpdateInfo = Update-WinGetPackage -Id $WingetPackageID @params

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
}

function Uninstall-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$PackageName,
    [Parameter(Mandatory)]
    [string]$WingetPackageID
  )

  $Package = Get-WinGetPackage -Id $WingetPackageID -MatchOption Equals

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
}
