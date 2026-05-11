# herd 已安裝才執行
function php --wraps='herd php' --description 'alias php=herd php'
  if type -q herd
    herd php $argv
  else
    command php $argv
  end
end
