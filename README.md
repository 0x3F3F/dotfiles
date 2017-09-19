# DOTFILES

> _"you are your dotfiles"_.

## table of contents

 - [Overview](#Overview)
 - [How it Works](#How-it-Works)
 - [Git](#Git)
 - [Notes on Some Programs](#Notes-on-Some-Programs)


## Overview
Store config files in one place under version control then symlink into place using 
[gnu stow](http://www.gnu.org/software/stow/)

Including program configs where I've changed from the default.  The following programs will have their config files managed in this manner

```
 bin              > Scripts to setup symlinks
 cmus             > Terminal MP3 player to use over SSH.
 getmail          > Was using this with mutt. May drop it.
 i3               > My descent into 1980's era computing continues...
 mutt             > Email client with Spectrum 48K styling & vim key binds.
 ranger-rpi       > Vimey terminal File Manager. Ladies love it.
 rawdog           > RSS Aggregator thingy.
 startup          > Important startup scripts .bashrc .profile .Xdefaults
 transmission-rpi > Bit torrent via SSH on my Pi. Yes! SEE NOTE
 vim              > Based on a port of Vi for the Amiga, apparently.
```

## How it Works
By default, the stow command will create symlinks for files in the parent directory of where you execute the command. 
So my dotfiles setup assumes this repo is located in the root of your home directory ~/.dotfiles 

To **stow** (Add links):

I have machine specific scripts, due to the raspberry pi's Very different setup. They are `StowStuff.sh` and `StowStuffRPi.sh`.  To Add or ReAdd run :

	cd ~/.dotfiles/bin/StowStuff.sh -R

To **unstow** (delete):

	cd ~/.dotfiles/bin/StowStuff.sh -D

**note:** stow can only create a symlink if a config file does not already exist.
If a default file was created upon program installation you must delete it first before you can install a new one with stow.
This does not apply to directories, only files.


## Git

I have git setup to use ssh keys

### Fetching Config

	git clone git@github:0x3F3F/dotfiles.git ~/.dotfiles

### Adding or Modifying Files

	git add <filename>
	git commit -m "Message Here"
	git push origin master

If updating multiple files then can do a `git add .`

### Getting Updates

	cd ~/.dotfiles
	git pull


## Notes on Some Programs
Some programs are a bit fiddley, extra info here: 

### vim
This includes only .vimrc and not individual plug ins that need to be installed via Vundle:PluginInstall!  
I've put Vimptanator config here, on off chance Firefox get their act together.

### transmission
I use transmission-daemon on my Raspberry Pi,connecting via SSH and controling via transmission-remote-cli.
All rather cool.  Installation of this is **NON STANDARD** as installs config to alternate location and the 
daemon needs to be stopped otherwise changes overwriten. I guess I could script this

	sudo service transmission-dawmon stop
	/var/lib/transmission-daemon/info/settings.json
	sudo service transmission-dawmon start


