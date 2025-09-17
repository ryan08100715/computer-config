#!/usr/bin/env pwsh

param(
  [Parameter(Mandatory = $true)]
  [string]$FolderName
)

. $PSScriptRoot\..\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\..\utils\file_system.ps1
. $PSScriptRoot\..\..\..\..\utils\windows_schedule.ps1

Write-MyInfo "開始進行 PHPStorm 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

$jetbrainsDir = "$env:APPDATA\JetBrains"
$ideDir = Join-Path $jetbrainsDir $FolderName

# * 配置 Keymaps
$keymapsDir = Join-Path $ideDir "keymaps"
Add-MySymbolicLink -Target "$PSScriptRoot\..\config\VSCode copy.xml" -Destination "$keymapsDir\VSCode copy.xml" -SuppressOutput

# * 配置 Options
$optionsDir = Join-Path $ideDir "options"
Add-MySymbolicLink -Target "$PSScriptRoot\..\config\ui.lnf.xml" -Destination "$optionsDir\ui.lnf.xml" -SuppressOutput
Add-MySymbolicLink -Target "$PSScriptRoot\..\config\advancedSettings.xml" -Destination "$optionsDir\advancedSettings.xml" -SuppressOutput
Add-MySymbolicLink -Target "$PSScriptRoot\..\config\terminal-font.xml" -Destination "$optionsDir\terminal-font.xml" -SuppressOutput
Add-MySymbolicLink -Target "$PSScriptRoot\..\config\ide.general.xml" -Destination "$optionsDir\ide.general.xml" -SuppressOutput

Write-MySuccess -Icon "PHPStorm 配置完成"
Write-MyInfo ""
