#!/usr/bin/env pwsh

. $PSScriptRoot\utils\output.ps1

function Install-WinGetModule {
  # 檢查 WinGet PowerShell 模組是否已安裝
  if (Get-InstalledModule -Name Microsoft.WinGet.Client -ErrorAction SilentlyContinue) {
    Write-MyWarning "WinGet PowerShell 模組已安裝"
    return
  }

  # 安裝 WinGet PowerShell 模組
  Write-MyInfo "安裝 WinGet PowerShell 模組..."
  Install-Module -Name Microsoft.WinGet.Client
}

function Install-VirtualDesktopModule {
  # 檢查 VirtualDesktop 模組是否已安裝
  if (Get-InstalledModule -Name VirtualDesktop -ErrorAction SilentlyContinue) {
    Write-MyWarning "VirtualDesktop 模組已安裝"
    return
  }

  # 安裝 VirtualDesktop 模組
  Write-MyInfo "安裝 VirtualDesktop 模組..."
  Install-Module -Name VirtualDesktop
}

# Install-WinGetModule
Install-VirtualDesktopModule
