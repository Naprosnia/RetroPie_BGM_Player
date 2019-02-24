#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_setplayer.sh
#Date			:	20190222	(YYYYMMDD)
#Description	:	BGM Player select player menu.
#Usage			:	Should be called from bgm_control.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

BGM="$HOME/RetroPie-BGM-Player"
BGMSETTINGS="$BGM/bgm_settings.ini"
VERSION="$BGM/version.sh"
source $VERSION >/dev/null 2>&1

function description() {
infobox=
infobox="${infobox}___________________________________________________________________________\n\n"
infobox="${infobox}RetroPie BGM Player Player Select\n\n"
infobox="${infobox}Set BGM Player. MP3 or Emulated .\n"
infobox="${infobox}___________________________________________________________________________\n\n"

dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "BGM Player Select Description" --msgbox "${infobox}" 0 0
}
#description

function main_menu() {
    local choice

    while true; do
	
		source $BGMSETTINGS >/dev/null 2>&1
		[ "$bgm_player" == "mp3player" ] && mp3p="X" || mp3p=" "
		[ "$bgm_player" == "vgmplayer" ] && vgmp="X"  || vgmp=" "
		[ "$bgm_player" == "both" ] && bothp="X"  || bothp=" "
		
        choice=$(dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "Player Select" \
            --ok-label "Select" --cancel-label "Back" --no-tags --default-item "$bgm_player" \
            --menu "Select your Player" 25 75 20 \
            "mp3player" "1 [$mp3p] MP3 Player" \
			"vgmplayer" "2 [$vgmp] VGM Player" \
			"both" "3 [$bothp] Both Players" \
            2>&1 > /dev/tty)

        opt=$?
		[ $opt -eq 1 ] && exit
		
		bash $BGM/bgm_system.sh -setsetting bgm_player $choice
		bash $BGM/bgm_system.sh -i
		
    done
}

main_menu