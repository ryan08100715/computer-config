#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

# * 確保以管理員權限執行
EnsureAdminRun

$appsDir = Get-Apps-Directory
$startupDir = Get-Startup-Directory
$dirName = "windows-desktop-switcher"

# * 產生一個臨時文件夹
$tempFolder = New-TemporaryDirectory

# * 下載專案
git clone https://github.com/pmb6tz/windows-desktop-switcher.git "$tempFolder\$dirName"

# * 下載最新的 VirtualDesktopAccessor.dll
$url = GetGithubAssetDownloadUrl "Ciantic/VirtualDesktopAccessor" "^VirtualDesktopAccessor\.dll$"
Invoke-WebRequest -Uri $url -OutFile "$tempFolder\VirtualDesktopAccessor.dll"

# * 移動專案
Move-Item -Force -Path "$tempFolder\VirtualDesktopAccessor.dll" -Destination "$tempFolder\$dirName\VirtualDesktopAccessor.dll"
Move-Item -Force -Path "$tempFolder\$dirName" -Destination $appsDir

# * 配置設定檔
New-Item -ItemType SymbolicLink -Force -Path "$appsDir\$dirName\user_config.ahk" -Target "$PSScriptRoot\config\user_config.ahk"

# * 配置啟動執行
New-Item -ItemType SymbolicLink -Force -Path "$startupDir\desktop_switcher.ahk" -Target "$appsDir\$dirName\desktop_switcher.ahk"

# * 刪除臨時文件夹
Remove-Item $tempFolder -Recurse -Force