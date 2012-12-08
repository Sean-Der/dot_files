autoload -U colors && colors
autoload -Uz promptinit
promptinit

PROMPT="%{$fg_bold[green]%}%n@%m%{$reset_color%}%\:%{$fg_bold[blue]%}%~%{$reset_color%}%(!.#.$) "

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select=5
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
eval "$(dircolors -b)"
zstyle ':completion:*:correct:*' insert-unambiguous true 
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
zstyle ':completion:*:history-words'   list false                          #
zstyle ':completion:*:history-words'   menu yes                            # activate menu
zstyle ':completion:*:history-words'   remove-all-dups yes                 # ignore duplicate entries
zstyle ':completion:*:history-words'   stop yes                            #

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source ~/.ssh_accounts
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

#Color colour dir listings
alias ls='ls -F --color=auto' 
alias ll='ls -lha'
alias lr='ls -ltr'
alias l='ls -lh'

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

export PATH=/home/sean/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/sean/Documents/Programming/Android/tools:/home/sean/Documents/Programming/Android/platform-tools:/home/sean/Documents/Programming/Android/tools:/home/sean/Documents/Programming/Android/platform-tools
