#/bin/bash

#########################################################################################
# debianSetup.sh
# 
# Author:		Alaam Amershi
# Date:			10/26/19
# Last Modified:	02/12/20
# 
# Description:
# Setup script for vanilla Debian.
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
# SETUP
#########################################################################################

# Title.
printf "${green}\n\t\t <<< %s >>> \n${normal}" $0

# Check if script is being run as root.
if [[ $EUID -ne 0 ]]; then
	printf "${red}%s${normal}" "Error: You must be logged in as root to run this script."
	exit 1
fi


#########################################################################################
# INSTALL CUSTOM THEMES
#########################################################################################

# Install custom themes.
if [[ $(ls | grep themes | wc -c) -gt 0 ]]; then
	mkdir "$HOME/.themes"
	cp -v themes/* $HOME/.themes
fi

# Install custom icons.
if [[ $(ls | grep icons | wc -c) -gt 0 ]]; then
	mkdir "$HOME/.icons"
	cp -v icons/* $HOME/.icons
fi


#########################################################################################
# REMOVE BLOATWARE / INSTALL CUSTOM PACKAGES
#########################################################################################

# Remove junk packages.
apt -y autoremove --purge gnome-games-common gnome-calendar gnome-contacts
apt -y autoremove --purge cheese rhythmbox
apt -y autoremove --purge libreoffice*
#apt -y autoremove --purge 
apt -y autoremove

# Add custom package repositories.
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2019.list)"

# Install packages.
apt update
apt -y upgrade
apt -y install sudo make gdebi gcc-8
apt -y install linux-headers-$(uname -r)
apt -y install openvpn tor lynx mosh tmux nmap
apt -y install apache2 php libapache2-mod-php
apt -y install wireshark gqrx-sdr


#########################################################################################
# GIVE SUDO ACCESS TO USER
#########################################################################################

usermod -a -G sudo $USER
chown -r /var/www/html $USER:$USER


printf "\n\n${green}%s\n" "Done!"
