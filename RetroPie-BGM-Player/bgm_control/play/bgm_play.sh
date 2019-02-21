#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_control.sh
#Date			:	20190218	(YYYYMMDD)
#Description	:	BGM Player settings main menu.
#Usage			:	Should be called from RetroPie\ BGM\ Player.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

# shorten paths
BGM="$HOME/RetroPie-BGM-Player"
BGMCONTROL="$BGM/bgm_control"
BGMCONTROLPLAY="$BGMCONTROL/play"
VERSION="$BGM/version.sh"
source $VERSION >/dev/null 2>&1

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "Play Settings" \
            --ok-label "Select" --cancel-label "Back" --no-tags \
            --menu "Settings" 25 75 20 \
			"bgm_setfade" "1 Fade Effect" \
			"bgm_setnonstop" "2 Non Stop" \
			"bgm_setdelay" "3 Delay" \
            2>&1 > /dev/tty)
		
		opt=$?
		[ $opt -eq 1 ] && exit
		
        bash $BGMCONTROLPLAY/$choice.sh
		
    done
}

main_menu

