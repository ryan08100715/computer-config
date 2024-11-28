#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\utils.ps1

# * 確保以管理員權限執行
EnsureAdmin

$appsDir = Get-Apps-Directory
$startupDir = Get-Startup-Directory

# * 同步資料夾
New-Item -ItemType SymbolicLink -Force -Path "$appsDir\windows-desktop-switcher" -Target "$PSScriptRoot\windows-desktop-switcher"

# * 配置啟動執行
New-Item -ItemType SymbolicLink -Force -Path "$startupDir\desktop_switcher.ahk" -Target "$appsDir\windows-desktop-switcher\desktop_switcher.ahk"