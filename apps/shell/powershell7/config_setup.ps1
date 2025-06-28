#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\file_system.ps1

Write-MyInfo "開始進行 PowerShell 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

# * 配置設定檔
$configDir = "$HOME\Documents\PowerShell"
Add-MySymbolicLink -Target "$PSScriptRoot\config\Microsoft.PowerShell_profile.ps1" -Destination "$configDir\Microsoft.PowerShell_profile.ps1" -SuppressOutput

Write-MySuccess -Icon "Microsoft.PowerShell_profile.ps1"
Write-MyInfo ""
