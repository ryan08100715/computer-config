#!/usr/bin/env pwsh

function Get-PowerToysSettingsDir {
  return "$HOME\Documents\PowerToys\Backup"
}

function Get-PowerToysBackupSettingsDir {
  return "$PSScriptRoot\..\config\backup"
}

function Get-LatestPowerToysSettings {
  $dir = Get-PowerToysSettingsDir

  return Get-ChildItem -Path $dir -Filter "*.ptb" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

function Get-PowerToysBackupSettings {
  $dir = Get-PowerToysBackupSettingsDir

  return Get-ChildItem -Path $dir -Filter "*.ptb" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}
