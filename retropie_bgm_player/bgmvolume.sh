#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Script Name	:	bgmvolume.sh
#Version		:	1.0
#Date			:	20190205	(YYYYMMDD)
#Description	:	This script produce a menu to set the volume of
#				:	RetroPie_BGM_Player.
#Usage			:	It should be called from other scripts only.
#Author       	:	Luís Torres aka Naprosnia
#Git         	:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Set Background Music Volume " \
            --ok-label OK --cancel-label Back \
            --menu "Choose the volume." 25 75 20 \
            1 "Volume 100%" \
            2 "Volume 90%" \
            3 "Volume 80%" \
            4 "Volume 70%" \
            5 "Volume 60%" \
            6 "Volume 50%" \
            7 "Volume 40%" \
            8 "Volume 30%" \
            9 "Volume 20%" \
            10 "Volume 10%" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) 100_v  ;;
            2) 90_v  ;;
            3) 80_v  ;;
            4) 70_v  ;;
            5) 60_v  ;;
            6) 50_v  ;;
            7) 40_v  ;;
            8) 30_v  ;;
            9) 20_v  ;;
            10) 10_v  ;;
            *)  break ;;
        esac
    done
}

function restart_player(){
	setsid mpg123 -f $bgmvolume -Z ~/RetroPie/roms/music/*.mp3 >/dev/null 2>&1 &
	if [ -e /home/pi/.bgmstop ]; then
		sudo pkill -STOP mpg123
	fi

}

function 100_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=32768">/home/pi/.bgmvolume
		bgmvolume=32768
		sudo pkill mpg123
		restart_player
}
function 90_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=29491">/home/pi/.bgmvolume
		bgmvolume=29491
		sudo pkill mpg123
		restart_player
}
function 80_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=29491">/home/pi/.bgmvolume
		bgmvolume=29491
		sudo pkill mpg123
		restart_player
}
function 70_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=22938">/home/pi/.bgmvolume
		bgmvolume=22938
		sudo pkill mpg123
		restart_player
}
function 60_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=19661">/home/pi/.bgmvolume
		bgmvolume=19661
		sudo pkill mpg123
		restart_player
}
function 50_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=16384">/home/pi/.bgmvolume
		bgmvolume=16384
		sudo pkill mpg123
		restart_player
}
function 40_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=13107">/home/pi/.bgmvolume
		bgmvolume=13107
		sudo pkill mpg123
		restart_player
}
function 30_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=9830">/home/pi/.bgmvolume
		bgmvolume=9830
		sudo pkill mpg123
		restart_player
}
function 20_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=6554">/home/pi/.bgmvolume
		bgmvolume=6554
		sudo pkill mpg123
		restart_player
}
function 10_v() {
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		echo "bgmvolume=3277">/home/pi/.bgmvolume
		bgmvolume=3277
		sudo pkill mpg123
		restart_player
}


main_menu

