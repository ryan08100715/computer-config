#!/usr/bin/env pwsh

param (
  [Parameter(Mandatory)]
  [ValidateSet("winget", "choco")]
  [string]$WinPackageManager = "winget"
)

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\os.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\package_manager\winget.ps1
. $PSScriptRoot\..\..\..\utils\package_manager\choco.ps1

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  if ($WinPackageManager -eq "winget") {
    UnInstall-MyWinGetPackage -Id "yt-dlp.yt-dlp"
  }
  elseif ($WinPackageManager -eq "choco") {
    Exit-WhenCommandNotExist -Command choco
    UnInstall-MyChocoPackage -Id "yt-dlp"
  }
  else {
    Write-MyWarning -Icon "不支援的解除安裝方式: $WinPackageManager"
  }
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
