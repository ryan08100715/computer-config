#!/usr/bin/env pwsh

. $PSScriptRoot\output.ps1

function Test-WinGetPackageInstalled {
  param (
    [Parameter(Mandatory)]
    [string]$WingetPackageID
  )

  return $null -ne (winget list | Select-String -SimpleMatch "$WingetPackageID")
}

function Test-WinGetPackageIsUpdateAvailable {
  param (
    [Parameter(Mandatory)]
    [string]$WingetPackageID
  )

  return $null -ne (winget upgrade | Select-String -SimpleMatch "$WingetPackageID")
}

function Install-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$PackageName,
    [Parameter(Mandatory)]
    [string]$WingetPackageID,
    [string]$Version,
    [switch]$Interactive,
    [switch]$NoUpgrade,
    [switch]$Silent
  )
  $Interactive = $true

  # 安裝或更新的參數
  $options = @()
  if ($Interactive) {
    $options += "--interactive"
  }

  # 檢查是否已經安裝
  if (-not (Test-WinGetPackageInstalled -WingetPackageID $WingetPackageID) ) {
    Write-MyInfo "$PackageName 尚未安裝，開始進行安裝" -Silent:$Silent

    if ($Version) {
      $options += "--version", "$Version"
    }

    $command = "winget install --id $WingetPackageID " + ($options -join " ")
    if ($Silent) {
      Invoke-Expression $command | Out-Null
    }
    else {
      Invoke-Expression $command
    }
    Write-MySuccess -Icon "安裝完成" -Silent:$Silent
  }
  else {
    Write-MySuccess -Icon "$PackageName 已安裝" -Silent:$Silent

    if ($NoUpgrade) {
      return
    }

    Write-MyInfo "檢查是否需要更新" -Silent:$Silent
    if ((Test-WinGetPackageIsUpdateAvailable -WingetPackageID $WingetPackageID)) {
      Write-MyWarning -Icon "有新版本可供安裝，開始進行更新" -Silent:$Silent

      $command = "winget upgrade --id $WingetPackageID " + ($options -join " ")
      if ($Silent) {
        Invoke-Expression $command | Out-Null
      }
      else {
        Invoke-Expression $command
      }
      Write-MySuccess -Icon "更新完成" -Silent:$Silent
    }
    else {
      Write-MySuccess -Icon "已經是最新版本" -Silent:$Silent
    }
  }
}

function Uninstall-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$PackageName,
    [Parameter(Mandatory)]
    [string]$WingetPackageID,
    [switch]$Silent
  )

  # 檢查是否已經安裝
  if (-not (Test-WinGetPackageInstalled -WingetPackageID $WingetPackageID)) {
    Write-MyError -Icon "$PackageName 尚未安裝" -Silent:$Silent
    return
  }

  # 解除安裝
  if ($Silent) {
    winget uninstall --id $WingetPackageID | Out-Null
  }
  else {
    winget uninstall --id $WingetPackageID
  }
  Write-MySuccess -Icon "解除安裝完成" -Silent:$Silent
}

function Pin-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$WingetPackageID,
    [Parameter(Mandatory)]
    [string]$PinVersion,
    [switch]$Silent
  )

  if ($Silent) {
    winget pin add --id $WingetPackageID --version "$PinVersion" --force | Out-Null
  }
  else {
    winget pin add --id $WingetPackageID --version "$PinVersion" --force
  }
}
