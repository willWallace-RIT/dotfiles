!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybarexample.log /tmp/polybartouch.log /tmp/polybarxreal.log

polybar xreal 2>&1 | tee -a /tmp/polybarexample.log & disown
polybar example 2>&1 | tee -a /tmp/polybarexample.log & disown
polybar touch 2>&1 | tee -a /tmp/polybartouch.log & disown
echo "Bars launched..."


