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
alias showLargest='du -a | sort -n -r | less'
alias vim='nvim'

alias mouseDisable='sudo xinput set-prop 7 "Device Enabled" 0'
alias mouseEnable='sudo xinput set-prop 7 "Device Enabled" 1'

source ~/.ssh_accounts

precmd () {
    {print -Pn "\e]0;%n@%M: %~\a"} 2>/dev/null
}

if [[ $TMUX == "" ]]; then
    export TERM=xterm-256color
else
    export TERM=screen-256color
fi
