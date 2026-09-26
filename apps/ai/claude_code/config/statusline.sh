#!/bin/sh
input=$(cat)

# ── Nerd Fonts 圖示 ──
# 如果你的終端機沒有安裝 Nerd Fonts，可以把這些改成一般文字
# 例如 ICON_CTX="ctx"、ICON_CLOCK="⏰"、ICON_COST="$"
ICON_CTX=$(printf '\357\213\233')     # 晶片圖示
ICON_CLOCK=$(printf '\357\200\227')   # 時鐘圖示
ICON_COST=$(printf '\357\205\225')    # 美元圖示
ICON_EFFORT=$(printf '\357\203\244')  # 儀表板圖示

# ── 讀取資料 ──
model=$(echo "$input" | jq -r '.model.display_name // ""')
effort=$(echo "$input" | jq -r '.effort.level // empty')
ctx_remain=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
five_h_used=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_h_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_d_used=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_d_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# ── 顏色函式：依剩餘百分比決定顏色 ──
# 綠色 ≥50% │ 黃色 21-49% │ 紅色 ≤20%
color_by_remain() {
  local val=$1
  if [ "$val" -le 20 ]; then
    printf '\033[31m'   # 紅色
  elif [ "$val" -le 49 ]; then
    printf '\033[33m'   # 黃色
  else
    printf '\033[32m'   # 綠色
  fi
}

# ── 進度條：10 格寬度 ──
mini_bar() {
  local percent=$1
  local width=10
  local filled=$((percent * width / 100))
  local empty=$((width - filled))
  local i=0
  while [ $i -lt $filled ]; do printf '━'; i=$((i + 1)); done
  while [ $i -lt $width ]; do printf '┄'; i=$((i + 1)); done
}

# ── 分隔符號 ──
SEP=$(printf '\033[2m │ \033[0m')

# ── 格式化剩餘重置時間（秒數 → "3d04h"、"1h23m" 或 "45m"） ──
format_reset() {
  local resets_at=$1
  local now diff d h m
  now=$(date +%s)
  diff=$((resets_at - now))
  if [ "$diff" -lt 0 ]; then diff=0; fi
  d=$((diff / 86400))
  h=$(((diff % 86400) / 3600))
  m=$(((diff % 3600) / 60))
  if [ "$d" -gt 0 ]; then
    printf '%dd%02dh' "$d" "$h"
  elif [ "$h" -gt 0 ]; then
    printf '%dh%02dm' "$h" "$m"
  else
    printf '%dm' "$m"
  fi
}

# ── 組合輸出 ──
parts=""

# Model（紫色粗體，讓它跟其他資訊有區隔）
if [ -n "$model" ]; then
  parts=$(printf '\033[1;35m%s\033[0m' "$model")
fi

# Effort（青色；模型不支援 effort 時不顯示）
if [ -n "$effort" ]; then
  parts="$parts$SEP$(printf '\033[36m%s %s\033[0m' "$ICON_EFFORT" "$effort")"
fi

# Context 剩餘（進度條 + 百分比）
if [ -n "$ctx_remain" ]; then
  val=$(printf '%.0f' "$ctx_remain")
  color=$(color_by_remain "$val")
  bar=$(mini_bar "$val")
  parts="$parts$SEP$(printf '%s%s %s %s%%\033[0m' "$color" "$ICON_CTX" "$bar" "$val")"
fi

# 5 小時 Rate Limit（附加剩餘重置時間）
if [ -n "$five_h_used" ]; then
  val=$((100 - $(printf '%.0f' "$five_h_used")))
  color=$(color_by_remain "$val")
  reset_str=""
  if [ -n "$five_h_resets" ]; then
    reset_str=" ($(format_reset "$five_h_resets"))"
  fi
  parts="$parts$SEP$(printf '%s%s 5h:%s%%%s\033[0m' "$color" "$ICON_CLOCK" "$val" "$reset_str")"
fi

# 7 天 Rate Limit（附加剩餘重置時間）
if [ -n "$seven_d_used" ]; then
  val=$((100 - $(printf '%.0f' "$seven_d_used")))
  color=$(color_by_remain "$val")
  reset_str=""
  if [ -n "$seven_d_resets" ]; then
    reset_str=" ($(format_reset "$seven_d_resets"))"
  fi
  parts="$parts$SEP$(printf '%s%s 7d:%s%%%s\033[0m' "$color" "$ICON_CLOCK" "$val" "$reset_str")"
fi

# Session 花費（灰色，不搶眼但需要時看得到）
if [ -n "$cost" ] && [ "$cost" != "0" ] && [ "$cost" != "null" ]; then
  parts="$parts$SEP$(printf '\033[2m%s $%s\033[0m' "$ICON_COST" "$cost")"
fi

printf '%s' "$parts"

