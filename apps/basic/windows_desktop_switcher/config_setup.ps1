#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\windows_schedule.ps1

Write-MyInfo "開始進行 Windows Desktop Switcher 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

$appsDir = Get-MyAppsDirectoryPath
$windowsDesktopSwitcherDir = Join-Path $appsDir "windows-desktop-switcher"

# * 配置設定檔
New-Item -ItemType SymbolicLink -Force -Path "$windowsDesktopSwitcherDir\user_config.ahk" -Target "$PSScriptRoot\config\user_config.ahk" | Out-Null

# * 配置啟動執行
Register-MyAutoRunOnStartupTask -AppName "WindowsDesktopSwitcher" -ExePath "$windowsDesktopSwitcherDir\desktop_switcher.ahk"
Write-MySuccess -Icon "開機自動執行"

Write-MySuccess -Icon "Windows Desktop Switcher 配置完成"
Write-MyInfo ""
