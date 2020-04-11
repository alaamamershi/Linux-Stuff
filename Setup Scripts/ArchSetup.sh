#/bin/bash

#########################################################################################
# ArchSetup.sh
# 
# Author:			Alaam Amershi
# Date:				04/09/19
# Last Modified:	04/10/20
# 
# Description:
# Setup script template.
#########################################################################################

#########################################################################################
# VARIABLES
#########################################################################################

# ANSI escape sequences used for text color.
green='\033[0;32m'
yellow='\033[1;33m'
red='\033[0;31m'
normal='\033[0m'


#########################################################################################
# STARTUP
#########################################################################################

# Title.
printf "\n\t\t$green<<< %s >>>$normal\n" $0

# Check if script is being run as root.
if [[ $EUID -ne 0 ]]; then
	printf "$red%s$normal\n" "Error: You must be logged in as root to run this script."
	exit 1
fi


#########################################################################################
# PACKAGE INSTALLATION
#########################################################################################

# Update repos and installed packages.
pacman -Syu --noconfirm

# Install packages.
pacman -S --noconfirm linux-headers
pacman -S --noconfirm make cmake gcc gcc8
pacman -S --noconfirm sudo git hub tmux mosh lynx nmap
pacman -S --noconfirm openvpn tor
pacman -S --noconfirm samba sshfs
pacman -S --noconfirm apache php-apache
pacman -S --noconfirm wireshark-cli wireshark-qt
pacman -S --noconfirm vlc
#pacman -S --noconfirm 


#########################################################################################
# USER PERMS
#########################################################################################

usermod -a -G sudo $USER
usermod -a -G www-data $USER


#########################################################################################
# FINISH
#########################################################################################

printf "\n\n$green%s$normal\n" "Done!"

# Reboot prompt.
while true;
do
	read -p "Would you like to reboot now? (y/n) " rebootConfirmation
	rebootConfirmation = $(echo $rebootConfirmation | awk '{ print tolower($0) }')

	case $rebootConfirmation in
		"y")
			printf "$green%s$normal\n" "Rebooting system..."
			shutdown -r now
			break
			;;
		"n")
			printf "$yellow%s$normal\n" "Please reboot your system when convenient."
			break
			;;
		*)
			printf "$red%s$normal\n" "Invalid input.  Please try again."
			;;
	esac
done
