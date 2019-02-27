#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_setplayercustom.sh
#Date			:	20190227	(YYYYMMDD)
#Description	:	BGM Player select player custom file types
#Usage			:	Should be called from bgm_control.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

BGM="$HOME/RetroPie-BGM-Player"
BGMSETTINGS="$BGM/bgm_settings.ini"
VERSION="$BGM/version.sh"
source $VERSION >/dev/null 2>&1
filetypes=("mp3" "ay" "gbs" "gym" "hes" "kss" "nsf" "nsfe" "sap" "spc" "vgm" "vgz" "vtx" "2sf" "psf" "psf2")
bgm_customplayer=

function main_menu() {
    local choice

    while true; do
	
		source $BGMSETTINGS >/dev/null 2>&1
		
		for filetype in "${filetypes[@]}"; do
			checkarray ${bgm_customplayer[@]} $filetype && declare $filetype="X" ||  declare $filetype=" "
		done
        choice=$(dialog --backtitle "RetroPie BGM Player v.$bgm_version" --title "Custom File Type Player" \
            --ok-label "Select" --cancel-label "Back" --no-tags \
            --menu "Select your Player" 25 75 20 \
            "mp3" " [$mp3] MP3" \
			"ay" " [$ay] Spectrum ZX (.ay)" \
			"gbs" " [$gbs] GameBoy (.gbs)" \
			"gym" " [$gym] Sega Genesis (.gym)" \
			"hes" " [$hes] NEC PC Engine / TurboGrafx-16 (.hes)" \
			"kss" " [$kss] MSX / Other Z80 (.kss)" \
			"nsf" " [$nsf] NES (.nsf)" \
			"nsfe" " [$nsfe] NES Extended Support (.nsfe)" \
			"sap" " [$sap] Atari SAP (.sap)" \
			"spc" " [$spc] SNES (.spc)" \
			"vgm" " [$vgm] Sega VGM (.vgm)" \
			"vgz" " [$vgz] Sega VGZ (.vgz)" \
			"vtx" " [$vtx]  Vortex (.vtx)" \
			"2sf" " [$2sf] Nintendo DS (.2sf)" \
			"psf" " [$psf] Playstation Audio (.psf)" \
			"psf2" " [$psf2] Playstation Audio (.psf2)" \
            2>&1 > /dev/tty)

        opt=$?
		if [ $opt -eq 1 ]; then
			if [ ${#bgm_customplayer[@]} -gt 0 ]; then
				bash $BGM/bgm_system.sh -reloadc
				bash $BGM/bgm_system.sh -setsetting bgm_player custom
				sleep 0.5
				bash $BGM/bgm_system.sh -i
			fi
			exit
		fi
		
		managearray $choice
		
    done
}

function checkarray(){ 	
	array=("$@")
	((last_id=${#array[@]} - 1))
	search=${array[last_id]}
	unset array[last_id]
	local in=1
	for element in "${array[@]}"; do
		if [ $element == $search ]; then
			in=0
			break
		fi
	done
	return $in

}

function managearray(){
	type=$1
	if [ "${!type}" == "X" ]; then
		sed -i "/bgm_customplayer+=(\"$type\")/d" $BGMSETTINGS
	else
		echo "bgm_customplayer+=(\"$type\")" >> $BGMSETTINGS
	fi
}

main_menu