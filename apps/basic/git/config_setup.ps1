#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1

Write-MyInfo "開始進行 Git 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

# * 配置設定檔
Copy-Item -Force -Path "$PSScriptRoot\config\config" -Destination "$HOME\.gitconfig"

Write-MySuccess -Icon "Git 配置完成"
