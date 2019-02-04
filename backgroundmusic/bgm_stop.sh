#!/usr/bin/env bash
if [ ! -e /home/pi/.bgmstop ]; then
       sudo pkill -STOP mpg123
fi
