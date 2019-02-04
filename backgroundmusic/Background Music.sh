#!/usr/bin/env bash

infobox= ""
infobox="${infobox}___________________________________________________________________________\n\n"
infobox="${infobox}Background Music Settings\n"
infobox="${infobox}\n"
infobox="${infobox}Here you can set background music settings.\n"
infobox="${infobox}You can turn it on/off or change the volume.\n"
infobox="${infobox}\n"
infobox="${infobox}\n"
infobox="${infobox}\n"
infobox="${infobox}\n"
infobox="${infobox}\n\n"
infobox="${infobox}\n\n"
infobox="${infobox}\n\n"
infobox="${infobox}                                                            by Luis Torres\n"
infobox="${infobox}___________________________________________________________________________\n\n"

dialog --backtitle "Background Music Settings" \
--title "Background Music Settings" \
--msgbox "${infobox}" 23 80

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What you want to set?" 25 75 20 \
            1 "Turn Background Music On/Off" \
            2 "Set Background Music Volume" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) toggle_menu  ;;
            2) vol_menu  ;;
            *)  break ;;
        esac
    done
}

function toggle_menu(){
	bash /opt/retropie/configs/all/backgroundmusic/togglebgm.sh
}

function vol_menu(){
	bash /opt/retropie/configs/all/backgroundmusic/bgmvolume.sh
}

main_menu

