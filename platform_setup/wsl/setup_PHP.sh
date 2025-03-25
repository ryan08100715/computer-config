#!/usr/bin/env bash

# * 更新系統
sudo apt-get update
sudo apt-get upgrade -y

# * 安裝常用工具
sudo apt-get install -y zip unzip curl

# * 匯入 PHP PPA
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

# * 安裝 PHP
sudo apt-get install -y php8.3 php8.3-fpm

# * 安裝 PHP Extensions
sudo apt-get install -y php8.3-curl php8.3-mbstring php8.3-xml
sudo apt-get install -y php8.3-sqlite3 php8.3-mysql php8.3-pgsql php8.3-redis
sudo apt-get install -y php8.3-xdebug php8.3-zip

# * 安裝 Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >>~/.bashrc

# * 安裝 Laravel
composer global require "laravel/installer"

# * 安裝 Nodejs

# Download and install fnm:
curl -o- https://fnm.vercel.app/install | bash

# Download and install Node.js:
bash -i -c "fnm install 22"
