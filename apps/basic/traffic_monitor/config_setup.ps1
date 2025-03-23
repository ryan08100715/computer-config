#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\windows_schedule.ps1

Write-MyInfo "開始進行 Traffic Monitor 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

$appsDir = Get-MyAppsDirectoryPath
$trafficMonitorDir = Join-Path $appsDir "TrafficMonitor"

# * 配置插件
Copy-Item -Force -Path "$PSScriptRoot\plugins" -Destination "$trafficMonitorDir\plugins" -Recurse

# * 配置設定檔
Copy-Item -Force -Path "$PSScriptRoot\config\*" -Destination "$trafficMonitorDir"
Write-MySuccess -Icon "config.ini"
Write-MySuccess -Icon "global_cfg.ini"

# * 配置啟動執行
Register-MyAutoRunOnStartupTask -AppName "TrafficMonitor" -ExePath "$trafficMonitorDir\TrafficMonitor.exe" -RunAsAdministrator
Write-MySuccess -Icon "開機自動執行"

Write-MySuccess -Icon "Traffic Monitor 配置完成"
Write-MyInfo ""
