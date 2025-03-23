#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1

Write-MyInfo "> 釘選家目錄到檔案總管側邊欄"

# 建立 Shell.Application COM 物件
$shell = New-Object -ComObject Shell.Application

# 取得快速存取的 Namespace (快速存取的 Shell 特殊資料夾)
$quickAccess = $shell.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}")

# 取得目前釘選在快速存取的物件
$items = $quickAccess.Items()

# 檢查是否已經釘選
$pined = $items | Where-Object { $_.Path -eq "$HOME" }

if (-not $pined) {
  # 取得主目錄物件
  $homeFolder = $shell.Namespace("$HOME")

  # 執行釘選到快速存取
  $homeFolder.Self.InvokeVerb("PinToHome")
}

Write-MySuccess -Icon "已將 $HOME 釘選到快速存取！"
