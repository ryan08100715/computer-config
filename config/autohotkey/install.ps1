#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\utils.ps1

EnsureAdminRun

# * 配置 script 到啟動腳本
Write-Host "開始進行配置"
$startupDir = Get-Startup-Directory

New-Item -ItemType SymbolicLink -Force -Path "$startupDir\keyboard_shortcuts.ahk" -Target "$PSScriptRoot\config\keyboard_shortcuts.ahk"
New-Item -ItemType SymbolicLink -Force -Path "$startupDir\change-cap-to-ctrl.ahk" -Target "$PSScriptRoot\config\change-cap-to-ctrl.ahk"
