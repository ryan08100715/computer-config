#!/usr/bin/env bash

if command -v fish &>/dev/null; then
    fish -c "fish_add_path -U '$HOME/.local/bin/'"
fi
