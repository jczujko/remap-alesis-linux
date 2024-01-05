# remap-alesis-linux
A small shell script to help connect remapper to alsa sequencer. Needs to be ran every time drum kit is plugged to pc as subscription disconnects when drum kit is no longer detectable

# Requirements
- alsa-utils

  on Arch can be installed by
  
  ```
  pacman -S alsa-utils
  ```
  ***
- remapper

  I use [DMLITE_remapper](https://github.com/MaciekChudek/DMLITE_remapper) by [MaciekChudek](https://github.com/MaciekChudek)

# Setup
1. Compile remapper with ```gcc remapper.c -o remapper -lasound ```
2. We need to be able to run remapper from shell. Edit ```.bashrc``` and add ```export PATH=$PATH:/path/to/remapper```
3. Reload bash with ```. ~/.bashrc```
4. Download the script and give it execution permissions ```chmod u+x remapalesis.sh```
5. Run the script while drum kit is connected to pc and leave it runinng as long as you play
