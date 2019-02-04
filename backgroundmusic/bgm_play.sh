#!/usr/bin/env bash
if [ ! -e /home/pi/.bgmstop ]; then
       sudo pkill -CONT mpg123
fi
