#!/usr/bin/env pwsh

. $PSScriptRoot\utils.ps1

# 取得最新的設定檔備份
$latestSettings = Get-LatestPowerToysSettings
if ($null -eq $latestSettings) {
  exit
}

# 刪除目前備份的設定檔
$backupSettings = Get-PowerToysBackupSettings
if ($null -ne $backupSettings) {
  if ($latestSettings.LastWriteTime -eq $backupSettings.LastWriteTime) {
    exit
  }
  else {
    Remove-Item -Path $backupSettings.FullName | Out-Null
  }
}

Copy-Item -Path $latestSettings.FullName -Destination "$(Get-PowerToysBackupSettingsDir)\$($latestSettings.Name)" | Out-Null
