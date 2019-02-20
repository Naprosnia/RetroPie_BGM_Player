#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_setvolume.sh
#Date			:	20190216	(YYYYMMDD)
#Description	:	BGM Player volume setting menu.
#Usage			:	Should be called from bgm_control.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

BGM="$HOME/RetroPie-BGM-Player"
BGMCONTROL="$BGM/bgm_control"
BGMSETTINGS="$BGM/bgm_settings.cfg"
VERSION="$BGM/version.sh"
source $VERSION >/dev/null 2>&1

infobox=
infobox="${infobox}___________________________________________________________________________\n\n"
infobox="${infobox}RetroPie BGM Player Volume\n\n"
infobox="${infobox}Change BGM Player volume.\n"
infobox="${infobox}___________________________________________________________________________\n\n"

dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "BGM Volume Description" --msgbox "${infobox}" 0 0


function main_menu() {
    local choice

    while true; do
	
		source $BGMSETTINGS >/dev/null 2>&1
		
        choice=$(dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title " BGM Volume Settings " \
            --ok-label "Select" --cancel-label "Back" --no-tags --default-item "$bgm_volume"\
            --menu "Set volume level" 25 75 20 \
            32768 "1 Volume 100%" \
            29484 "2 Volume 90%" \
            26208 "3 Volume 80%" \
            22932 "4 Volume 70%" \
            19656 "5 Volume 60%" \
            16380 "6 Volume 50%" \
            13104 "7 Volume 40%" \
            9828 "8 Volume 30%" \
            6552 "9 Volume 20%" \
            3276 "10 Volume 10%" \
            2>&1 > /dev/tty)
			
			opt=$?
			[ $opt -eq 1 ] && exit
			
			bash $BGM/bgm_system.sh -setsetting bgm_volume $choice
			bash $BGM/bgm_system.sh -r
			
    done
}

main_menu

