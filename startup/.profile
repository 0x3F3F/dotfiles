# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin:$HOME/bin/i3:$HOME/bin/LaunchProgs:$HOME/bin/NoAutoBackup:$HOME/scripts:$HOME/.local/bin"
fi

# Swap Alt-Win keys
test -f /home/iain/.config/xkb/IRBXkeymap && xkbcomp /home/iain/.config/xkb/IRBXkeymap $DISPLAY &> /dev/null

# New coloring.  Issue with not being able to read 777 folders, edit .dircolors to change stuff.  
[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || eval $(dircolors -b)

#set default editor to gvim.  hide random errors.
EDITOR="vim"
VISUAL=$EDITOR
PAGER=pager
export EDITOR VISUAL PAGER


