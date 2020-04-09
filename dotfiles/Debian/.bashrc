# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH="$PATH:/opt/mssql-tools/bin"


########################################################################################


########################################################################################
# MY VARIABLES
########################################################################################

# Escape sequences used for text color.
normal="\x1B[0m"
red="\x1B[31m"
green="\x1B[32m"
yellow="\x1B[33m"
blue="\x1B[34m"
magenta="\x1B[35m"
cyan="\x1B[36m"
white="\x1B[37m"


########################################################################################
# MY SHELL
########################################################################################

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\W\[\033[00m\]\[\033[01;34m\]\$\[\033[00m\] '
#PS1='\[\033[01;35m\]\W\[\033[00m\]\[\033[01;34m\]\$\[\033[00m\] '


########################################################################################
# MY ALIASES
########################################################################################

# General.
alias ls='ls -lah --color'
alias df='df -h'
alias du='du -h'
alias cls='clear'
alias rs='sudo shutdown -r now'
alias q='exit'

# Package management.
alias u="sudo su -c 'apt -y update && apt -y upgrade && apt -y autoremove' root"
alias inst='sudo apt -y install'
alias uinst='sudo apt -y autoremove --purge'

# Shell config.
alias bashrc='vi ~/.bashrc'
alias br='bashrc'
alias bp='vi ~/.bash_profile'
alias resrc='. ~/.bashrc && . ~/.bash_profile'
alias rsrc='resrc'

# git
alias ga='git add'
alias gc='git commit && git push'

# i3wm config
alias i3config='vi ~/.config/i3/config'

# tmux
alias tm='tmux'
alias tl='tmux ls'
alias ta='tmux a -t'
alias ts='ta ssh'
alias tmc='vi ~/.tmux.conf'

# nmap
alias ports='nmap 127.0.0.1'
alias nmap='nmap -Pn'
alias nm='nmap'

# tightvncserver
alias tv='tightvncserver'
alias tvk='tv -kill :1'
alias tvr='tvk && tv'
alias tvc='vi ~/.vnc/xstartup'

# exiftool
alias exiftool='exiftool -r -v3 -overwrite_original_in_place'
alias et='exiftool'
alias smbclean='et /home/alaam/smb/Pictures/ && et /home/alaam/smb/Videos/'

# fdupes
alias fdupes='fdupes -rdN'
alias fd='fdupes'

# gallery-dl
alias gallery-dl='~/.local/bin/gallery-dl'
alias gd='gallery-dl'

# Other.
alias nano='nano -c'
alias feh='feh --bg-scale'
alias randwall='feh --randomize --bg-scale ~/Pictures/Wallpapers/'
alias vncserver='vncserver :1 -geometry 1920x1080'
alias vk='vncserver --kill'
alias vpi3="sshpass -p '0890' ssh pi@192.168.0.193"


########################################################################################
# MY FUNCTIONS
########################################################################################

# Create backup of file.
bak() {
	cp -v "$1" "$1.orig"
}

# Deletes files in the current directory which do not have extensions.
dirClean() {
	# https://askubuntu.com/questions/466219/find-and-delete-all-files-without-extensions-witin-a-folder-and-its-subfolders
	find . -type f  ! -name "*.*"  -delete
	#find . -type f  ! -name "*.?*" -delete
}

# Mount SMB share located on vPi3.
mountsmb() {
	smbIP="192.168.0.193"
	smbShare="sda1"
	smbUser="pi"
	smbPass="2005"
	mountDir="/home/$USER/smb/"

	sudo mount -t cifs //$smbIP/$smbShare -o username=$smbUser,password=$smbPass,uid=$EUID,gid=$EUID $mountDir
}

mynetmounts() {
	sshfs pi@192.168.0.193:/home/pi/ ~/mounts/rpihome/
	sshfs pi@192.168.0.193:/mnt/sda1/ ~/mounts/rpismb/
}

# Normalize audio files.
norm() {
	pwdPath="$(pwd)/"
	dirPath="$pwdPath"

	if [[ $# -eq 1 ]]; then
		dirPath=$1
	fi

	cd $dirPath

	for f in *.mp3;
	do
		soxOutput="$(mktemp /tmp/XXXXXXXXXX.mp3)"
		sox -S --norm "$f" $soxOutput && mv $soxOutput "$f"
	done

	cd $pwdPath
}

# Launches the Tor Browser from the home directory.
torbrowser() {
	if [[ $# -gt 1 ]];
	then
		printf "$red%s$normal\n" "Error: Too many arguments."
		return 0
  	fi

	case $1 in
		"-s" | "--start")
			pwd=$(pwd)/
			cd ~/tor-browser_en-US/ && ./start-tor-browser.desktop
			cd $pwd
			;;
		"-k" | "--kill")
			killall ~/tor-browser_en-US/Browser/firefox.real
			;;
		*)
			printf "${red}%s${normal}\n" "Error: Invalid arguments!"
			;;
	esac
}
