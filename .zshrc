zstyle ':completion:*' completer _expand _complete _ignored _approximate

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep

autoload -U colors && colors
PROMPT="%{$fg_bold[green]%}%n@%m%{$reset_color%}%\:%{$fg_bold[blue]%}%~%{$reset_color%}%(!.#.$) "

alias ls='ls -FG'
alias ll='ls -lha'
alias lr='ls -ltr'
alias l='ls -lh'
alias showLargest='du -a --max-depth=1 | sort -n -r | less'
EDITOR=nvim

alias mouseDisable='sudo xinput set-prop 7 "Device Enabled" 0'
alias mouseEnable='sudo xinput set-prop 7 "Device Enabled" 1'
alias shares='cd /home/sean/Documents/Programming/Infiniscene/shares'
export PATH=$PATH:~/bin
export GOPATH=~/Documents/Programming/Go/Code
