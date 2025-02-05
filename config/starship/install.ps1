#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\utils.ps1

EnsureAdminRun

# * 配置
$ConfigPath = Join-Path $HOME ".config" "starship.toml"
New-Item -ItemType SymbolicLink -Path $ConfigPath -Target "$PSScriptRoot\config\starship.toml" -Force
