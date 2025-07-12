#!/usr/bin/env pwsh

function Install-MyChocoPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id
  )

  $options = @()

  $command = "choco install $Id " + ($options -join " ")

  Invoke-Expression $command
}
