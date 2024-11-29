#!/usr/bin/env bash

function detect_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$NAME"
  elif command -v lsb_release >/dev/null 2>&1; then
    lsb_release -is
  else
    echo "Unknow"
  fi
}

function detect_os_version() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$VERSION_ID"
  elif command -v lsb_release >/dev/null 2>&1; then
    lsb_release -rs
  else
    echo "Unknow"
  fi
}

function is_ppa_added() {
  local ppa="$1"

  if grep -q ".*$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    return 0
  else
    return 1
  fi
}

function command_is_exist() {
  local cmd="$1"

  if command -v "$cmd" >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

function get_github_asset_download_url() {
  local repo="$1"
  local asset_name_regex="$2"
  local github_api_url="https://api.github.com/repos/$repo/releases/latest"

  curl -s "$github_api_url" | jq -r ".assets[] | select(.name | test(\"$asset_name_regex\")) | .browser_download_url"
}

function create_temp_dir() {
  mktemp -d
}

function exit_on_commands_not_exist() {
  for cmd in "$@"; do
    if ! command_is_exist "$cmd"; then
      echo "Error: Command '$cmd' 不存在"
      exit 1
    fi
  done
}
