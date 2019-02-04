#!/usr/bin/env bash

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Set Background Music Volume " \
            --ok-label OK --cancel-label Back \
            --menu "You can choose the volume level one after another until you are happy with your settings." 25 75 20 \
            1 "Set Background Music volume to 100%" \
            2 "Set Background Music volume to 90%" \
            3 "Set Background Music volume to 80%" \
            4 "Set Background Music volume to 70%" \
            5 "Set Background Music volume to 60%" \
            6 "Set Background Music volume to 50%" \
            7 "Set Background Music volume to 40%" \
            8 "Set Background Music volume to 30%" \
            9 "Set Background Music volume to 20%" \
            10 "Set Background Music volume to 10%" \
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
	#reiniciar player
	setsid mpg123 -f $bgmvolume -Z ~/RetroPie/roms/music/*.mp3 >/dev/null 2>&1 &
	#check do toggle
	if [ -e /home/pi/.bgmstop ]; then
		sudo pkill -STOP mpg123
	fi

}

function 100_v() {
		#remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=32768">/home/pi/.bgmvolume
		bgmvolume=32768
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 90_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=29491">/home/pi/.bgmvolume
		bgmvolume=29491
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 80_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=29491">/home/pi/.bgmvolume
		bgmvolume=29491
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 70_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=22938">/home/pi/.bgmvolume
		bgmvolume=22938
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 60_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=19661">/home/pi/.bgmvolume
		bgmvolume=19661
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 50_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=16384">/home/pi/.bgmvolume
		bgmvolume=16384
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 40_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=13107">/home/pi/.bgmvolume
		bgmvolume=13107
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 30_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=9830">/home/pi/.bgmvolume
		bgmvolume=9830
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 20_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=6554">/home/pi/.bgmvolume
		bgmvolume=6554
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}
function 10_v() {
        #remover o ficheiro antigo
        rm /home/pi/.bgmvolume >/dev/null 2>&1
		#criar novo ficheiro
		echo "bgmvolume=3277">/home/pi/.bgmvolume
		bgmvolume=3277
		#matar o player antigo
		sudo pkill mpg123
		#reiniciar com novo volume
		restart_player
}


main_menu

