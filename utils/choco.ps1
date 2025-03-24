#!/usr/bin/env pwsh

function Install-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$PackageName,
    [Parameter(Mandatory)]
    [string]$ChocoPackageID
  )

  choco upgrade $ChocoPackageID -y

  Write-MySuccess -Icon "$PackageName 已安裝或升級到最新版本"
}

function Uninstall-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$PackageName,
    [Parameter(Mandatory)]
    [string]$ChocoPackageID
  )

  choco uninstall $ChocoPackageID -y

  Write-MySuccess -Icon "$PackageName 解除安裝完成"
}

function Pin-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$ChocoPackageID
  )

  choco pin add $ChocoPackageID -y
}
