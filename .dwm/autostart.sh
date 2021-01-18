#!/bin/sh
~/.fehbg &
dunst &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nm-applet &
blueman-applet &
( ps -e | grep "[r]edshift" || redshift ) &
wmname compiz &
