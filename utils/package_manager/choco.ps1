#!/usr/bin/env pwsh

. $PSScriptRoot\..\utils.ps1

function Install-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id,
    [Parameter()]
    [string]$Version,
    [Parameter()]
    [switch]$Pin
  )

  EnsureAdminRun

  $options = @()

  if ($Version) {
    $options += "--version=$Version"
  }
  if ($Pin) {
    $options += "--pin"
  }

  $command = "choco install $Id " + ($options -join " ")

  Invoke-Expression $command
}

function UnInstall-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id
  )

  EnsureAdminRun

  $options = @(
    "--yes"
  )

  $command = "choco uninstall $Id " + ($options -join " ")

  Invoke-Expression $command
}
