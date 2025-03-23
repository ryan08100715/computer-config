#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1

Write-MyInfo "> 在工作列顯示 CPU 與 RAM 使用量"

# * 安裝 Traffic Monitor
& "$PSScriptRoot\..\..\apps\basic\traffic_monitor\install.ps1"
& "$PSScriptRoot\..\..\apps\basic\traffic_monitor\config_setup.ps1"
