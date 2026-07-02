xrandr --output eDP-1 --rotate right
xrandr  --output DP-1 --mode 1680x1050 --above eDP-1 --set 'underscan' 'on' --set 'underscan vborder' 128  --set 'underscan hborder' 128 --pos 10x10
xinput --set-prop 16 166 0 1 0 -1 0 1 0 0 1

xinput --set-prop 12 166 1 0 0 0 1 0 0 0 1
