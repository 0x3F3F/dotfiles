# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# IRB - Fix Locale Issue
#export LC_ALL=C
export LC_ALL="en_GB.UTF-8"

# This breaks WinSCP, maybe start automaticaslly from termux instead.
# Raspberry Pi Start tmux straight away
#if [ "$HOSTNAME" = raspberrypi ] ; then
# if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
# fi
#fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# IRB - Fix Highlighting on USB writable folders
LS_COLORS="$LS_COLORS:ow="; export LS_COLORS

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
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
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


alias h="history"
alias v="vim"
if [ "$HOSTNAME" = raspberrypi ] ; then
	########## IRB Pi Specifig Aliases ###########
	#Move to separate file as below if gets big list
	alias tr='transmission-remote'
	alias tc='transmission-remote-cli'
	alias gm='cd /media/wdhd'
	alias gf='cd /media/wdhd/FilmsTV'
	alias gt='cd /media/wdhd/FilmsTV/TempQueue'
	alias rr="/usr/bin/ranger"
	alias rt="/usr/bin/ranger /media/wdhd/FilmsTV/TempQueue"
	alias y="ytplay.sh "

	eval `ssh-agent -s`
	ssh-add ~/.ssh/gitkey

else
	############ IRB Other Aliases ###############
	#Stop gvim errors on startup
	alias gvim="gvim 2>/dev/null"

	alias tw="/usr/local/bin/turses"
	alias yt="/home/iain/bin/ytDispSubs.py"
	alias kb="/usr/bin/onboard"
	alias kp="kpcli.pl --kdb=/media/iain/Data/SysVar/cache/xxxxxxxxx"
	alias gm="cd /media/iain"
	alias gp="cd /media/iain/Data/Archived\ Docs/Shares/Portfolio"
	alias rr="/usr/local/bin/ranger"
	alias c="/usr/bin/cmus"
fi

weather () { curl wttr.in/"$@"; }
cheat () { curl cheat.sh/"$@"; }

#Fuck off python 2.x
#alias python=python3

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

