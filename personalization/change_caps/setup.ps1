#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1
. $PSScriptRoot\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\utils\windows_schedule.ps1

Write-MyInfo "> 將 Caps 按鍵改成 Ctrl"

# * 確保以管理員權限執行
EnsureAdminRun

# * 安裝 AutoHotkey
& "$PSScriptRoot\..\..\apps\basic\autohotkey\install.ps1" -Silent
Write-MySuccess -Icon "安裝 AutoHotkey"

$appsFolder = Get-MyAppsDirectoryPath
$ahkFileName = "change-cap-to-ctrl.ahk"
$capsToCtrlFolder = Join-Path $appsFolder "change_caps"

# * 放置 AHK 腳本
if (-not (Test-Path $capsToCtrlFolder)) {
  New-Item -ItemType Directory -Path $capsToCtrlFolder | Out-Null
}
Copy-Item -Force -Path "$PSScriptRoot\$ahkFileName" -Destination "$capsToCtrlFolder\$ahkFileName"
Write-MySuccess -Icon "將 $ahkFileName 放置到: $capsToCtrlFolder"

# * 配置啟動執行
Register-MyAutoRunOnStartupTask -AppName "CapsToCtrl" -ExePath "$capsToCtrlFolder\$ahkFileName"
Write-MySuccess -Icon "設置開機自動啟動"
