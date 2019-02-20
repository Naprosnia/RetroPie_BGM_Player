#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Version		:	1.6
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	install.sh
#Date			:	20190219	(YYYYMMDD)
#Description	:	The installation script.
#Usage			:	wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/install.sh
#				:	chmod +x install.sh
#				:	bash install.sh
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

clear
echo -e "####################################"
echo -e "#  Installing RetroPie_BGM_Player  #"
echo -e "####################################\n"



RP="$HOME/RetroPie"
RPMENU="$RP/retropiemenu"
RPSETUP="$HOME/RetroPie-Setup"
RPCONFIGS="/opt/retropie/configs/all"
BGM="$HOME/RetroPie-BGM-Player"
BGMCONTROL="$BGM/bgm_control"
BGMMUSICS="$RP/roms/music"
BGMOLD="$RPCONFIGS/retropie_bgm_player"
SCRIPTPATH=$(realpath $0)
########################
##remove older version##
########################
echo -e "[Remove older version]"
rm -rf $BGMOLD
[ -e $RPMENU/Background\ Music\ Settings.sh ] && rm -f $RPMENU/Background\ Music\ Settings.sh
#use sudo because, owner can be root or file created incorrectly for any reason
sudo chmod 777 $RPCONFIGS/runcommand-onstart.sh $RPCONFIGS/runcommand-onend.sh $RPCONFIGS/autostart.sh >/dev/null 2>&1
sed -i "/retropie_bgm_player\/bgm_stop.sh/d" $RPCONFIGS/runcommand-onstart.sh >/dev/null 2>&1
sed -i "/retropie_bgm_player\/bgm_play.sh/d" $RPCONFIGS/runcommand-onend.sh >/dev/null 2>&1
sed -i "/retropie_bgm_player\/bgm_init.sh/d" $RPCONFIGS/autostart.sh >/dev/null 2>&1
########################
########################

########################
##mpg123 installation ##
########################
echo -e "[Music Player Installation]"

MUSICPLAYER="mpg123"

function check_install(){

	MUSICPLAYER_STATUS=$(dpkg-query -W --showformat='${Status}\n' $MUSICPLAYER  2> /dev/null|grep "install ok installed")
	
	if [ "" == "$MUSICPLAYER_STATUS" ]; then
		return 0
	else
		return 1
	fi
	
}

echo -e "-Checking player installation..."
sleep 1

if check_install; then

	echo -e "--Player not installed..."
	sleep 1
	echo -e "---Installing it now...\n"
	sleep 1
	sudo apt-get update; sudo apt-get install -y $MUSICPLAYER
	echo -e "\n----Checking installation result..."
	sleep 1
	
	if check_install; then
	
		echo -e "-----Player not installed correctly. Aborting script...\n\n"
		sleep 1
		rm -f $SCRIPTPATH >/dev/null 2>&1
		exit
		
	else
	
		echo -e "-----Player installed successfully, proceeding with the installation...\n"
		sleep 1
		
	fi	
	
else

	echo -e "--Player already installed, killing process if running...\n"
	killall $MUSICPLAYER >/dev/null 2>&1
	sleep 2
	
fi
########################
########################

########################
## Install BGM Player ##
########################

echo -e "[Installing RetroPie BGM Player]"
sleep 1
echo -e "-Creating folders..."
mkdir -p $BGMCONTROL
mkdir -p $BGMMUSICS
sleep 1
echo -e "--Downloading system files...\n"

function gitdownloader(){

	files=("$@")
	((last_id=${#files[@]} - 1))
	path=${files[last_id]}
	unset files[last_id]

	for i in "${files[@]}"; do
		wget -N -q --show-progress "https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master$path/$i"
		chmod a+rwx "$i"
	done
}

cd $BGM
BGMFILES=("bgm_system.sh" "bgm_control.sh" "bgm_settings.cfg" "version.sh")
gitdownloader ${BGMFILES[@]} "/RetroPie-BGM-Player"
cd $BGMCONTROL
BGMFILES=("bgm_setvolume.sh" "bgm_settoggle.sh" "bgm_setfade.sh" "bgm_setnonstop.sh" "bgm_setdelay.sh" "bgm_updater.sh")
gitdownloader ${BGMFILES[@]} "/RetroPie-BGM-Player/bgm_control"
cd $RPMENU
BGMFILES=("RetroPie-BGM-Player.sh")
gitdownloader ${BGMFILES[@]} "/RetroPie-BGM-Player"

echo -e "\n-Writing commands...\n"
sleep 1
cd $RPCONFIGS
echo -e "--Writing on runcommand commands..."
sleep 1
function runcommandsetup(){

	file=$1
	command=$2

	if [ ! -e $file ]; then
			echo -e "---$file not found, creating..."
			sleep 1
			touch $file
			sleep 0.5
			chmod a+rwx $file
			sleep 0.5
			echo "$command" > $file
		else
			echo -e "---$file found, writing..."
			sleep 1
			#use sudo because, owner can be root or file created incorrectly for any reason
			sudo chmod 777 $file
			sleep 0.5
			sed -i "/bgm_system.sh/d" $file
			[ -s $file ] && sed -i "1i $command" $file || echo "$command" > $file
	fi
}
runcommandsetup "runcommand-onstart.sh" "bash \$HOME/RetroPie-BGM-Player/bgm_system.sh -s"
runcommandsetup "runcommand-onend.sh" "bash \$HOME/RetroPie-BGM-Player/bgm_system.sh -p"
sleep 1
echo -e "--Writing on autostart script..."
sleep 1
#use sudo because, owner can be root or file created incorrectly for any reason
sudo chmod 777 autostart.sh
sed -i "/bgm_system.sh/d" autostart.sh
sed -i "1 i bash \$HOME/RetroPie-BGM-Player/bgm_system.sh -i --autostart" autostart.sh
sleep 1

echo -e "--Downloading some music files...\n"
cd $BGMMUSICS
musics=("1.mp3" "2.mp3" "3.mp3" "4.mp3" "5.mp3" "6.mp3" )
gitdownloader ${musics[@]} "/music"

echo -e "\n[Instalation finished.]\n"
sleep 1
########################
########################

##############################
## Remove Unnecessary Files ##
##############################
echo -e "\n[Removing unneeded files.]\n"
sleep 1
function delunneeded(){
	files=("$@")
	((last_id=${#files[@]} - 1))
	path=${files[last_id]}
	unset files[last_id]

	for file in "${files[@]}"; do
		if [ -e $path/$file ]; then
			echo -e "-Removing $file...\n"
			rm -rf $path/$file
		fi
	done
}
unneedfiles=("bgm_setingame.sh")
delunneeded ${unneedfiles[@]} "$BGMCONTROL"
########################
########################

########################
##       Restart      ##
########################
if [ "$1" == "--update" ]; then
	(rm -f $SCRIPTPATH; bash $BGMCONTROL/bgm_updater.sh --reboot)
else
	echo -e "[Restart System]"
	echo -e "-To finish, we need to reboot.\n"
	read -n 1 -s -r -p "Press any key to Restart."
	echo -e "\n"
	(rm -f $SCRIPTPATH; sudo reboot)
fi

########################
########################