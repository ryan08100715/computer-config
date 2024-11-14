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
