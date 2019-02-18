#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Version		:	1.0.0
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_setingame.sh
#Date			:	20190216	(YYYYMMDD)
#Description	:	BGM Player over game setting menu.
#Usage			:	Should be called from bgm_control.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

BGM=$HOME"/RetroPie-BGM-Player"
BGMCONTROL=$BGM"/bgm_control"
BGMSETTINGS=$BGM"/bgm_settings.cfg"

function main_menu() {
    local choice

    while true; do
	
		source $BGMSETTINGS >/dev/null 2>&1
		[ $bgm_ingame -eq 0 ] && status=( "disabled" "Enable" 1 )  || status=( "enabled" "Disable" 0 )
		
        choice=$(dialog --backtitle "RetroPie BGM Player" --title "BGM Over Game Setting" \
            --ok-label "Select" --cancel-label "Back" --no-tags \
            --menu "BGM Player Over Game is ${status[0]}" 25 75 20 \
            1 "${status[1]} Over Game" \
            2>&1 > /dev/tty)

        opt=$?
		[ $opt -eq 1 ] && exit
		
		bash $BGM/bgm_system.sh -setsetting bgm_ingame ${status[2]}
		
    done
}

main_menu
