#!/usr/bin/env bash

# * 定義 PHP 版本變數
PHP_VERSION="8.3"

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
sudo apt-get install -y php${PHP_VERSION} php${PHP_VERSION}-fpm

# * 安裝 PHP Extensions
sudo apt-get install -y php${PHP_VERSION}-curl php${PHP_VERSION}-mbstring php${PHP_VERSION}-xml php${PHP_VERSION}-intl
sudo apt-get install -y php${PHP_VERSION}-sqlite3 php${PHP_VERSION}-mysql php${PHP_VERSION}-pgsql php${PHP_VERSION}-redis
sudo apt-get install -y php${PHP_VERSION}-xdebug php${PHP_VERSION}-zip

# * 安裝 Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >>~/.bashrc

# * 安裝 Laravel
composer global require "laravel/installer"

# * 安裝 Nodejs (使用 fnm)
# Download and install fnm:
curl -o- https://fnm.vercel.app/install | bash
# Download and install Node.js:
bash -i -c "fnm install 22"

# * 安裝 Supervisor
sudo apt-get install -y supervisor
sudo systemctl enable supervisor
sudo systemctl start supervisor.service

# * 安裝 Nginx
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx.service
SCRIPT_DIR=$(dirname "$0")
sudo cp "$SCRIPT_DIR/../laravel/nginx_conf/laravel.conf.example" /etc/nginx/sites-available/laravel.conf.example

# * 安裝 ACL
sudo apt-get install -y acl
