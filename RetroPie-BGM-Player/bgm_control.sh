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

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "RetroPie BGM Player" --title "RetroPie BGM Player Settings" \
            --ok-label "Select" --cancel-label "Exit" --no-tags \
            --menu "Settings" 25 75 20 \
            "bgm_setvolume" "1 BGM Volume" \
            "bgm_settoggle" "2 BGM Toggle" \
			"bgm_setfade" "3 BGM Fade Effect" \
			"bgm_setnonstop" "4 BGM Non Stop" \
			"bgm_setdelay" "5 BGM Delay" \
			"bgm_updater" "5 BGM Update" \
            2>&1 > /dev/tty)
		
		opt=$?
		[ $opt -eq 1 ] && exit
		
        bash $BGMCONTROL/$choice.sh
		
    done
}

main_menu

