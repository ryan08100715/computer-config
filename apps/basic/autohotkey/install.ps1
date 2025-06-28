#!/usr/bin/env pwsh

param(
  [switch]$Silent
)

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1

$PackageName = "AutoHotkey"

Write-MyInfo "開始執行 $PackageName 安裝腳本..." -Silent:$Silent

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  $WingetPackageID = "AutoHotkey.AutoHotkey"

  # 安裝 V1 版本
  Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID -Version "1.1.37.02" -Silent:$Silent
  # 固定版本，避免升級到 V2
  Pin-MyWinGetPackage -WingetPackageID $WingetPackageID -PinVersion "1.*" -Silent
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}

#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\os.ps1
. $PSScriptRoot\..\..\..\utils\package_manager\winget.ps1

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  $wingetId = "AutoHotkey.AutoHotkey"
  # 安裝 V1 版本
  Install-MyWinGetPackage -Id $wingetId -Version "1.1.37.02"
  # 固定版本，避免升級到 V2
  Pin-MyWinGetPackage -Id $wingetId -PinVersion "1.*"
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
