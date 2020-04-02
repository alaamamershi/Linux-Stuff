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
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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
alias rs='sudo systemctl reboot -i'
alias q='exit'
alias cls='clear'

# Package management.
alias u="sudo su -c 'apt -y update && apt -y upgrade && apt -y autoremove' root"
alias inst='sudo apt -y install'
alias uinst='sudo apt -y autoremove --purge'

# Shell config.
alias br='vi ~/.bashrc'
alias bp='vi ~/.bash_profile'
alias resrc='. ~/.bashrc'
alias rsrc='resrc'

# tmux
alias tm='tmux'
alias tl='tmux ls'
alias ta='tmux a -t'
alias ts='ta ssh'
alias tmc='vi ~/.tmux.conf'

# exiftool
alias exiftool='exiftool -r -v3 -overwrite_original_in_place'
alias et='exiftool'
alias smbclean='et /mnt/sda1/Pictures/ && et /mnt/sda1/Videos/'

# fdupes
alias fdupes='fdupes -rdN'
alias fd='fdupes'

# nmap
alias ports='nmap 127.0.0.1'
alias nmap='nmap -Pn'
alias nm='nmap'

# svn
alias svnconfig='sudo vi /etc/apache2/mods-available/dav_svn.conf'
alias svnpasswd='sudo htpasswd /etc/apache2/dav_svn.passwd'
alias svnusers='sudo vi /etc/apache2/dav_svn.passwd'
alias svnperms='sudo vi /etc/apache2/dav_svn.authz'
alias a2restart='sudo /etc/init.d/apache2 reload && sudo /etc/init.d/apache2 restart'
alias a2rs='a2restart'

# Other.
alias nano='nano -c'
alias feh='feh --bg-scale'
alias vncserver='vncserver :1 -geometry 1920x1080'
alias vk='vncserver --kill'


########################################################################################
# MY FUNCTIONS
########################################################################################

# Create backup of file.
bak() {
	now="$(date +'%d/%m/%Y')"
	cp -v "$1" "$1 ($now).bak"
}

# Normalizes audio files using sox.
norm() {
	pwdPath="$(pwd)/"
	dirPath="$pwdPath"

	if [[ $# -eq 1 ]];
	then
		dirPath=$1
	fi

	cd $dirPath

	# Generate normalized audio file and overwrite original.
	for file in *.mp3;
	do
		soxOutput="$(mktemp /tmp/XXXXXXXXXX.mp3)"
		sox -S norm "$file" $soxOutput && mv -v $soxOutput $file
	done

	cd $pwdPath
}


########################################################################################
# TMUX FOR SSH LOGINS
########################################################################################

if [[ -n $SSH_CONNECTION ]] && [[ -z $TMUX ]];
then
	session="$(hostname)"

	if [[ $(tmux ls | grep $session | wc -c) -eq 0 ]];
	then
		tmux new-session -s $session
	else
		tmux attach-session -t $session
	fi
fi
