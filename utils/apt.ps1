#!/usr/bin/env pwsh

. "$PSScriptRoot/output.ps1"

function Test-AptSourcesList {
  param(
    [Parameter(Mandatory)]
    [string]$Pattern
  )

  $files = @(
    "/etc/apt/sources.list"
    Get-ChildItem "/etc/apt/sources.list.d/*" -File
  )

  foreach ($file in $files) {
    if (Select-String -Path $file -Pattern $Pattern -Quiet) {
      return $true
    }
  }

  return $false
}

function Test-AptPackageInstalled {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Package
  )

  try {
    $result = dpkg-query -W -f='${Status}' $Package 2>$null
    return $result -eq "install ok installed"
  }
  catch {
    return $false
  }
}

function Install-AptPackage {
  param(
    [Parameter(Mandatory)]
    [string]$PackageName,
    [Parameter(Mandatory)]
    [string]$Package
  )

  if (Test-AptPackageInstalled -Package $Package) {
    Write-MySuccess -Icon "$PackageName 已安裝"

    Write-MyInfo "檢查是否需要更新"
    if (Test-AptPackageUpgradable -Package $Package) {
      Write-MyWarning -Icon "有新版本可供安裝，開始進行更新"
      sudo apt-get install -y $Package
      Write-MySuccess -Icon "更新完成"
    }
    else {
      Write-MySuccess -Icon "已經是最新版本"
    }
  }
  else {
    Write-MyInfo "$PackageName 尚未安裝，開始進行安裝"

    Update-AptSourcesList
    sudo apt-get install -y $Package
    Write-MySuccess -Icon "安裝完成"
  }
}

function Add-AptRepository {
  param(
    [Parameter(Mandatory)]
    [string]$PPA
  )

  # 檢查 PPA 是否已經添加
  Write-MyInfo "檢查是否需要添加 PPA: $PPA"
  if (-not (Test-AptSourcesList -Pattern $($PPA -replace "^ppa:"))) {
    Write-MyInfo "開始添加 PPA..."
    sudo add-apt-repository -y $PPA
    Write-MySuccess -Icon "PPA 添加成功"
  }
  else {
    Write-MyWarning -Icon "PPA: $PPA 已經添加過，略過添加"
  }
}

function Test-AptPackageUpgradable {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Package,
    [Parameter(Mandatory = $false)]
    [int]$UpdateCacheMinutes = 60
  )

  # 更新 apt 來源
  Update-AptSourcesList -UpdateCacheMinutes $UpdateCacheMinutes

  # 檢查套件是否可以更新
  $result = apt list --upgradable 2>$null | Select-String "^$packageName/"
  return $null -ne $result
}

function Update-AptSourcesList {
  param (
    [Parameter(Mandatory = $false)]
    [int]$UpdateCacheMinutes = 60
  )

  $lastUpdate = (Get-Item "/var/cache/apt/pkgcache.bin").LastWriteTime
  if ((Get-Date) - $lastUpdate -gt [TimeSpan]::FromMinutes($updateCacheMinutes)) {
    Write-MyInfo "apt update..."
    sudo apt-get update 2>&1
  }
}
