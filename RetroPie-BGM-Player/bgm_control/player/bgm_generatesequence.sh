#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_generatesequence.sh
#Date			:	20190218	(YYYYMMDD)
#Description	:	BGM Player sequence generator for both players
#Usage			:	Should be called from bgm_control.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

BGM="$HOME/RetroPie-BGM-Player"
VERSION="$BGM/version.sh"
source $VERSION >/dev/null 2>&1



function main_menu() {
	
	infobox=
	infobox="${infobox}___________________________________________________________________________\n\n"
	infobox="${infobox}Both Players Sequence Generator\n\n"
	infobox="${infobox}To use Both players (MP3 and VGM (emulated) (vgm, vgz, cmf, dro files)), we need to create a sequence list.\n"
	infobox="${infobox}Every time you add new songs, this list must be updated.\n\n"
	infobox="${infobox}There are two ways to update this list,\n"
	infobox="${infobox}	1.) From this menu (select Generate)\n"
	infobox="${infobox}	2.) Reboot your system and it will be generated automatically.\n\n"
	infobox="${infobox}Do you want to generate the sequence list?\n"
	infobox="${infobox}___________________________________________________________________________\n\n"

	dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "Both Players Sequence Generator" --ok-label "Generate" --cancel-label "Back" --yesno "${infobox}" 0 0
	
	opt=$?
	[ $opt -eq 1 ] && exit

	bash $BGM/bgm_system.sh -seq
	sleep 0.5
	bash $BGM/bgm_system.sh -i
	generated

}

function generated(){
	infobox=
	infobox="${infobox}___________________________________________________________________________\n\n"
	infobox="${infobox}Both Players Sequence Generator\n\n"
	infobox="${infobox}Sequence list generated.\n\n"
	infobox="${infobox}___________________________________________________________________________\n\n"

	dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "Both Players Sequence Generator" --msgbox "${infobox}" 0 0
	
	exit
}

main_menu