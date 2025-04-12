#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1

& "$PSScriptRoot\tools\place_config_to_powertoys_dir.ps1"
Write-MySuccess -Icon "放置備份設定檔成功"

Write-MyInfo ""
