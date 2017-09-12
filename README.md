#DOTFILES

```
 bin              > Scripts to setup links
 cmus             > Terminal MP3 player to use over SSH.
 getmail          > Was using this with mutt. May drop it.
 i3               > My descent into 1980's era computing continues...
 mutt             > Email client with Spectrum 48K styling & vim key binds.
 ranger           > Vimey terminal File Manager. Ladies love it.
 rawdog           > RSS Aggregator thingy.
 startup          > Important startup scripts .bashrc .profile .Xdefaults
 transmission-rpi > Bit torrent via SSH on my Pi. Yes! SEE NOTE
 vim              > Based on a port of Vi for the Amiga, apparently.
```

## table of contents
 - [Overview](#Overview)
 - [Managing](#Managing)
 - [How it Works](#How-it-Works)
 - [Git](#Git)
 - [vim](#vim)
 - [transmission](#transmission)

it's been said of every console user: 
> _"you are your dotfiles"_.


## Overview
Store config files in one place under version control then symlink into place using 
[gnu stow](http://www.gnu.org/software/stow/)

You know it makes sense.


## How it Works
By default, the stow command will create symlinks for files in the parent directory of where you execute the command. 
So my dotfiles setup assumes this repo is located in the root of your home directory `~/.dotfiles` and all stow commands should be executed in that directory.

**Quick setup**:

    git clone git@github.com:0x3F3F/dotfiles.git

To **stow**:

    cd $HOME/.dotfiles
	stow bash git [... other directories ...]

To **unstow**:

    cd $HOME/.dotfiles
	stow -D bash git [... other directories ...]


**note:** stow can only create a symlink if a config file does not already exist.
If a default file was created upon program installation you must delete it first before you can install a new one with stow.
This does not apply to directories, only files.


## Git

I have git setup to use ssh keys

### Fetching Config

	cd ~/.dotfiles
	git clone git@github:0x3F3F/dotfiles.git

### Adding Files

	git add <filename>
	git commit -m "Message Here"
	git push origin master

### Changing Files

	git add <changedfile>
	git commit -m "Message Here"
	git push origin master

### Getting Updates

	cd ~/.dotfiles
	git pull


## Notes on some programs
Some programs are a bit fiddley, extra info here: 

### vim
This includes only .vimrc and not individual plug ins that need to be installed via Bundle :PluginInstall!

### transmission
I use transmission-daemon on my Raspberry Pi,connecting via SSH and controling via transmission-remote-cli.
Ihttps://github.com//dotfiles $HOME/.dotfilest all rather cool.  Installation of this is **NON STANDARD** as installs config to alternate location and the 
daemon needs to be stopped otherwise changes overwriten

	sudo service transmission-dawmon stop
	/var/lib/transmission-daemon/info/settings.json
	sudo service transmission-dawmon start


