#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1

$PackageName = "Notion"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  $WingetPackageID = "Notion.Notion"

  Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
