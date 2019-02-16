# RetroPie_BGM_Player
A simple background music player to implement on RetroPie and Emulation Station based on [this](https://retropie.org.uk/forum/topic/9133/quick-and-easy-guide-for-adding-music-to-emulatonstation-on-retropie-noob-friendly) guide from RetroPie forum.

I made it simpler to install and created an options menu that can be launched from RetroPie menu, where you can change music volume and toggle music (on or off).
Music stop when you play any emulator, and play again when you leave it back to Emulation Station.

Hope you enjoy it.

## Installation
1. `wget -N https://raw.githubusercontent.com/Naprosnia/RetroPie_BGM_Player/master/install.sh`
2. `chmod +x install.sh`
3. `bash install.sh`

## Usage
After the installation and the restart, music start playing when Emulation Station launches. During the installation, 6 musics are downloaded for you.
* ES settings `OTHER SETTINGS / PARSE GAMELISTS ONLY` should be `OFF`, otherwise you cant see options menu.
* To change settings, go to `RetroPie-BGM-Player` on RetroPie settings menu.
* Fade effect is disabled by default, to to settings menu to enable it.
* You don't like my music?! Easy for you, simply go to your roms folder, and inside you will find a new folder called "music", you can put there the musics you want. Attention, the audio files should be in .mp3 !

## Video
[![RetroPie BGM Player](https://img.youtube.com/vi/HFwzHAtcWNU/0.jpg)](https://www.youtube.com/watch?v=HFwzHAtcWNU)

## Donate
You want to buy me a burger? Click the button below.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.me/naprosnia)
