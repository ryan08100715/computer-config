Clear-Host

#####################
# Powershell 7 配置  #
#####################

# Tab 補全顯示全部選項
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# 預測顯示為多行列表，預設為 Inline
Set-PSReadLineOption -PredictionViewStyle ListView

############
# 別名配置  #
############

# 如果有安裝 lsd 則設定別名
if (Get-Command lsd -ErrorAction SilentlyContinue) {
  # 變更 ls 別名為 lsd
  Set-Alias -Name ls -Value lsd
}

# 如果有安裝 bat 則設定別名
if (Get-Command bat -ErrorAction SilentlyContinue) {
  # 變更 cat 別名為 bat
  Set-Alias -Name cat -Value bat
}

###############
# CLI 工具加載 #
###############

# 如果有安裝 starship 則添加 starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

# 如果有安裝 zoxide 則添加 zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
