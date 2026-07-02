import os

choices = ['deckPlusXREAL','deck']

if len(sys.argv) != 2 or sys.argv[1] not in choices:
    print(f'Usage: {sys.argv[0]} [left|right|normal|inverted]')
    sys.exit(-1)



os.system(f'/usr/bin/xrandr --output "DP-1" --rotate "right" --mode 800x1280 --primary')
if (sys.argv[1] == 'deckPlusXreal'): 
    os.system(f'/usr/bin/xrandr --output eDP-1 --')

