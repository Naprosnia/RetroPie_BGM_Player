#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_generatem3u.sh
#Date			:	20190222	(YYYYMMDD)
#Description	:	BGM Player m3u generator for emulator player
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
	infobox="${infobox}VGM Playlist Generator\n\n"
	infobox="${infobox}In order to play VGM (emulated) musics (vgm, vgz, cmf, dro files),\n and every time you add new musics, you need to generate a playlist.\n\n"
	infobox="${infobox}This playlist is used by VGM player to identify your musics, and when\n you add new musics or remove, this playlist need to be updated.\n\n"
	infobox="${infobox}This playlist is updated automatically every time your system starts.\n\n"
	infobox="${infobox}Do you want to generate the VGM playlist?\n"
	infobox="${infobox}___________________________________________________________________________\n\n"

	dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "VGM Playlist Generator" --ok-label "Generate" --cancel-label "Back" --yesno "${infobox}" 0 0
	
	opt=$?
	[ $opt -eq 1 ] && exit

	bash $BGM/bgm_system.sh -m3u
	sleep 0.5
	bash $BGM/bgm_system.sh -i
	generated

}

function generated(){
	infobox=
	infobox="${infobox}___________________________________________________________________________\n\n"
	infobox="${infobox}VGM Playlist Generator\n\n"
	infobox="${infobox}Playlist generated.\n\n"
	infobox="${infobox}___________________________________________________________________________\n\n"

	dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "VGM Playlist Generator" --msgbox "${infobox}" 0 0
	
	exit
}

main_menu