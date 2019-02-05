#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Script Name	:	bgm_play.sh
#Version		:	1.0
#Date			:	20190205	(YYYYMMDD)
#Description	:	This script resume the music player depending on the settings.
#Usage			:	It should be called from other scripts only.
#Author       	:	Luís Torres aka Naprosnia
#Git         	:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################

if [ ! -e /home/pi/.bgmstop ]; then
       sudo pkill -CONT mpg123
fi
