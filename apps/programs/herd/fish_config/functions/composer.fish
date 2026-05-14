# herd 已安裝才執行
function composer --wraps='herd composer' --description 'alias composer=herd composer'
  if type -q herd
    herd composer $argv
  else
    command composer $argv
  end
end
