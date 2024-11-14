#!/usr/bin/env fish

if fisher list jorgebucaran/nvm.fish > /dev/null
  exit
end

fisher install jorgebucaran/nvm.fish