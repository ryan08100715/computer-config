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
sudo apt-get install -y php8.3-curl php8.3-mbstring php8.3-xml php8.3-intl
sudo apt-get install -y php8.3-sqlite3 php8.3-mysql php8.3-pgsql php8.3-redis
sudo apt-get install -y php8.3-xdebug php8.3-zip

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
