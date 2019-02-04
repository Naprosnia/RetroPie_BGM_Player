#!/usr/bin/env bash
#ficheiro para iniciar antes do emulation station
#mpg123 volume = -f xxx   Choose a number between 1 and 32768 - 3/4=8192
#while pgrep omxplayer >/dev/null; do sleep 1; done
#(sleep 15; mpg123 -f 8192 -Z ~/RetroPie/roms/music/*.mp3 >/dev/null 2>&1) &

while pgrep omxplayer >/dev/null; do sleep 1; done
sleep 3

#verify volume file .bgmvolume
if [ ! -e /home/pi/.bgmvolume ]; then
	#check if it not exist and create one with 50% volume
	echo "bgmvolume=16384">/home/pi/.bgmvolume
	#set var
	bgmvolume=16384
else
	#read file and get var
	source /home/pi/.bgmvolume
fi

setsid mpg123 -f $bgmvolume -Z ~/RetroPie/roms/music/*.mp3 >/dev/null 2>&1 &

if [ -e /home/pi/.bgmstop ]; then
	sudo pkill -STOP mpg123
fi
