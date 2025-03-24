#!/usr/bin/env pwsh

function Install-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$ChocoPackageID
  )

  choco upgrade $ChocoPackageID -y
}

function Uninstall-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$ChocoPackageID
  )

  choco uninstall $ChocoPackageID -y
}

function Pin-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$ChocoPackageID
  )

  choco pin add $ChocoPackageID -y
}
