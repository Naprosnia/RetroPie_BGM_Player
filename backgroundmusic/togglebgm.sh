
#!/usr/bin/env bash
#verificar estado e preparar msg
if [ -e /home/pi/.bgmstop ]; then
	menutitulo="Off"
	selecttext="On"
else
	menutitulo="On"
	selecttext="Off"
fi

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Toggle Background Music " \
            --ok-label OK --cancel-label Back \
            --menu "You have Background Music set to $menutitulo" 25 75 20 \
            1 "Turn Background Music $selecttext" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) applychanges  ;;
            *)  break ;;
        esac
    done
}

function applychanges(){
	stop_bgm()
	{
		sudo touch /home/pi/.bgmstop
		sudo pkill -STOP mpg123
	}

	start_bgm()
	{
		sudo rm /home/pi/.bgmstop
		sudo pkill -CONT mpg123
	}

	if [ -e /home/pi/.bgmstop ]; then
			start_bgm
			bash /opt/retropie/configs/all/backgroundmusic/togglebgm.sh
			exit
	else
			stop_bgm
			bash /opt/retropie/configs/all/backgroundmusic/togglebgm.sh
			exit
	fi
}

main_menu