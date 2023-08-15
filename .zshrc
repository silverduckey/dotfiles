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

setopt autocd beep extendedglob nomatch notify

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

if [ -d "$HOME/.local/bin" ] ;
then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.bin" ] ;
then PATH="$HOME/.bin:$PATH"
fi

[[ -e ${ZDOTDIR:-~}/.antidote ]] ||
    git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

bindkey -v
export KEYTIMEOUT=1
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

function zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
fi
}
zle -N zle-keymap-select
zle-line-init() {
zle -K viins
echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q'
preexec() { echo -ne '\e[6 q' ;}

colorscript -r

eval "$(starship init zsh)"
