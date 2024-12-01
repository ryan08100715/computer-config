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
$pwshProfilePath = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if ( Test-Path $pwshProfilePath) {
  # 檢查是否已存在 lsd 的别名
  $aliasExists = Get-Content $pwshProfilePath | Select-String "Set-Alias -Name ls -Value lsd"

  if (-not $aliasExists) {
    $content = @" 
# 如果有安裝 lsd 則設定別名
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    # 變更 ls 別名為 lsd
    Set-Alias -Name ls -Value lsd    
}
"@
    # 如果不存在，添加别名
    Add-Content -Path $pwshProfilePath -Value $content
  }
}
