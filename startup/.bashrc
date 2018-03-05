# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# IRB - Fix Highlighting on USB writable folders
LS_COLORS="$LS_COLORS:ow="; export LS_COLORS

export TERM="rxvt-unicode-256color"

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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
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
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
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


if [ "$HOSTNAME" = raspberrypi ] ; then
	########## IRB Pi Specifig Aliases ###########
	#Move to separate file as below if gets big list
	alias h=history
	alias tr='transmission-remote'
	alias tc='transmission-remote-cli'
	alias gm='cd /media/wdhd'
	alias gf='cd /media/wdhd/FilmsTV'
	alias gt='cd /media/wdhd/FilmsTV/TempQueue'
	alias rr="/usr/bin/ranger"
	alias rt="/usr/bin/ranger /media/wdhd/FilmsTV/TempQueue"
else

	# Base16 color scheme as https://github.com/chriskempson/base16-shell
	# Type base16_<tab> to see all possibilities.  Can easily switch theme.
	BASE16_SHELL=$HOME/.config/base16-shell/
	[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

	############ IRB Other Aliases ###############
	#Stop gvim errors on startup
	alias h=history
	alias gvim="gvim 2>/dev/null"
	alias mp="/home/iain/.local/bin/mpsyt"
	alias nm="/usr/bin/neomutt"
	#alias yt='mpv --really-quiet  --ytdl-format="bestvideo[height<=?720][vcodec!=vp9]+bestaudio/best"'
	alias gm="cd /media/iain"
	alias gp="cd /media/iain/Data/Archived\ Docs/Shares/Portfolio"
	alias rr="/usr/bin/ranger"
	alias c="/usr/bin/cmus"

	# Hack to set cursor style to i beam in urxvt
	echo -e "\033[5 q";clear
fi

weather () { curl wttr.in/"$@"; }
cheat () { curl cheat.sh/"$@"; }

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

############################### FZF #####################################################
# USEFULL	vim **<TAB>		Files under current Dir
# USEFULL	vim ../**<TAB>	Files under parent dir
# USEFULL 	kill -9 <TAB>		Select process id
# Setup fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# COMMAND: CTRL-P	Search for files then open in vim
# DON'T Try to use FZF_CTRL_P_COMMAND, it appears its the daults one to handle this.  I've added ~ so searcxhes from home.
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --smart-case -g "!{.git,node_modules,Music}/*" --iglob "!*.{jpg,png,pdf,mp3,mp4,avi,pyc,hide}"  ~ 2> /dev/null'
fzf_then_open_in_editor() {
  local file=$(fzf)
  # Open the file if it exists
  if [ -n "$file" ]; then
    # Use the default editor if it's defined, otherwise Vim
    ${EDITOR:-vim} "$file"
  fi
}
bind -x '"\C-p": fzf_then_open_in_editor'

# COMMAND CTRL-T	Search for files and then paste path into terminal, incl jpgs etc as not opening
#					Prob won't use as cd **<tab> does same thing.  NOTE ITS PATHS UNDER CURRENT DIR - don't want to force to home.
export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --follow --smart-case -g "!{.git,node_modules}/*" 2> /dev/null'

# COMMANDL ALT-C	Search dirs then cd into them use bgs insttead
# Issue with escape char being inserted if use ~.  Can fix by hacking code and changing %q to %b in __fzf_cd__  in key-bindings.bash
# Better to fix here by removing it.  Using | in sed as forward slashes in $home. Use 2>/dev/null as was getting Permsn Denied errors.
# IMPORTANT: Don't use -hidden as it ONLY SHOWS HIDDEN.  Using no flag to see everything.
export FZF_ALT_C_COMMAND="cd `echo $HOME`; bfs -type d  2>/dev/null | sed \"s|^\.|`echo $HOME`|\""

# Try to preview files.
# IRB:FOr some reason cant use flags to 'file' in preview call even if wrap in functions.  
# May come back to. In meantime add specific CTRL_P command as prob don't want binaries included anyway
#getEncoding () { file -bi "$@" | sed 's/^.*=//g'; }
#getExt () { echo "$@" | sed 's/^.*\.//g'; }
export FZF_DEFAULT_OPTS=" --preview '(coderay {} || rougify {} || cat {} || tree -C {} ) 2> /dev/null | head -200' "

#########################################################################################

