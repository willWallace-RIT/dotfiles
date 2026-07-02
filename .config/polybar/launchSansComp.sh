#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
screens=$(xrandr --listactivemonitors | grep -v "Monitors"|cut -d" " -f6)

echo "---" | tee -a /tmp/polybarnoComp.log
if [[ $(xrandr --listactivemonitors |grep -v "Monitors"|cut -d" " -f4|cut -d"+" -f2- | uniq | wc -l) -eq 1 ]]; then echo "single mon" | tee -a /tmp/polybarnoComp.log & MONITOR=$(polybar --list-monitors | cut -d":" -f1) TRAY_POS=right polybar noComp 2>&1 | tee -a /tmp/polybarnoComp.log & disown & else primary=$(xrandr --query | grep primary | cut -d" " -f1)
  for m in $screens; do if [[ $primary == $m ]]; then
    

    echo "multimon: ${m}" | tee -a /tmp/polybarnoComp.log
    MONITOR=$m TRAY_POS=right polybar noComp 2>&1 | tee -a /tmp/polybarnoComp.log & disown & else
    MONITOR=$m TRAY_POS=right polybar noComp 2>&1 | tee -a /tmp/polybarnoComp.log & disown & fi done
fi
#echo "---" | tee -a /tmp/polybarnoComp.log
#polybar noComp 2>&1 | tee -a /tmp/polybarnoComp.log & disown
#polybar touch 2>&1 | tee -a /tmp/polybartouch.log & disown
echo "Bars launched..."

