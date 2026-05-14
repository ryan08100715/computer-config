if status is-interactive
  # starship 已安裝才執行
  if command -q starship
      starship init fish | source
  end
end