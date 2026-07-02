#!/bin/bash
if pgrep -f picom &>/dev/null 2>&1; then
  echo "Turning compton OFF"
  pkill picom &
else
  echo "Turning compton ON"
  #picom -c -C -t-5 -l-5 --backend glx --vsync -O.55 -r4 -o.55 &
  picom --backend glx &
fi
exit 0
