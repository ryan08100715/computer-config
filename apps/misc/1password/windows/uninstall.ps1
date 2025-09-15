#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\..\utils\os.ps1
. $PSScriptRoot\..\..\..\..\utils\package_manager\winget.ps1

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  UnInstall-MyWinGetPackage -Id "AgileBits.1Password"
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
