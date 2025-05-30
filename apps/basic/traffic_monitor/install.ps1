#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\github.ps1

# * 產生一個臨時文件夹
$tempFolder = New-TemporaryDirectory

# * 設定常數
$PackageName = "TrafficMonitor"
$repoName = "zhongyang219/TrafficMonitor" # TrafficMonitor 的 GitHub 名稱
$fileRegex = "^TrafficMonitor_.*_x64_Lite\.zip$" # 要下載的 Asset 的正則表達式

$fileName = "TrafficMonitor.zip" # 下載的檔案名稱
$tempFilePath = (Join-Path $tempFolder.FullName $fileName) # 下載位置
$appsDir = Get-MyAppsDirectoryPath
$trafficMonitorDir = (Join-Path $appsDir "TrafficMonitor")

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

if (Test-Path $trafficMonitorDir) {
  Write-MySuccess -Icon "$PackageName 已安裝"

  Write-MyInfo "檢查是否需要更新"
  $currentMetadata = Get-Content -Path "$trafficMonitorDir\package_metadata.json" -Raw -Encoding utf8 | ConvertFrom-Json
  $latestMetadata = Get-GithubFileMetadata -RepoName $repoName -FileRegex $fileRegex
  if ($currentMetadata.Version -ne $latestMetadata.Version) {
    Write-MyWarning -Icon "有新版本可供安裝，開始進行更新"

    # * 下載Asset到臨時文件夹
    Invoke-WebRequest -Uri $latestMetadata.DownloadUrl -OutFile $tempFilePath

    # * 解壓縮到應用程式資料夾
    Remove-Item -Path $trafficMonitorDir -Recurse -Force
    Expand-Archive -Path $tempFilePath -DestinationPath $appsDir -Force

    # * 寫入 Metadata
    $latestMetadata | ConvertTo-Json | Set-Content -Encoding utf8 -Path "$trafficMonitorDir\package_metadata.json"

    Write-MySuccess -Icon "更新完成"
  }
  else {
    Write-MySuccess -Icon "已經是最新版本"
  }
}
else {
  Write-MyInfo "$PackageName 尚未安裝，開始進行安裝"

  # * 下載Asset到臨時文件夹
  $metadata = Get-GithubFileMetadata -RepoName $repoName -FileRegex $fileRegex
  Invoke-WebRequest -Uri $metadata.DownloadUrl -OutFile $tempFilePath

  # * 解壓縮到應用程式資料夾
  Expand-Archive -Path $tempFilePath -DestinationPath $appsDir -Force

  # * 寫入 Metadata
  $metadata | ConvertTo-Json | Set-Content -Encoding utf8 -Path "$trafficMonitorDir\package_metadata.json"

  Write-MySuccess -Icon "安裝完成"
}

# * 刪除臨時文件夹
Remove-Item $tempFolder -Recurse -Force

Write-MyInfo ""
