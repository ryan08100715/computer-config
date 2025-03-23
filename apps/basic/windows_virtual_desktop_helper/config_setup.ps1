#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\windows_schedule.ps1

Write-MyInfo "開始進行 Window Virtual Desktop Helper 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

$appsDir = Get-MyAppsDirectoryPath
$windowsVirtualDesktopHelperDir = Join-Path $appsDir "WindowsVirtualDesktopHelper"

# * 配置設定檔
New-Item -ItemType SymbolicLink -Force -Path "$env:APPDATA\WindowsVirtualDesktopHelper\WindowsVirtualDesktopHelper.exe.config" -Target "$PSScriptRoot\config\WindowsVirtualDesktopHelper.exe.config" | Out-Null
Write-MySuccess -Icon "WindowsVirtualDesktopHelper.exe.config"

# * 配置啟動執行
Register-MyAutoRunOnStartupTask -AppName "WindowsVirtualDesktopHelper" -ExePath "$windowsVirtualDesktopHelperDir\WindowsVirtualDesktopHelper.exe" -RunAsAdministrator
Write-MySuccess -Icon "開機自動執行"

Write-MySuccess -Icon "Window Virtual Desktop Helper 配置完成"
Write-MyInfo ""
