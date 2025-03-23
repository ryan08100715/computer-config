#!/usr/bin/env pwsh

param(
  [Parameter(Mandatory = $true)]
  [string]$ConfigName
)

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1

Write-MyInfo "開始進行 Logitech G HUB 配置..."

# * 確保以管理員權限執行
EnsureAdminRun

# * 配置設定檔
$configDir = "$HOME\AppData\Local\LGHUB"
if (-not (Test-Path $configDir)) {
  New-Item -ItemType Directory -Force -Path $configDir
}
Copy-Item -Force -Path "$PSScriptRoot\config\$ConfigName" -Destination "$configDir\settings.db"

Write-MySuccess -Icon "Logitech G HUB 配置完成"
