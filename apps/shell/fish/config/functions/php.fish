# herd 已安裝才執行
if type -q herd
  function php --wraps='herd php' --description 'alias php=herd php'
    herd command php $argv      
  end
end

