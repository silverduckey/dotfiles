#!/bin/sh
killall picom
killall lxsession
killall ibus-daemon
. $HOME/.screenlayout/screenlayout.sh
feh --bg-fill --randomize $HOME/.wallpapers &
picom &
lxsession &
ibus start
