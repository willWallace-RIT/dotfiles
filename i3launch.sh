ln -s -f ~/.config/i3/configWithComp ~/.config/i3/config
ln -s -f ~/XResourcesComp ~/.Xresources
xrandr --output eDP-1 --rotate right
xrdb -load ~/.Xresources
i3 -d all
