# RetroPie_BGM_Player
A simple background music player to implement on RetroPie and Emulation Station based on [this](https://retropie.org.uk/forum/topic/9133/quick-and-easy-guide-for-adding-music-to-emulatonstation-on-retropie-noob-friendly) guide from RetroPie forum.

I made it simpler to install and created an options menu that can be launched from RetroPie menu, where you can change music volume, toggle music (on or off), enable/disable fading effect and enable/disable background music when playing.
Music stop/fade when you play any emulator, and play again when you leave it back to Emulation Station.

Hope you enjoy it.

## Installation
1. `wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/install.sh`
2. `chmod +x install.sh`
3. `bash install.sh`

## Usage
After the installation and the restart, music start playing when Emulation Station launches. During the installation, 6 musics are downloaded for you.
* ES setting `OTHER SETTINGS / PARSE GAMELISTS ONLY` should be `OFF`, otherwise you can not see `RetroPie-BGM-Player` options menu.
* To change settings, go to `RetroPie-BGM-Player` on RetroPie settings menu.
* Fade effect is disabled by default, go to `RetroPie-BGM-Player` settings menu to enable it.
* You don't like my music?! Easy for you, simply go to your roms folder, and inside you will find a new folder called "music", you can put there the musics you want. Attention, the audio files should be in .mp3 !

## Video
[![RetroPie BGM Player](https://img.youtube.com/vi/5G6uRU2iSRA/0.jpg)](https://www.youtube.com/watch?v=5G6uRU2iSRA)

## Uninstall
1. `wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/uninstall.sh`
2. `chmod +x uninstall.sh`
3. `bash uninstall.sh`

## Donate
You want to buy me a burger? Click the button below.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.me/naprosnia)
