#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Script Name	:	install.sh
#Version		:	1.1
#Date			:	20190205	(YYYYMMDD)
#Description	:	This script installs  RetroPie_BGM_Player,
#				:	that adds support for background music on
#				:	EmulationStation, using RetroPie.
#Usage			:	sudo bash install.sh
#Author       	:	Luís Torres aka Naprosnia
#Git         	:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################

clear
echo -e "####################################"
echo -e "#  Installing RetroPie_BGM_Player  #"
echo -e "####################################\n"

installscript="$0"
function finish {
	$(sudo killall emulationstation >/dev/null 2>&1 ; sleep 2; sudo -u pi emulationstation)&
    sudo shred -u ${installscript} >/dev/null 2>&1
	clear
}

##check mpg123 player installation
player=mpg123
player_status=$(dpkg-query -W --showformat='${Status}\n' $player  2> /dev/null|grep "install ok installed")

function check_install(){
	if [ "" == "$player_status" ]; then
		return 0
	else
		return 1
	fi
}

echo -e "[Checking player installation...]"
sleep 2

if check_install; then
	echo -e "-Player not installed..."
	sleep 2
	echo -e "--Installing it now...\n"
	sleep 2
	sudo apt-get update; sudo apt-get install -y $player
	echo -e "\n---Checking installation result..."
	sleep 2
	
	if check_install; then
		echo -e "----Player not installed correctly. Aborting script...\n\n"
		sleep 3
		exit
	fi
	
	echo -e "----Player installed successfully, proceeding with the installation...\n"
	sleep 2
	
else
	echo -e "-Player already installed, proceeding with the installation...\n"
	sleep 2
	
fi

##create retropie_bgm_player directory and copying files
echo -e "[Preparing scripts...]"
sleep 2
echo -e "-Creating folders..."
sudo mkdir -p -m 777 /opt/retropie/configs/all/retropie_bgm_player
sleep 2
echo -e "-Downloading files...\n"
sudo wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/retropie_bgm_player/Background%20Music%20Settings.sh -P /home/pi/RetroPie/retropiemenu/
sudo wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/retropie_bgm_player/bgm_init.sh -P /opt/retropie/configs/all/retropie_bgm_player/
sudo wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/retropie_bgm_player/bgm_play.sh -P /opt/retropie/configs/all/retropie_bgm_player/
sudo wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/retropie_bgm_player/bgm_stop.sh -P /opt/retropie/configs/all/retropie_bgm_player/
sudo wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/retropie_bgm_player/bgmvolume.sh -P /opt/retropie/configs/all/retropie_bgm_player/
sudo wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/retropie_bgm_player/togglebgm.sh -P /opt/retropie/configs/all/retropie_bgm_player/
echo -e "\n-Setting permissions...\n"
sleep 2
sudo chmod 777 /home/pi/RetroPie/retropiemenu/Background\ Music\ Settings.sh
sudo chmod 777 /opt/retropie/configs/all/retropie_bgm_player/*.*

##installing
echo -e "[Installing RetroPie_BGM_Player...]"
sleep 2
#checking runcommand scripts
echo -e "-Setting up runcommand scripts..."
sleep 2

if [ ! -e "/opt/retropie/configs/all/runcommand-onstart.sh" ]; then
	echo -e "-- runcommand-onstart.sh not found, installing..."
	sudo echo "bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_stop.sh'" > /opt/retropie/configs/all/runcommand-onstart.sh
	sudo chmod 777 /opt/retropie/configs/all/runcommand-onstart.sh
else
	echo -e "-- runcommand-onstart.sh found, installing..."
	sudo chmod 777 /opt/retropie/configs/all/runcommand-onstart.sh
	if [ -s /opt/retropie/configs/all/runcommand-onstart.sh ]; then
		sudo sed -i "1 i bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_stop.sh'" /opt/retropie/configs/all/runcommand-onstart.sh
	else
		sudo echo "bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_stop.sh'" > /opt/retropie/configs/all/runcommand-onstart.sh
	fi
fi

if [ ! -e "/opt/retropie/configs/all/runcommand-onend.sh" ]; then
	echo -e "-- runcommand-onend.sh not found, installing..."
	sudo echo "bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_play.sh'" > /opt/retropie/configs/all/runcommand-onend.sh
	sudo chmod 777 /opt/retropie/configs/all/runcommand-onend.sh
else
	echo -e "-- runcommand-onend.sh found, installing..."
	sudo chmod 777 /opt/retropie/configs/all/runcommand-onend.sh
	if [ -s /opt/retropie/configs/all/runcommand-onend.sh ]; then
		sudo sed -i "1 i bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_play.sh'" /opt/retropie/configs/all/runcommand-onend.sh
	else
		sudo echo "bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_play.sh'" > /opt/retropie/configs/all/runcommand-onend.sh
	fi
fi

#prepare start script on autostart.sh
echo -e "-Setting up autostart script..."
sleep 2
sudo chmod 777 /opt/retropie/configs/all/autostart.sh
sudo sed -i "1 i bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_init.sh'" /opt/retropie/configs/all/autostart.sh

#prepare music folder
echo -e "-Setting up music folder..."
sleep 2
sudo mkdir -p -m 777 /home/pi/RetroPie/roms/music
echo -e "--Downloading some music files...\n"
sudo wget -N https://github.com/Naprosnia/RetroPie_BGM_Player/raw/master/music/1.mp3 -P /home/pi/RetroPie/roms/music/
sudo wget -N https://github.com/Naprosnia/RetroPie_BGM_Player/raw/master/music/2.mp3 -P /home/pi/RetroPie/roms/music/
sudo wget -N https://github.com/Naprosnia/RetroPie_BGM_Player/raw/master/music/3.mp3 -P /home/pi/RetroPie/roms/music/
sudo wget -N https://github.com/Naprosnia/RetroPie_BGM_Player/raw/master/music/4.mp3 -P /home/pi/RetroPie/roms/music/
sudo wget -N https://github.com/Naprosnia/RetroPie_BGM_Player/raw/master/music/5.mp3 -P /home/pi/RetroPie/roms/music/
sudo wget -N https://github.com/Naprosnia/RetroPie_BGM_Player/raw/master/music/6.mp3 -P /home/pi/RetroPie/roms/music/
sudo chmod 777 /home/pi/RetroPie/roms/music/*.*
echo -e "\n"

echo -e "[Instalation finished.]\n"
sleep 2

#start background player
echo -e "[Starting RetroPie_BGM_Player...]\n"
sudo pkill mpg123
bash '/opt/retropie/configs/all/retropie_bgm_player/bgm_init.sh'

#show some info
echo -e "[INFO]"
echo -e "You can now change background music volume and enbale/disable it from RetroPie menu."
echo -e "You will find there an option called Background Music Settings. All changes are saved.\n"
echo -e "To add new music or delete the installed ones, use the folder music installed on roms folder. ( /roms/music/ )."
echo -e "The player only reads mp3 files.\n"

#restart ES
echo -e "[Restart EmulationStation]"
echo -e "-To finish, we need to restart EmulationStation.\n"
read -n 1 -s -r -p "Press any key to Restart."
trap finish EXIT