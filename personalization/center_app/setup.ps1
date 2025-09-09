#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1
. $PSScriptRoot\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\utils\windows_schedule.ps1

Write-MyInfo "> 設置 Center App Shortcuts"

# * 確保以管理員權限執行
EnsureAdminRun

# * 安裝 AutoHotkey
#& "$PSScriptRoot\..\..\apps\basic\autohotkey\install.ps1" -Silent
#Write-MySuccess -Icon "安裝 AutoHotkey"

$appsFolder = Get-MyAppsDirectoryPath
$ahkFileName = "center_app.ahk"
$centerAppFolder = Join-Path $appsFolder "center_app"

# * 放置 AHK 腳本
if (-not (Test-Path $centerAppFolder)) {
  New-Item -ItemType Directory -Path $centerAppFolder | Out-Null
}
Copy-Item -Force -Path "$PSScriptRoot\$ahkFileName" -Destination "$centerAppFolder\$ahkFileName"
Write-MySuccess -Icon "放置 $ahkFileName 到: $centerAppFolder"

# * 配置啟動執行
Register-MyAutoRunOnStartupTask -AppName "GlobalShortcuts" -ExePath "$centerAppFolder\$ahkFileName"
Write-MySuccess -Icon "設置開機自動啟動"
