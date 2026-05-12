# eza 已安裝才執行
if type -q eza
  function ls --wraps=eza --description 'alias ls=eza'
    eza --group-directories-first $argv
  end
end

