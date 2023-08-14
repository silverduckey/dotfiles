export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export MANPAGER="batman"

alias find="fd"
alias ls="exa -ah"
alias ll="exa -alh"
alias grep="rg"
alias cat="bat"
alias man="batman"
alias vim="nvim"
alias vi="command vim"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt autocd beep extendedglob nomatch notify

zstyle :compinstall filename "/home/vu/.zshrc"
autoload -Uz compinit
compinit

bindkey -v

if [ -d "$HOME/.local/bin" ] ;
then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.bin" ] ;
then PATH="$HOME/.bin:$PATH"
fi

colorscript -r

eval "$(starship init zsh)"

[[ -e ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
