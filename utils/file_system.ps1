#!/usr/bin/env pwsh

. $PSScriptRoot\output.ps1
. $PSScriptRoot\utils.ps1

function Add-MySymbolicLink {
  param (
    [Parameter(Mandatory)]
    [string]$Target,
    [Parameter(Mandatory)]
    [string]$Destination,
    [Parameter()]
    [switch]$SuppressOutput
  )

  EnsureAdminRun

  if (-not (Test-Path $Target)) {
    Write-MyWrite-MyWarning -Icon -Message "Target path '$Target' does not exist."
    return
  }

  $folder = Split-Path -Path $Destination -Parent
  if (-not (Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
  }

  $result = New-Item -ItemType SymbolicLink -Force -Path $Destination -Target $Target
  if (-not $SuppressOutput) {
    $result
  }
}

function Copy-MyItem {
  param (
    [Parameter(Mandatory)]
    [string]$Target,
    [Parameter(Mandatory)]
    [string]$Destination,
    [Parameter()]
    [switch]$SuppressOutput
  )

  if (-not (Test-Path $Target)) {
    Write-MyWrite-MyWarning -Icon -Message "Target path '$Target' does not exist."
    return
  }

  $folder = Split-Path -Path $Destination -Parent
  if (-not (Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
  }

  $result = Copy-Item -Force -Path $Target -Destination $Destination
  if (-not $SuppressOutput) {
    $result
  }
}
