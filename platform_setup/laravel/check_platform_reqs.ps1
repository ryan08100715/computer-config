#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1

$requiredPHPExtensions = @(
  'ctype'
  'curl'
  'dom'
  'fileinfo'
  'filter'
  'hash'
  'mbstring'
  'openssl'
  'pcre'
  'PDO'
  'session'
  'tokenizer'
  'xml'
)

$optionPHPExtensions = @(
  # Number::currency()
  'intl'
)

Write-MyInfo "######################"
Write-MyInfo "#  檢查 PHP Version  #"
Write-MyInfo "######################"
Write-MyInfo ""

if (Get-Command php -ErrorAction SilentlyContinue) {
  $requiredPHPVersion = '8.2'
  $phpVersion = (php --version | Select-String 'PHP (\d+\.\d+\.\d+)' | ForEach-Object { $_.Matches.Groups[1].Value })

  $reqPHPVersionArray = $requiredPHPVersion -split '\.'
  $phpVersionArray = $phpVersion -split '\.'

  for ($i = 0; $i -lt $reqPHPVersionArray.Length; $i++) {
    $reqPHPPart = [int]$reqPHPVersionArray[$i] # 將字串轉為整數
    $phpPart = [int]$phpVersionArray[$i] # 將字串轉為整數

    if ($reqPHPPart -gt $phpPart) {
      Write-MyError -Icon "目前PHP版本: $phpVersion, 不符合最低要求: $requiredPHPVersion"
      exit
    }
  }

  Write-MySuccess -Icon "PHP: $phpVersion"
}
else {
  Write-MyError -Icon "PHP 未安裝"
  exit
}

Write-MyInfo ""
Write-MyInfo "#########################"
Write-MyInfo "#  檢查 PHP Extensions  #"
Write-MyInfo "#########################"
Write-MyInfo ""

foreach ($ext in $requiredPHPExtensions) {
  if (php -m | Select-String -Quiet $ext) {
    Write-MySuccess -Icon $ext
  }
  else {
    Write-MyError -Icon $ext
  }
}

foreach ($ext in $optionPHPExtensions) {
  if (php -m | Select-String -Quiet $ext) {
    Write-MySuccess -Icon $ext
  }
  else {
    Write-MyWarning -Icon $ext
  }
}
