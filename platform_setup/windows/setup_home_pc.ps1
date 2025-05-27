#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1

$requiredApps = @(
  'apps\basic\git\install.ps1'
  'apps\basic\git\config_setup.ps1'
)

$personalizations = @(
  # * CapsToCtrl
  'personalization\change_caps\setup.ps1'

  # * 快捷鍵
  'personalization\global_shortcut\setup.ps1'

  # * Workspaces
  'personalization\workspaces\setup.ps1'

  # * 在任務欄顯示 CPU&RAM 使用量
  'personalization\show_cpu_ram_usage_on_taskbar\setup.ps1'

  # * 釘選家目錄到快速存取
  'personalization\pin_home_to_file_manager\setup.ps1'

  # * 字型
  'personalization\fonts\setup.ps1'
)

$apps = @(
  # * 基本工具
  'apps\basic\winrar\install.ps1'
  'apps\basic\autohotkey\install.ps1'
  'apps\basic\power_toys\install.ps1'
  'apps\basic\power_toys\config_setup.ps1'
  'apps\basic\snipaste\install.ps1'
  'apps\media\potplayer\install.ps1'

  # * 資料同步
  'apps\cloud_storage\google_driver\install.ps1'
  'apps\cloud_storage\megasync\install.ps1'

  # * 筆記軟體
  'apps\note_taking_software\obsidian\install.ps1'

  # * 瀏覽器
  'apps\browser\google_chrome\install.ps1'

  # * 編輯器
  'apps\editor\vscode\install.ps1'
  'apps\editor\jetbrains_toolbox\install.ps1'

  # * Shell
  'apps\shell\powershell7\install.ps1'
  'apps\shell\powershell7\config_setup.ps1'
  'apps\shell\starship\install.ps1'
  'apps\shell\starship\config_setup.ps1'

  # * Shell 命令行工具
  'apps\terminal_tools\ffmpeg\install.ps1'
  'apps\terminal_tools\lsd\install.ps1'
  'apps\terminal_tools\lsd\config_setup.ps1'
  'apps\terminal_tools\vim\install.ps1'
  'apps\terminal_tools\zoxide\install.ps1'
  'apps\terminal_tools\bat\install.ps1'
  'apps\terminal_tools\fzf\install.ps1'

  # * Terminal Emulator
  'apps\terminal\windows_terminal\install.ps1'
  'apps\terminal\windows_terminal\config_setup.ps1'

  # * 娛樂
  'apps\misc\steam\install.ps1'
  'apps\misc\discord\install.ps1'
  #'apps\misc\radmin\install.ps1'

  # * 常用開發工具
  'apps\virtualization\docker_desktop\install.ps1'
  'apps\misc\bruno\install.ps1'
  'apps\misc\drawio\install.ps1'
  'apps\database_manager_tools\heidisql\install.ps1'
  'apps\database_manager_tools\redis_insight\install.ps1'

  #############
  # Use Cases #
  #############

  # * Twitch 實況下載工作流程
  'apps\terminal_tools\ytdlp\install.ps1'

  # * 音樂下載工作流程
  'apps\terminal_tools\ytdlp\install.ps1'
  'apps\media\foobar2000\install.ps1'
  'apps\misc\mp3tag\install.ps1'
  'apps\misc\music_brainz_picard\install.ps1'

  # * PHP 開發環境
  'apps\wsl\install.ps1'
  'apps\wsl\config_setup.ps1'

  # * Jellyfin 服務
  'apps\virtualization\docker_desktop\install.ps1'
  'apps\misc\zerotier_one\install.ps1'
)

Clear-Host
Write-MyInfo "#################"
Write-MyInfo "#  安裝依賴程式 #"
Write-MyInfo "#################"
Write-MyInfo ""

foreach ($app in $requiredApps) {
  & "$PSScriptRoot\..\..\$app"
  Write-MyInfo ""
}

Write-MyInfo "################"
Write-MyInfo "#  個人化設定  #"
Write-MyInfo "################"
Write-MyInfo ""

foreach ($personalization in $personalizations) {
  & "$PSScriptRoot\..\..\$personalization"
  Write-MyInfo ""
}

Write-MyInfo "##################"
Write-MyInfo "#  應用程式安裝  #"
Write-MyInfo "##################"
Write-MyInfo ""

foreach ($app in $apps) {
  & "$PSScriptRoot\..\..\$app"
  Write-MyInfo ""
}

Write-MySuccess "應用程式安裝腳本執行完畢..."
