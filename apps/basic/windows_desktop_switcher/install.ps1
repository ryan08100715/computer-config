#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\github.ps1

$PackageName = "Windows Desktop Switcher"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

Update-EnvPath
Exit-WhenCommandNotExist -Command git

$appsDir = Get-MyAppsDirectoryPath
$dirName = "windows-desktop-switcher"
$windowsDesktopSwitcherDir = Join-Path $appsDir $dirName

# 檢查是否已經安裝
if (Test-Path $windowsDesktopSwitcherDir) {
  Write-MyWarning -Icon "$PackageName 已安裝，若要重新安裝請手動刪除資料夾: $windowsDesktopSwitcherDir"
  exit
}

# * 產生一個臨時文件夹
$tempFolder = New-TemporaryDirectory

# * 下載專案
git clone https://github.com/pmb6tz/windows-desktop-switcher.git "$tempFolder\$dirName"

# * 下載最新的 VirtualDesktopAccessor.dll
$metadata = Get-GithubFileMetadata -RepoName "Ciantic/VirtualDesktopAccessor" -FileRegex "^VirtualDesktopAccessor\.dll$"
Invoke-WebRequest -Uri $metadata.DownloadUrl -OutFile "$tempFolder\VirtualDesktopAccessor.dll"

# * 移動專案
Move-Item -Force -Path "$tempFolder\$dirName" -Destination $appsDir
Move-Item -Force -Path "$tempFolder\VirtualDesktopAccessor.dll" -Destination "$windowsDesktopSwitcherDir\VirtualDesktopAccessor.dll"

# * 刪除臨時文件夹
Remove-Item $tempFolder -Recurse -Force

Write-MySuccess -Icon "安裝完成"
Write-MyInfo ""
