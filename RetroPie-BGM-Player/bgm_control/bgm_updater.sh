#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_udater
#Date			:	20190218	(YYYYMMDD)
#Description	:	BGM Player updater
#Usage			:	Should be called from bgm_control.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

RP="$HOME/RetroPie"
RPMENU="$RP/retropiemenu"
RPSETUP="$HOME/RetroPie-Setup"
RPCONFIGS="/opt/retropie/configs/all"
BGM="$HOME/RetroPie-BGM-Player"
BGMCONTROL="$BGM/bgm_control"
BGMMUSICS="$RP/roms/music"
BGMOLD="$RPCONFIGS/retropie_bgm_player"
VERSION="$BGM/version.sh"
GITVERSION="https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/RetroPie-BGM-Player/version.sh"

source $VERSION >/dev/null 2>&1
bgm_curversion=$bgm_version
bgm_curdate=$bgm_date


infobox=
infobox="${infobox}___________________________________________________________________________\n\n"
infobox="${infobox}RetroPie BGM Player Updater\n\n"
infobox="${infobox}BGM Player updater, check for new versions and install it automatically.\n"
infobox="${infobox}___________________________________________________________________________\n\n"

dialog --backtitle "RetroPie BGM Player" --title "BGM Updater Description" --msgbox "${infobox}" 0 0


function main_menu() {
    local choice

    while true; do
	
		source $BGMSETTINGS >/dev/null 2>&1
		
        choice=$(dialog --backtitle "RetroPie BGM Player" --title "BGM Updater" \
            --ok-label "Select" --cancel-label "Back" --no-tags \
            --menu "Current version: $bgm_version from: $bgm_date" 25 75 20 \
            1 "1 Check for updates." \
            2>&1 > /dev/tty)
			
			opt=$?
			[ $opt -eq 1 ] && exit
			
			dlversion
			
    done
}

function dlversion(){
	clear
	echo -e "[Checking for updates...]"
	cd $HOME
	if wget -N -q --show-progress $GITVERSION; then
		chmod a+rwx $HOME/version.sh
		source $HOME/version.sh >/dev/null 2>&1
		bgm_newversion=$bgm_version
		bgm_newdate=$bgm_date
		rm -rf $HOME/version.sh
		versioncompare $bgm_curversion $bgm_newversion
		[ $? -eq 2 ]  && update || uptodate
	else
		errorcheck
	fi
}

function versioncompare() {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
	
	# return 0 - x=y  | 1 - x>y | 2 - x<y
}

function uptodate(){
	infobox=
	infobox="${infobox}___________________________________________________________________________\n\n"
	infobox="${infobox}RetroPie BGM Player Updater\n\n"
	infobox="${infobox}Your version: $bgm_curversion from $bgm_curdate is up-to-date.\n"
	infobox="${infobox}___________________________________________________________________________\n\n"

	dialog --backtitle "RetroPie BGM Player" --title "BGM Updater Up-To-Date" --msgbox "${infobox}" 0 0
	exit
}
function errorcheck(){
	infobox=
	infobox="${infobox}___________________________________________________________________________\n\n"
	infobox="${infobox}RetroPie BGM Player Updater\n\n"
	infobox="${infobox}It was not possible to check the version available online.\n"
	infobox="${infobox}___________________________________________________________________________\n\n"

	dialog --backtitle "RetroPie BGM Player" --title "BGM Updater Error" --msgbox "${infobox}" 0 0
	exit
}
function update(){
	infobox=
	infobox="${infobox}___________________________________________________________________________\n\n"
	infobox="${infobox}RetroPie BGM Player Updater\n\n"
	infobox="${infobox}New version avaliable!"
	infobox="${infobox}Version: $bgm_curversion -> $bgm_newversion\n"
	infobox="${infobox}___________________________________________________________________________\n\n"

	dialog --backtitle "RetroPie BGM Player" --title "BGM Updater New Version" --msgbox "${infobox}" --yesno 0 0
	exit
}
main_menu

