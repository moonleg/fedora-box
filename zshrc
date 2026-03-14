# Lines configured by zsh-newuser-install
autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt hist_expire_dups_first
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd
setopt complete_in_word
unsetopt extendedglob
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

autoload -U colors
colors

PROMPT='%F{red}[+]%f%B[%n@%m]%b %~
$ '
