#!/usr/bin/env pwsh

function Set-Registry {
  param (
    $Path,
    $Name,
    $Value,
    $Type
  )

  # 如果路徑不存在，創建它
  if (-not (Test-Path $Path)) {
    New-Item -Path $Path | Out-Null
  }

  # 如果 Name 不存在則建立，存在則更新
  if ($null -eq (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue)) {
    New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type | Out-Null
  }
  else {
    Set-ItemProperty -Path $Path -Name $Name -Value $Value | Out-Null
  }
}
