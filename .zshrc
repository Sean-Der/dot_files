# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sdubois"

source ~/.ssh_accounts

#Stop correcting this stuff
alias aptitude='nocorrect aptitude'

# Aliases


#Pure Debian packages
alias purgepkgs='dpkg --get-selections | grep deinstall | sed "s/deinstall//g" |sudo xargs apt-get remove -y --purge'

#matlab
alias matlab='~/Documents/MATLAB/bin/./matlab -glnx86'
alias matlab-nogui='~/Documents/MATLAB/bin/./matlab -glnx86 -nojvm'

#Work terminal services server
alias sairdp='xfreerdp -u sdubois ts.saicorporate.com'

#Android emulator
alias androidavd='emulator -avd defaultAVD -no-boot-anim -scale 0.65 -show-kernel'

#Easy wireless hook function taking down first helps with locked interface on Hibernate
function wireless {
	sudo ifdown wlan0 > /dev/null
	sudo ifup -i /etc/network/wireless/$1 wlan0
}

#Quickly check out a VTG git project
function vtgclone {
	git clone gitolite@portal.comm-core.com:$1	
}

function tmux {
	if [ $TERM = "linux" ]; then 
		command tmux
	else 
		command tmux -2 -f ~/.config/tmux.color
	fi
}


# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git debian)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/sean/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/sean/Documents/Programming/Android/tools:/home/sean/Documents/Programming/Android/platform-tools:/home/sean/Documents/Programming/Android/tools:/home/sean/Documents/Programming/Android/platform-tools
