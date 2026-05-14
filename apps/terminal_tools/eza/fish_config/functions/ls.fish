# eza 已安裝才執行
if command -q eza
  function ls --wraps=eza --description 'alias ls=eza'
    eza --group-directories-first $argv
  end
end

