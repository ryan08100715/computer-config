#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

# * 確保以管理員權限執行
EnsureAdminRun

# * 產生一個臨時文件夹
$tempFolder = New-TemporaryDirectory

# * 設定常數# * 產生一個臨時文件夹
$repoName = "dankrusi/WindowsVirtualDesktopHelper" # TrafficMonitor 的 GitHub 名稱
$fileRegex = "^WindowsVirtualDesktopHelper\.Executable\..*\.zip$" # 要下載的 Asset 的正則表達式

$fileName = "WindowsVirtualDesktopHelper.zip" # 下載的檔案名稱
$tempFilePath = (Join-Path $tempFolder.FullName $fileName) # 下載位置
$appsDir = Get-Apps-Directory


# * 下載Asset到臨時文件夹
$url = GetGithubAssetDownloadUrl $repoName $fileRegex
if (-not $url) {
  Write-MyError "無法獲取下載 URL"
  exit
}
else {
  Invoke-WebRequest -Uri $url -OutFile $tempFilePath
}

# * 解壓縮到應用程式資料夾
$windowsVirtualDesktopHelperDir = (Join-Path $appsDir "WindowsVirtualDesktopHelper")
Expand-Archive -Path $tempFilePath -DestinationPath $windowsVirtualDesktopHelperDir

# * 配置 WindowsVirtualDesktopHelper 設定檔
New-Item -ItemType SymbolicLink -Force -Path "$windowsVirtualDesktopHelperDir\WindowsVirtualDesktopHelper.exe.config" -Target "$PSScriptRoot\config\WindowsVirtualDesktopHelper.exe.config"

# * 配置啟動執行
$startupDir = Get-Startup-Directory

New-Item -ItemType SymbolicLink -Force -Path "$startupDir\WindowsVirtualDesktopHelper.exe" -Target "$windowsVirtualDesktopHelperDir\WindowsVirtualDesktopHelper.exe"

# * 刪除臨時文件夹
Remove-Item $tempFolder -Recurse -Force