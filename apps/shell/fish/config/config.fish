if test -d $HOME/.config/composer/vendor/bin
    fish_add_path $HOME/.config/composer/vendor/bin
end

if test -d /opt/homebrew/opt/mysql-client/bin
    fish_add_path /opt/homebrew/opt/mysql-client/bin
end

# 添加縮寫
abbr --add pa "php artisan"
