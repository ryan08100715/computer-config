Clear-Host

#####################
# Powershell 7 配置  #
#####################

# Tab 補全顯示全部選項
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# 自定義 Tab 補全
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    # 定義縮寫映射
    $abbreviations = @{
        'pa' = 'php artisan '
        'hpa' = 'herd php artisan '
    }

    # 檢查當前輸入是否匹配縮寫
    $words = $line.Split(' ')
    $lastWord = $words[-1]

    if ($abbreviations.ContainsKey($lastWord)) {
        $expansion = $abbreviations[$lastWord]
        $newLine = $line.Substring(0, $cursor - $lastWord.Length) + $expansion
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $newLine)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($newLine.Length)
    } else {
        # 如果不匹配縮寫，執行正常的 Tab 補全
        [Microsoft.PowerShell.PSConsoleReadLine]::TabCompleteNext()
    }
}

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

# 如果有安裝 gsudo 則設定別名
if (Get-Command gsudo -ErrorAction SilentlyContinue) {
  # 變更 cat 別名為 bat
  Set-Alias -Name sudo -Value gsudo
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
