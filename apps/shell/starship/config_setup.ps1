#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\file_system.ps1

Write-MyInfo "開始進行 Starship 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

# * 配置設定檔
$configDir = "$HOME\.config"
Add-MySymbolicLink -Target "$PSScriptRoot\config\starship.toml" -Destination "$configDir\starship.toml" -SuppressOutput

Write-MySuccess -Icon "starship.toml"
Write-MyInfo ""
