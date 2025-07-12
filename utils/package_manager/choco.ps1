#!/usr/bin/env pwsh

. $PSScriptRoot\..\utils.ps1

function Install-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id
  )

  EnsureAdminRun

  $options = @()

  $command = "choco install $Id " + ($options -join " ")

  Invoke-Expression $command
}

function UnInstall-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id
  )

  EnsureAdminRun

  $options = @()

  $command = "choco uninstall $Id " + ($options -join " ")

  Invoke-Expression $command
}
