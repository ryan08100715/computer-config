#!/usr/bin/env pwsh

. $PSScriptRoot\utils.ps1

function Register-MyAutoRunOnStartupTask {
  param (
    [Parameter(Mandatory)]
    [string]$AppName,
    [Parameter(Mandatory)]
    [string]$ExePath,
    [switch]$RunAsAdministrator = $false,
    [switch]$Recreate = $false
  )

  EnsureAdminRun

  # 定義應用程式的路徑和使用者
  $taskPath = "\MyTasks\"
  $taskName = "$AppName Autorun for $env:USERNAME"
  $userId = "$env:USERNAME"

  # 檢查是否已經存在同名任務
  $registeredTask = Get-ScheduledTask -TaskName $taskName -TaskPath $taskPath -ErrorAction SilentlyContinue
  if ($null -ne $registeredTask) {
    if (-not $Recreate) {
      return
    }
    # 刪除已經存在的任務
    Unregister-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Confirm:$false
  }

  # 創建觸發條件：使用者登入時
  $trigger = New-ScheduledTaskTrigger -AtLogOn -User $userId
  $trigger.Delay = "PT3S"

  # 創建動作：啟動程式
  $action = New-ScheduledTaskAction -Execute $ExePath

  # 設置任務的屬性
  $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0

  # 設置權限屬性
  $principalOptions = @{
    "UserId" = $userId
  }
  if ($RunAsAdministrator) {
    $principalOptions["RunLevel"] = "Highest"
  }
  $principal = New-ScheduledTaskPrincipal @principalOptions

  # 創建任務
  $task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -Principal $principal

  # 註冊任務（需要管理員權限）
  Register-ScheduledTask -TaskName $taskName -InputObject $task -TaskPath $taskPath -User $userId | Out-Null
}
