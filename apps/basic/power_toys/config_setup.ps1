#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1

$backupDir = "$HOME\Documents\PowerToys\Backup"
$fileName = "settings_133872081475133648.ptb"
Copy-Item -Force -Path "$PSScriptRoot\config\$fileName" -Destination "$backupDir\$fileName"
Write-MySuccess -Icon "放置備份設定檔到: $backupDir\$fileName"

Write-MyInfo ""
