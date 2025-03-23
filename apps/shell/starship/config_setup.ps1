#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1

Write-MyInfo "開始進行 Starship 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

# * 配置設定檔
$configDir = "$HOME\.config"
if (!(Test-Path $configDir)) {
  New-Item -ItemType Directory -Path $configDir | Out-Null
}
New-Item -ItemType SymbolicLink -Force -Path "$configDir\starship.toml" -Target "$PSScriptRoot\config\starship.toml" | Out-Null

Write-MySuccess -Icon "starship.toml"
Write-MyInfo ""
