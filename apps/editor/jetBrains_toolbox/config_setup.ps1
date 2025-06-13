#!/usr/bin/env pwsh

param(
  [Parameter(Mandatory = $true)]
  [string]$FolderName
)

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\windows_schedule.ps1

Write-MyInfo "開始進行 PHPStorm 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

$jetbrainsDir = "$env:APPDATA\JetBrains"
$ideDir = Join-Path $jetbrainsDir $FolderName

# * 配置 Keymaps
$keymapsDir = Join-Path $ideDir "keymaps"
if (-not (Test-Path $keymapsDir)) {
  New-Item -ItemType Directory -Path $keymapsDir | Out-Null
}
New-Item -ItemType SymbolicLink -Force -Path "$keymapsDir\VSCode copy.xml" -Target "$PSScriptRoot\config\VSCode copy.xml" | Out-Null

# * 配置 Options
$optionsDir = Join-Path $ideDir "options"
if (-not (Test-Path $optionsDir)) {
  New-Item -ItemType Directory -Path $optionsDir | Out-Null
}
New-Item -ItemType SymbolicLink -Force -Path "$optionsDir\ui.lnf.xml" -Target "$PSScriptRoot\config\ui.lnf.xml" | Out-Null
New-Item -ItemType SymbolicLink -Force -Path "$optionsDir\advancedSettings.xml" -Target "$PSScriptRoot\config\advancedSettings.xml" | Out-Null
New-Item -ItemType SymbolicLink -Force -Path "$optionsDir\terminal-font.xml" -Target "$PSScriptRoot\config\terminal-font.xml" | Out-Null


Write-MySuccess -Icon "PHPStorm 配置完成"
Write-MyInfo ""
