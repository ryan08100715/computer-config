#!/usr/bin/env bash

mkdir -p "$HOME/.ssh"
echo "" >> "$HOME/.ssh/config"
echo "Host *" >> "$HOME/.ssh/config"
echo "    IdentityAgent \"~/.bitwarden-ssh-agent.sock\"" >> "$HOME/.ssh/config"
