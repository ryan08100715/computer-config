#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\os.ps1
. $PSScriptRoot\..\..\..\utils\package_manager\winget.ps1

$osInfo = Get-MyOSInfo

if ($osInfo.OS -eq 'windows') {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
else {
  Write-MyWarning -Icon "不支援的作業系統: $($osInfo.OS)"
}

