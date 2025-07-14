#!/usr/bin/env pwsh

param (
  [Parameter()]
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
    $WingetPackageID = "AutoHotkey.AutoHotkey"

    # 安裝 V1 版本
    Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID -Version "1.1.37.02" -Silent:$Silent
    # 固定版本，避免升級到 V2
    Pin-MyWinGetPackage -WingetPackageID $WingetPackageID -PinVersion "1.*" -Silent
  }
  elseif ($WinPackageManager -eq "choco") {
    Exit-WhenCommandNotExist -Command choco
    Install-MyChocoPackage -Id "autohotkey" -Version "1.1.37.1" -Pin
  }
  else {
    Write-MyWarning -Icon "不支援的安裝方式: $WinPackageManager"
  }
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
