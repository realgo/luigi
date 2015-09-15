#!/bin/bash

set -e

prod=false
while getopts "p" opt; do
    case $opt in
        p)
            prod=true
            ;;
    esac
done

color() {
      printf '\033[%sm%s\033[m\n' "$@"
      # usage color "31;5" "string"
      # 0 default
      # 5 blink, 1 strong, 4 underlined
      # fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
      # bg: 40 black, 41 red, 44 blue, 45 purple
      }

color '36;1' "
    
 ______              _ _______       
(_____ \            | (_______)      
 _____) )_____ _____| |_   ___  ___  
|  __  /| ___ (____ | | | (_  |/ _ \ 
| |  \ \| ____/ ___ | | |___) | |_| |
|_|   |_|_____)_____|\_)_____/ \___/ 
                                     

                               
     This script installs dependencies for the realgo luigi project

     For more details, visit:
     https://www.github.com/realgo/luigi
"

if ! [ -e ./setup.py ] || ! [ -e ./setup.sh ] ; then
    color '31;1' "Error: setup.sh should be run from the sync-engine repo" >&2
    exit 1
fi

color '35;1' 'Updating packages...'


color '35;1' 'Installing dependencies from apt-get...'
apt-get -y install git \
                   wget \
                   supervisor \
                   python \
                   python-dev \
                   python-pip \
                   python-setuptools \
                   build-essential \
                   gcc \
                   g++ \
                   pkg-config \
                   python-lxml \
                   tmux \
                   curl \
                   tnef \
                   stow \
                   debhelper\
                   dh-virtualenv\



# Set proper timezone
echo 'UTC' | sudo tee /etc/timezone


pip install make-deb

#copy files to temp folder to get around vagrent symlink bug on windows
mkdir /tmp/luigibuild
cp -r /luigi /tmp/luigibuild/luigi

#build the deb, 
cd /tmp/luigibuild/luigi
sudo dpkg-buildpackage -us -uc

#copy the output back to the shared folder
cp /tmp/luigibuild/*.deb  /luigi



color '35;1' 'Done!.'


color '36;1' "
    
      ______              _ _______       
     (_____ \            | (_______)      
      _____) )_____ _____| |_   ___  ___  
     |  __  /| ___ (____ | | | (_  |/ _ \ 
     | |  \ \| ____/ ___ | | |___) | |_| |
     |_|   |_|_____)_____|\_)_____/ \___/ 
                                          
Keeping the Colorado Real Estate Industry Surfing Since 1998
"
