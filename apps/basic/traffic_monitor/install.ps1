#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\utils.ps1

# * 確保以管理員權限執行
EnsureAdmin

# * 產生一個臨時文件夹
$tempFolder = New-TemporaryDirectory

# * 設定常數# * 產生一個臨時文件夹
$repoName = "zhongyang219/TrafficMonitor" # TrafficMonitor 的 GitHub 名稱
$fileRegex = "^TrafficMonitor_.*_x64_Lite\.zip$" # 要下載的 Asset 的正則表達式

$fileName = "TrafficMonitor.zip" # 下載的檔案名稱
$tempFilePath = (Join-Path $tempFolder.FullName $fileName) # 下載位置
$appsDir = "$env:USERPROFILE\Apps"


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
Expand-Archive -Path $tempFilePath -DestinationPath $appsDir

# * 配置 TrafficMonitor 設定檔
$trafficMonitorDir = (Join-Path $appsDir "TrafficMonitor")
$startupDir = Get-Startup-Directory

New-Item -ItemType SymbolicLink -Force -Path "$trafficMonitorDir\config.ini" -Target "$PSScriptRoot\config\config.ini"
New-Item -ItemType SymbolicLink -Force -Path "$trafficMonitorDir\global_cfg.ini" -Target "$PSScriptRoot\config\global_cfg.ini"
New-Item -ItemType SymbolicLink -Force -Path "$startupDir\TrafficMonitor.exe" -Target "$trafficMonitorDir\TrafficMonitor.exe"


# * 刪除臨時文件夹
Remove-Item $tempFolder -Recurse -Force