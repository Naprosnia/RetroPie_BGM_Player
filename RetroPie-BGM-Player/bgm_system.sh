#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_system.sh
#Date			:	20190218	(YYYYMMDD)
#Description	:	This script contain all functions needed by BGM.
#Usage			:	It should be called from other scripts using arguments.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

# Avoid multiple starts, so force close
[[ "$(pgrep -c -f $(basename $0))" -gt 1 ]] && exit

# read arguments and execute functions
function execute() {
	if [ "$#" -gt 0 ]; then

		case "$1" in
			-i)
				(bgm_init "$2") &
				;;
			-p)
				bgm_play
				;;
			-s)
				bgm_stop
				;;
			-setsetting)
				bgm_setsetting "$2" "$3"
				;;
			-m3u)
				generatem3u
				;;
			-r)
				bgm_restart
				;;
			-k)
				bgm_kill
				;;
			*)
				exit
				;;
		esac
	else
		exit
	fi
}

# shorten paths
RP="$HOME/RetroPie"
RPMENU="$RP/retropiemenu"
RPSETUP="$HOME/RetroPie-Setup"
RPCONFIGS="/opt/retropie/configs/all"
BGM="$HOME/RetroPie-BGM-Player"
BGMCONTROL="$BGM/bgm_control"
BGMSETTINGS="$BGM/bgm_settings.cfg"
BGMMUSICS="$RP/roms/music"
VGMPLAY="$BGM/VGMPlay"
VGMPLAYSETTINGS="$VGMPLAY/VGMPlay.ini"

# settings area
source $BGMSETTINGS >/dev/null 2>&1
# end of settings area

# ALSA related vars
readonly CHANNEL="PCM"
readonly MUSICPLAYER=$bgm_player
# get current volume
CHANNELVOLUME=$(amixer -M get $CHANNEL | grep -o "...%]")
CHANNELVOLUME=${CHANNELVOLUME//[^[:alnum:].]/}
# volume commands
VOLUMEZERO="amixer -q -M set $CHANNEL 0%"
VOLUMERESET="amixer -q -M set $CHANNEL $CHANNELVOLUME%"
FADEVOLUME=
VOLUMESTEP=

#convert volume depending on active player
case "$MUSICPLAYER" in
	mpg123)
		bgm_volume=$(( 32768*$bgm_volume/100 ))
		;;
	vgmplay)
		bgm_volume=$(perl -E "say $bgm_volume/100")
		[ "$bgm_volume" == "1" ] && bgm_volume="1.0"
		;;
esac


function bgm_init(){

	# if script called from autostart.sh, wait for omxplayer (splashscreen) to end
	if [ "$1" == "--autostart" ]; then
		while pgrep omxplayer >/dev/null; do sleep 1; done
		[ "$bgm_player" == "vgmplay" ] && generatem3u
		sleep $bgm_delay
	fi
	
	(pgrep -x $MUSICPLAYER > /dev/null) && bgm_kill
	
	# start player (always)
	start_player
	
	# check bgm_toggle, if 1 = play, else = stop
	if [ "$bgm_toggle" -eq "1" ]; then
	
		# check bgm_fade, if 1 apply fade, else leave it
		if [ "$bgm_fade" -eq "1" ]; then
			vol_fade_in
		fi
		
	else
	
		pkill -STOP $MUSICPLAYER
		
	fi
	
}

function start_player(){
	case "$MUSICPLAYER" in
		mpg123)
			setsid $MUSICPLAYER -f $bgm_volume -Z $BGMMUSICS/*.mp3 >/dev/null 2>&1 &
			;;
		vgmplay)
			#m3u playlist generated automatically inside -autostart bgm_init
			setsid $VGMPLAY/$MUSICPLAYER  $VGMPLAY/playlist.m3u >/dev/null 2>&1 &
			;;
		*)
			exit
			;;
	esac
}

function generatem3u(){

	types=("vgm" "vgz" "cmf" "dro")

	for type in "${types[@]}"; do
		find $BGMMUSICS -type f -iname "*.$type" >> $VGMPLAY/templist.m3u
	done
	cat $VGMPLAY/templist.m3u | shuf > $VGMPLAY/shuftemplist.m3u
	for run in {1..10}; do cat $VGMPLAY/shuftemplist.m3u; done > $VGMPLAY/playlist.m3u
	chmod -R a+rwx $VGMPLAY/*.m3u >/dev/null 2>&1
	rm -f $VGMPLAY/templist.m3u >/dev/null 2>&1
	rm -f $VGMPLAY/shuftemplist.m3u >/dev/null 2>&1

}

function bgm_play(){

	# check bgm_toggle, if 1 = play, else = null
	if [ "$bgm_toggle" -eq "1" ]; then
		# check bgm_nonstop, if 0 = stop, else = null
		if [ "$bgm_nonstop" -eq "0" ]; then
			# check bgm_fade, if 1 apply fade, else leave it
			if [ "$bgm_fade" -eq "1" ]; then
				vol_fade_in
			else
				pkill -CONT $MUSICPLAYER
			fi
		fi
	fi
	
}

function bgm_stop(){

	# check bgm_toggle, if 1 = stop, else = null
	if [ "$bgm_toggle" -eq "1" ]; then
		# check bgm_nonstop, if 0 = stop, else = null
		if [ "$bgm_nonstop" -eq "0" ]; then
			# check bgm_fade, if 1 apply fade, else leave it
			if [ "$bgm_fade" -eq "1" ]; then
				vol_fade_out
			else
				pkill -STOP $MUSICPLAYER
			fi
		fi
		
	fi
	
}

# fade related functions
function fade_set_step() {

	# reduce volume by steps | 100 -> 0 = slow -> fast
	case $FADEVOLUME in
		[1-4][0-9]|50) VOLUMESTEP=8 ;;
		[5-7][0-9]|80) VOLUMESTEP=5 ;;
		[8-9][0-9]|100) VOLUMESTEP=3 ;;
		*) VOLUMESTEP=5 ;;
	esac
	
}

function vol_fade_in(){

    $VOLUMEZERO
    sleep 0.2
    pkill -CONT $MUSICPLAYER
    FADEVOLUME=10
    until [[ $FADEVOLUME -ge $CHANNELVOLUME ]]; do
        fade_set_step
        FADEVOLUME=$(($FADEVOLUME+$VOLUMESTEP))
        amixer -q -M set "$CHANNEL" "${VOLUMESTEP}%+"
        sleep 0.2
    done
    $VOLUMERESET
}

function vol_fade_out(){
	FADEVOLUME=$CHANNELVOLUME
	until [[ $FADEVOLUME -le 10 ]]; do
        fade_set_step
        FADEVOLUME=$(($FADEVOLUME-$VOLUMESTEP))
        amixer -q -M set "$CHANNEL" "${VOLUMESTEP}%-"
        sleep 0.2
    done
    $VOLUMEZERO
    pkill -STOP $MUSICPLAYER
    sleep 0.2
    $VOLUMERESET
}
# end of fade related functions

# option menu related functions
function bgm_setsetting(){
	sed -i "s/^$1.*/$1=$2/g" $BGMSETTINGS
	if [ "$1" == "bgm_volume" ]; then
		vgm_volume=$(perl -E "say $2/100")
		[ "$vgm_volume" == "1" ] && vgm_volume="1.0"
		bgm_setvgmsetting "Volume" "$vgm_volume"
	fi

}

function bgm_setvgmsetting(){
	sed -i "s/^$1.*/$1 = $2/g" $VGMPLAYSETTINGS
}
# end of option menu related functions

function bgm_kill(){

	killall $MUSICPLAYER >/dev/null 2>&1

}

function bgm_restart(){
	
	bgm_kill
	sleep 0.2
	bgm_init
}

execute "$@"