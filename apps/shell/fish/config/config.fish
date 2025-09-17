if status is-interactive
  # Commands to run in interactive sessions can go 
  
  # starship 已安裝才執行
  if type -q starship
      starship init fish | source
  end
end

# fnm 已安裝才執行
if test -d $HOME/.local/share/fnm
    fish_add_path $HOME/.local/share/fnm
    fnm env --use-on-cd --shell fish | source
end

if test -d $HOME/.config/composer/vendor/bin
    fish_add_path $HOME/.config/composer/vendor/bin
end

# 添加縮寫
abbr --add pa "php artisan"
