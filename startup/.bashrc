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

export BC_ENV_ARGS='/home/iain/.bc'


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE='mpv*:youtube-dl *'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Turn on vi mode is bash.  Esc to enter command mode
#set -o vi

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
export TERM="rxvt-unicode-256color"

# Base16 color scheme as https://github.com/chriskempson/base16-shell
# Type base16_<tab> to see all possibilities.  Can easily switch theme.
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"


	

############ IRB Other Aliases ###############
alias h="history"
alias v="vim"
#Stop gvim errors on startup
alias gvim="gvim 2>/dev/null"
alias mp="/home/iain/.local/bin/mpsyt"
#alias nm="/usr/bin/neomutt"
alias m="/usr/bin/mutt"
#alias yt='mpv --really-quiet  --ytdl-format="bestvideo[height<=?720][vcodec!=vp9]+bestaudio/best"'
alias gm="cd /media/iain"
alias gp="cd /media/iain/Data/Archived\ Docs/Shares/Portfolio"
alias gw="cd /home/iain/Dev/0x3F3F.github.io/_posts"
alias l="ls"
alias rr="/usr/bin/ranger"
alias nb="/usr/local/bin/newsboat"
#Want Ripgrep to search hidden files, ignore gitignore, don't show permission errors, etc
alias rg='rg --no-messages --no-ignore --hidden --follow -g "!**/{.git,.cache,.cpan}/"'
alias ytd="yt-dlp"
alias ytm="yt-dlp -ic  --extract-audio --yes-playlist --audio-format mp3 --audio-quality 0 "
alias yt="ytplay.sh "
alias r="ssh raspberrypi"
alias ww="sudo web.sh"
alias am="alsamixer -c 0"
alias cm="/usr/bin/cmus" 
alias b="vim /home/iain/Books/NotesOnBooks/Philosophy/De\ Botton,\ Alain/HowProustCanChangeYourLife.md"

# Hack to set cursor style to i-beam in urxvt
echo -e "\033[5 q";clear

rem () { /usr/bin/remind -w80 -cu -cc $@ /home/iain/.config/remind/reminders.rem ; } #As fn not alias to let pass params, eg -c2
weather () { curl wttr.in/"$@"; }
cheat () { curl cheat.sh/"$@"; }
pdf () { convert $1 -background white -alpha remove -alpha off $1 ; /usr/bin/img2pdf -o ${1%.*}.pdf $1 ; } 

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
# DON'T Try to use FZF_CTRL_P_COMMAND, it appears its the daults one to handle this.  I've ADDED ~ so searches from home.
# The ** in dir regex is 'globstar' and refers to 'zero or more directories'.  When set in bash, ls recusevly searches dirs, this is the same.
# Note --files flag shows all files that would be searched.  Filtering using -h flags => Need both for find functionality.  fzf is refining selection.
RG_EXCLUDE_DIRS=".git,.vim,Music,.cache,cache,.cpan,.local,firefox"
RG_EXCLUDE_FILES="jpg,png,pdf,mp3,mp4,avi,pyc,hide,exe,dll"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --smart-case -g "!**/{'$RG_EXCLUDE_DIRS'}/"  --iglob "!*.{'$RG_EXCLUDE_FILES'}"  ~ 2> /dev/null'
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

# Try to preview files.  HAd trouble with binary code, use rg above to exclude most stuff
# Installed version  of highlight lacked markdown.  Tried to re-complie/failed.  Copied md.lang to /usr/share/highlight/langDefs and updated /etc/highlight/filetypes.conf
export FZF_DEFAULT_OPTS="--color 'hl:196,hl+:196' --preview '(highlight -O ansi -l {} || coderay {} || rougify {} || cat {} || tree -C {} ) 2> /dev/null | head -200' "

#########################################################################################

##### Welcome Message: Output reminder
REMINDER=$(/usr/bin/remind  /home/iain/.config/remind/reminders.rem)
if [ "$REMINDER" != "No reminders." ] ; then
	REMINDER="${REMINDER/*:/Today: }"
	echo -e "\033[0;33m               " $REMINDER "\033[00m"
fi



