#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

EnsureAdminRun

$PackageName = "LSDeluxe"
$WingetPackageID = "lsd-rs.lsd"

# * 安裝 LSDeluxe
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID

# * 配置設定檔
Write-Host "開始進行配置"

New-Item -ItemType Directory -Path "$env:USERPROFILE\.config\lsd"
New-Item -ItemType SymbolicLink -Force -Path "$env:USERPROFILE\.config\lsd\config.yaml" -Target "$PSScriptRoot\config\config.yaml"

# * 配置 powershell alias
if ( Test-Path $PROFILE) {
  # 檢查是否已存在 lsd 的别名
  $aliasExists = Get-Content $PROFILE | Select-String "Set-Alias -Name ls -Value lsd"

  if (-not $aliasExists) {
    # 如果不存在，添加别名
    Add-Content -Path $PROFILE -Value "Set-Alias -Name ls -Value lsd"
  }
}
