#!/usr/bin/env pwsh

#Requires -RunAsAdministrator

. $PSScriptRoot\..\..\utils\output.ps1
. $PSScriptRoot\..\..\utils\registry.ps1

Write-MyInfo "> 隱藏桌面的資源回收桶標誌"

# 定義資源回收桶的 CLSID
$recycleBinCLSID = "{645FF040-5081-101B-9F08-00AA002F954E}"

# 設定路徑
$regPathNewStartPanel = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$regPathClassicStartMenu = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu"

# 確保路徑存在，若不存在則創建
if (-not (Test-Path $regPathNewStartPanel)) {
  New-Item -Path $regPathNewStartPanel -Force | Out-Null
}
if (-not (Test-Path $regPathClassicStartMenu)) {
  New-Item -Path $regPathClassicStartMenu -Force | Out-Null
}

# 設定值為 1 以隱藏資源回收桶
Set-Registry -Path $regPathNewStartPanel -Name $recycleBinCLSID -Value 1 -Type Dword
Set-Registry -Path $regPathClassicStartMenu -Name $recycleBinCLSID -Value 1 -Type Dword

Write-MySuccess -Icon "已將資源回收桶隱藏！"
