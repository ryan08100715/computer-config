#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

Write-Host "開始進行配置"
$folderPath = Split-Path -Path $PROFILE -Parent
if (-not (Test-Path $folderPath)) {
  New-Item -ItemType Directory -Path $folderPath
}
Copy-Item -Path "$PSScriptRoot\config\Microsoft.PowerShell_profile.ps1" -Destination "$PROFILE" -Force
