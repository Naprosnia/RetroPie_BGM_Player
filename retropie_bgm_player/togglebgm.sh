#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Script Name	:	togglebgm.sh
#Version		:	1.0
#Date			:	20190205	(YYYYMMDD)
#Description	:	This script produce a menu to enable or disable
#				:	RetroPie_BGM_Player.
#Usage			:	It should be called from other scripts only.
#Author       	:	Luís Torres aka Naprosnia
#Git         	:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################

#prepare message to display
if [ -e /home/pi/.bgmstop ]; then
	menutitle="Off"
	selecttext="On"
else
	menutitle="On"
	selecttext="Off"
fi

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Background Music On/Off " \
            --ok-label OK --cancel-label Back \
            --menu "You have Background Music set to $menutitle" 25 75 20 \
            1 "Turn Background Music $selecttext" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) applychanges  ;;
            *)  break ;;
        esac
    done
}

function applychanges(){
	stop_bgm()
	{
		sudo touch /home/pi/.bgmstop
		sudo pkill -STOP mpg123
	}

	start_bgm()
	{
		sudo rm /home/pi/.bgmstop
		sudo pkill -CONT mpg123
	}

	if [ -e /home/pi/.bgmstop ]; then
			start_bgm
			bash /opt/retropie/configs/all/retropie_bgm_player/togglebgm.sh
			exit
	else
			stop_bgm
			bash /opt/retropie/configs/all/retropie_bgm_player/togglebgm.sh
			exit
	fi
}

main_menu