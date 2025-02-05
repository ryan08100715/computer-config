#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\utils.ps1

EnsureAdminRun

Write-Host "開始進行配置"
$ConfigPath = "$env:USERPROFILE\.gitconfig"

if (Test-Path $ConfigPath) {
  Move-Item $ConfigPath "$ConfigPath.backup" -Force
}
New-Item -ItemType SymbolicLink -Path $ConfigPath -Target "$PSScriptRoot\config\config"
