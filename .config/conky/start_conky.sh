#!/bin/bash
killall conky
sleep 2
conky -c ~/.config/conky/conky.conf &
conky -c ~/.config/conky/conkyleft.conf &
