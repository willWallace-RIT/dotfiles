#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2

while pgrep -x polybar>/dev/null; do sleep 1; done
screens=$(xrandr --listactivemonitors | grep -v "Monitors"|cut -d" " -f6)

echo "---" | tee -a /tmp/polybarexample.log
if [[ $(xrandr --listmonitors |grep -v "Monitors"|cut -d" " -f4|cut -d"+" -f2- | uniq | wc -l) -eq 1 ]]; then echo "single mon" | tee -a /tmp/polybarexample.log & MONITOR=$(polybar --list-monitors | cut -d":" -f1) TRAY_POS=right polybar example 2>&1 | tee -a /tmp/polybarexample.log & disown & else primary=$(xrandr --query | grep primary | cut -d" " -f1)
  for m in $screens; do if [[ $primary == $m ]]; then
    

    echo "multimon: ${m}" | tee -a /tmp/polybarexample.log
    MONITOR=$m TRAY_POS=right polybar example 2>&1 | tee -a /tmp/polybarexample.log & disown & else
    MONITOR=$m TRAY_POS=right polybar example 2>&1 | tee -a /tmp/polybarexample.log & disown & fi done
fi
#polybar example 2>&1 | tee -a /tmp/polybarexample.log & disown
#polybar touch 2>&1 | tee -a /tmp/polybartouch.log & disown
echo "Bars launched..."
