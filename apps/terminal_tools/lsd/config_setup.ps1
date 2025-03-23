#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1

Write-MyInfo "開始進行 LSD 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

# * 配置設定檔
$configDir = "$HOME\.config\lsd"
if (!(Test-Path $configDir)) {
  New-Item -ItemType Directory -Path $configDir | Out-Null
}
New-Item -ItemType SymbolicLink -Force -Path "$configDir\config.yaml" -Target "$PSScriptRoot\config\config.yaml" | Out-Null

Write-MySuccess -Icon "$HOME\.config\lsd\config.yaml"
Write-MyInfo ""
