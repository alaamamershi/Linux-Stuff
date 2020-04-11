#/bin/bash

#########################################################################################
# DebianSetup.sh
# 
# Author:			Alaam Amershi
# Date:				10/26/19
# Last Modified:	04/11/20
# 
# Description:
# Setup script for fresh Debian installs.
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
apt update
apt -y upgrade

# Install packages from repos.
apt -y install linux-headers-$(uname -r)
apt -y install make cmake gcc gcc-8
apt -y install sudo git hub gdebi tmux mosh lynx nmap
apt -y install openvpn tor
apt -y install samba samba-common-bin sshfs
apt -y install apache2 php libapache2-mod-php
apt -y install wireshark gqrx-sdr vlc
#apt -y install 


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
