#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\file_system.ps1

Write-MyInfo "開始進行 LSD 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

# * 配置設定檔
$configDir = "$HOME\.config\lsd"
Add-MySymbolicLink -Target "$PSScriptRoot\config\config.yaml" -Destination "$configDir\config.yaml" -SuppressOutput

Write-MySuccess -Icon "$HOME\.config\lsd\config.yaml"
Write-MyInfo ""
