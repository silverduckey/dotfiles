export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export PAGER="bat -p"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.bin:$PATH"

eval "$(zoxide init bash)"

alias find="fd"
alias ls="exa -ah"
alias ll="exa -alh"
alias grep="rg"
alias cat="bat"
alias man="batman"
alias cd="z"
alias cdi="zi"
alias vim="nvim"
alias vi="command vim"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias gs="lazygit"

shopt -s autocd extglob

set -o vi

colorscript -r

eval "$(starship init bash)"
