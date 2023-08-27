export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export PAGER="bat -p"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

alias find="fd"
alias ls="exa -ah"
alias ll="exa -alh"
alias grep="rg"
alias cat="bat"
alias vim="nvim"
alias vi="command vim"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias gs="lazygit"

setopt beep extendedglob nomatch notify

[[ -e $ZDOTDIR/.antidote ]] ||
    git clone https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

source $ZDOTDIR/.antidote/antidote.zsh
antidote load

bindkey -v
export KEYTIMEOUT=1
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

function zle-keymap-select () {
case $KEYMAP in
    vicmd) echo -ne "\e[1 q";;
    viins|main) echo -ne "\e[5 q";;
esac
}
zle -N zle-keymap-select
zle-line-init() {
zle -K viins
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne "\e[5 q"
preexec() { echo -ne "\e[5 q" ;}

colorscript -r

eval "$(starship init zsh)"

eval "$(zoxide init zsh --cmd cd)"
