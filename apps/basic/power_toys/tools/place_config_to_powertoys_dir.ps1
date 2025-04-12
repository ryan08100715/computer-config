#!/usr/bin/env pwsh

. $PSScriptRoot\utils.ps1
. $PSScriptRoot\..\..\..\..\utils\output.ps1

# 取得目前的設定檔
$backupSettings = Get-PowerToysBackupSettings
if ($null -eq $backupSettings) {
  Write-MyError -Icon "找不到備份的設定檔"
  exit
}

# 複製到 PowerToys 備份配置檔資料夾
Copy-Item -Force -Path $backupSettings.FullName -Destination "$(Get-PowerToysSettingsDir)\$($backupSettings.Name)" | Out-Null
