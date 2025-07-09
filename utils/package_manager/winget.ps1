#!/usr/bin/env pwsh

function Install-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id,
    [Parameter()]
    [string]$Version,
    [Parameter()]
    [switch]$Interactive,
    [Parameter()]
    [switch]$SkipDependencies
  )

  $options = @(
    "--accept-source-agreements"
    "--accept-package-agreements"
  )
  if ($Interactive) {
    $options += "--interactive"
  }
  if ($Version) {
    $options += "--version", "$Version"
  }
  if ($SkipDependencies) {
    $options += "--skip-dependencies"
  }

  $command = "winget install --id $Id " + ($options -join " ")

  Invoke-Expression $command
}

function UnInstall-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id
  )

  winget uninstall --id $Id
}

function Pin-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id,
    [Parameter(Mandatory)]
    [string]$PinVersion
  )

  winget pin add --id $Id --version "$PinVersion" --force
}
