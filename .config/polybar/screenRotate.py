#!/usr/bin/env python3
import i3ipc
import os
import sys
from subprocess import check_call, check_output
from glob import glob
orientations = ['left', 'right', 'normal', 'inverted']


STATES = [
    {'rot': 'normal', 'coord': '1 0 0 0 1 0 0 0 1', 'touchpad': 'enable',
     'check': lambda x, y: y <= -g},
    #{'rot': 'inverted', 'coord': '1 -1 0 1 1 0 0 0 1', 'touchpad': 'disable',
    {'rot': 'inverted', 'coord': '-1 0 1 0 -1 1 0 0 1', 'touchpad': 'disable',
     'check': lambda x, y: y >= g},
    #{'rot': 'left', 'coord': '1 0 0 0 1 0 0 0 1', 'touchpad': 'disable',
    {'rot': 'left', 'coord': '0 -1 1 1 0 0 0 0 1', 'touchpad': 'disable',
     'check': lambda x, y: x >= g},
    #{'rot': 'right', 'coord': '0 1 0 -1 0 0 0 0 1','touchpad': 'disable',

    {'rot': 'right', 'coord': '0 1 0 -1 0 1 0 0 1', 'touchpad': 'disable',
     'check': lambda x, y: x <= -g},
]

if len(sys.argv) != 2 or sys.argv[1] not in orientations:
    print(f'Usage: {sys.argv[0]} [left|right|normal|inverted]')
    sys.exit(-1)

orientation = sys.argv[1]
coord=''
for i in range(4):
    if(STATES[i]['rot']==orientation):
        coord = STATES[i]['coord']


devices = check_output(['xinput', '--list', '--name-only'],text=True).splitlines()

touchscreen_names = ['touchscreen', 'wacom','pen','pointer','fts']
touchscreens = [i for i in devices if any(j in i.lower() for j in touchscreen_names)]


i3 = i3ipc.Connection()



outputs = [o.name for o in i3.get_outputs()]
workspaces = i3.get_workspaces()
focused_workspace = [w for w in workspaces if w.focused][0]
focused_output = focused_workspace.output

if focused_output not in outputs:
    print('Detected output not in list, something is weird....')
    sys.exit(-2)

os.system(f'/usr/bin/xrandr --output "{focused_output}" --rotate "{orientation}"')
if(focused_output == 'eDP-1'):
    for dev in touchscreens:
        print("got here!")
        check_call([
        'xinput', 'set-prop', dev,
        'Coordinate Transformation Matrix',] + coord.split())
output_is_primary = [o.primary for o in i3.get_outputs() if o.name==focused_output][0]
if not output_is_primary:
    i3.command(f'workspace {focused_workspace.name}')
