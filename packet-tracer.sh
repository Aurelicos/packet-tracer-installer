#!/bin/bash

help()
{
   # Function For Display Help
   echo
   echo "Welcome to packet tracer installer!" | lolcat
   echo
   echo 
   echo "This script is for easy and fast packet tracer installation."
   echo
   echo "Syntax: bash packet-tracer.sh [-h|d|o]"
   echo "options:"
   echo "-h     Print this Help."
   echo "-d     Install default version of packet tracer (version 8.1.1)."
   echo "-o     Install older version (7.2.2)."
   echo
   echo "To install custom version please download .deb file"
   echo
}

default()
{
   # Function for install default version of packet tracer (v. 8.1.1)
   echo
   echo "For packet tracer install please log in to your account."
   firefox https://id.cisco.com/login/login.htm?fromURI=%2Fapp%2Fciscoid_netacadhttpcanvasauthnetacadcom_1%2Fexkl91gjeATNZmgN95d6%2Fsso%2Fsaml%3FSAMLRequest%3DfVJbb9sgFP4rFu8Otus5DUoiZY2mReqyqPH60BeLwnHChoFxcNP9%252B2G709qXPCHO%252BS7ntkTeacc2fTibB%252FjdA4bktdMG2ZhYkd4bZjkqZIZ3gCwIdtx8u2fFLGPO22CF1eQd5TqDI4IPyhqS7LYr0uTZYs6zai5y4Iu2rGQrqzyTZdsKuK0KURbtc1lKKSqSPILHyFyRKBTpiD3sDAZuQgxlRZFmN2kxr%252FOCFTcsu30iyTZ2owwPI%252BscgkNGqZIzoVDYmbAd5c7R8adkYyBwweWAE9y8cOTDUKZgxDY5hddfepGffsKm3j91p%252F3ik6wooqVD4yTZ%252FGvuzhrsO%252FBH8C9KwI%252BH%252B%252F%252F2l8tl9iY6VuCsD1xTVJ3TMOjQzspew8yd3ahLcXqLlAscoyejUnRpa31qDShJksPbIj4rI5U5Xd%252FB8wRC9rWuD%252Bnh%252B7Em6%252BXgwMaZ%252BnXUb9A1Ub8Z9Zf0fXY5Xcw%252B6u62B6uV%252BJN8sb7j4brtEFFyqDpCWfDcoAIT4ti0tpc7DzzAigTfA6HryfLjXa7%252FAg%253D%253D%26RelayState%3Dhttps%253A%252F%252Fwww.netacad.com%252Fportal%252Fsaml_login%253FReturnTo%253Dhttps%253A%252F%252Fwww.netacad.com%252Fportal%252Fresources%252Ffile%252F7b1849d4-dd2c-4e4d-aded-195fd82feca9 &
   echo 
   read -p "If .deb file is installed please write "yes" and continue, else write no: " answer
   
   if [ "$answer" == "yes" ]; then
     rm -rf ~/packettracer
     echo "path is valid, Continuing..."
     lcdir="$(pwd)"
     mv $lcdir/packet-tracer.sh ~/
     git clone https://aur.archlinux.org/packettracer.git ~/packettracer
     cp ~/Downloads/CiscoPacketTracer* ~/packettracer
     cd ~/packettracer
     mv CiscoPacketTracer* CiscoPacketTracer_811_Ubuntu_64bit.deb
     makepkg -si
     sudo pacman -U packettracer-* --noconfirm
     rm -rf ~/packettracer
     rm -rf ~/packet-tracer.sh ~/packet-tracer-installer/
     echo
     echo
     echo "Thank you for using this script" | lolcat
     echo
   else
     clear
     echo "restarting function..."
     default
   fi
}

older()
{
   # Function for install older version of packet tracer (v. 7.2.2)
   clear
   echo "Install version 7.2.2"
   firefox https://www.netacad.com/portal/resources/file/a32ca2bc-cfc7-4ed0-a73e-17a5a74ed819 &
   echo     
   read -p "If version 7.2.2 is installed and enter yes, else no: " oanswer
   if [ "$oanswer" == "yes" ]; then
     cd ~/Downloads
     chmod +x PacketTracer-7.2.2-ubuntu-setup.run 
     ./PacketTracer-7.2.2-ubuntu-setup.run
     echo
     echo
     echo "Thank you for using this script" | lolcat
     echo
   else
     clear
     echo "restarting function..."
     older
   fi
}

if [ "$1" == "" ]; then
  # The default part of the script that runs when no function is running.
  echo
  echo "Please Use Syntax!"
  echo "-h for help"
  echo
fi

while getopts ":h :d :o" option; do 	# Choosing option of this script
   case $option in
      h) # display Help
         help
         ;;
      d) # Use "default" function
         default
         ;;
      o) # Use "older" function
         older
         ;;
     \?) # incorrect option
         echo "Error: Invalid option"
         ;;
   esac
done
