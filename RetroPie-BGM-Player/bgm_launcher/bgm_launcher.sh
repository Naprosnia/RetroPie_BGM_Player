#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_launcher.sh
#Date			:	20190224	(YYYYMMDD)
#Description	:	This script launches adequate player and manages it.
#Usage			:	It should be called from bgm_system.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

[[ "$(pgrep -c -f $(basename $0))" -gt 1 ]] && exit

BGM="$HOME/RetroPie-BGM-Player"
BGMSETTINGS="$BGM/bgm_settings.ini"
BGMLAUNCHER="$BGM/bgm_launcher"
BGMBOTH="$BGMLAUNCHER/both"
BGMVGMPLAYER="$BGMLAUNCHER/vgmplayer"
BGMMP3PLAYER="$BGMLAUNCHER/mp3player"

source $BGMSETTINGS >/dev/null 2>&1

while true; do ./$BGMLAUNCHER/$bgm_player/$bgm_player >/dev/null 2>&1; done
