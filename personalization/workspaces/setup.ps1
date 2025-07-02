#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1
. $PSScriptRoot\..\..\utils\utils.ps1

function Init-WorkspacesCount {
  param(
    [Parameter(Mandatory)]
    [int]$Count
  )

  $currentCount = Get-DesktopCount
  $needNewCount = $Count - $currentCount

  for ($i = 0; $i -lt $needNewCount; $i++) {
    New-Desktop | Out-Null
  }
}

Write-MyInfo "開始執行初始化工作區腳本..."

# 初始化 10 個工作區
Init-WorkspacesCount -Count 10

# 添加工作列顯示目前工作區
& "$PSScriptRoot\..\..\apps\device_driver\dotnet_framework\install.ps1"
& "$PSScriptRoot\..\..\apps\basic\windows_virtual_desktop_helper\install.ps1"
& "$PSScriptRoot\..\..\apps\basic\windows_virtual_desktop_helper\config_setup.ps1"

# 設置工作區相關快捷鍵
& "$PSScriptRoot\..\..\apps\basic\autohotkey\install.ps1"
& "$PSScriptRoot\..\..\apps\basic\windows_desktop_switcher\install.ps1"
& "$PSScriptRoot\..\..\apps\basic\windows_desktop_switcher\config_setup.ps1"

Write-MySuccess -Icon "工作區設置完成"
Write-MyInfo ""
