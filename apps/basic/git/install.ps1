#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\os.ps1
. $PSScriptRoot\..\..\..\utils\package_manager\winget.ps1
. $PSScriptRoot\..\..\..\utils\apt.ps1

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  Install-MyWinGetPackage -Id "Git.Git"
}
elseif ($osInfo.OS -eq 'ubuntu') {
  $ppa = "ppa:git-core/ppa"
  Add-AptRepository -PPA $ppa
  Install-AptPackage -PackageName $PackageName -Package "git"
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}
