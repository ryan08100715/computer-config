#!/usr/bin/env bash

if pgrep -xq Tangrid; then
    osascript -e 'quit app id "com.wrapper.Tangrid"'
    while pgrep -xq Tangrid; do sleep 0.5; done
fi

rm -rf /Applications/Tangrid.app
