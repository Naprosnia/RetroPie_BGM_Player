#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Script Name	:	Background Music Settings.sh
#Version		:	1.0
#Date			:	20190205	(YYYYMMDD)
#Description	:	This script produce a menu to select the settings
#				:	you want to change.
#Usage			:	run from RetroPie menu in EmulationStation or
#				:	sudo bash ~/RetroPie/retropiemenu/Background\ Music\ Settings.sh
#Author       	:	Luís Torres aka Naprosnia
#Git         	:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " RetroPie_BGM_Player " \
            --ok-label OK --cancel-label Exit \
            --menu "What you want to set?" 25 75 20 \
            1 "Turn Background Music On/Off" \
            2 "Set Background Music Volume" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) toggle_menu  ;;
            2) vol_menu  ;;
            *)  break ;;
        esac
    done
}

function toggle_menu(){
	bash /opt/retropie/configs/all/retropie_bgm_player/togglebgm.sh
}

function vol_menu(){
	bash /opt/retropie/configs/all/retropie_bgm_player/bgmvolume.sh
}

main_menu

