# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '/home/sdubois/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
# End of lines configured by zsh-newuser-install
#

autoload -U colors && colors
PROMPT="%{$fg_bold[green]%}%n@%m%{$reset_color%}%\:%{$fg_bold[blue]%}%~%{$reset_color%}%(!.#.$) "

source ~/.ssh_accounts

alias ls='ls -FG'
alias ll='ls -lha'
alias lr='ls -ltr'
alias l='ls -lh'
alias showLargest='du -a | sort -n -r | less'

alias mouseDisable='sudo xinput set-prop 7 "Device Enabled" 0'
alias mouseEnable='sudo xinput set-prop 7 "Device Enabled" 1'

wireless(){
    sudo killall wpa_supplicant
    sudo killall dhclient
	sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlan0
	sudo dhclient wlan0
}

case $TERM in
    *xterm*)
        precmd () {{print -Pn "\e]0;%n@%M: %~\a"} 2>/dev/null}
        ;;
esac
