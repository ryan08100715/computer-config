# bat 已安裝才執行
if type -q bat
  function cat --wraps=bat --description 'alias cat=bat'
    bat $argv      
  end
end

