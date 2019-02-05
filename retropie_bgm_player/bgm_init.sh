#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Script Name	:	bgm_init.sh
#Version		:	1.0
#Date			:	20190205	(YYYYMMDD)
#Description	:	This script start RetroPie_BGM_Player, and check for saved settings.
#				:	It start the player after omxplayer (splashscreens).
#Usage			:	It should be called from other scripts only.
#Author       	:	Luís Torres aka Naprosnia
#Git         	:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################


#player volume goes from 1 to 32768

while pgrep omxplayer >/dev/null; do sleep 1; done
sleep 2

#verify volume file .bgmvolume
if [ ! -e /home/pi/.bgmvolume ]; then
	echo "bgmvolume=16384">/home/pi/.bgmvolume
	bgmvolume=16384
else
	source /home/pi/.bgmvolume
fi

setsid mpg123 -f $bgmvolume -Z ~/RetroPie/roms/music/*.mp3 >/dev/null 2>&1 &

if [ -e /home/pi/.bgmstop ]; then
	sudo pkill -STOP mpg123
fi
