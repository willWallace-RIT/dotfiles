#!/usr/bin/sh
xinput --set-prop 12 166 1 0 0 0 1 0 0 0 1
exec python .config/polybar/screenRotate.py right | return 0
