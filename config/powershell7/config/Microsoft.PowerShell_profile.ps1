using namespace System.Management.Automation
using namespace System.Management.Automation.Language

# Powershell 7 配置
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# Set-PSReadLineOption -PredictionViewStyle ListView

# 如果有安裝 starship 則添加 starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

# 如果有安裝 lsd 則設定別名
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  # 變更 ls 別名為 lsd
  Set-Alias -Name ls -Value lsd    
}

# 如果有安裝 zoxide 則添加 zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
