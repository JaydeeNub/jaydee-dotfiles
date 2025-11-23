#!/bin/bash
killall conky
sleep 2
conky -c ~/.config/conky/conkyright.conf &
conky -c ~/.config/conky/conkyleft.conf &
