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
alias ps="procs"
alias vim="nvim"
alias vi="command vim"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias gs="lazygit"
alias wf=". fzf_files.sh"
alias wg=". fzf_grep.sh"

setopt beep extendedglob nomatch notify

bindkey -v
export KEYTIMEOUT=1

[[ ! -d $ZDOTDIR/.antidote ]] &&
    git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

source $ZDOTDIR/.antidote/antidote.zsh
antidote load

ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

zcolors >| $ZDOTDIR/.zcolors

bindkey -M menuselect "^Y" accept-line
bindkey "\t" menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect "\t" menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey "^N" menu-select "^P" menu-select
bindkey -M menuselect "^N" menu-complete "^P" reverse-menu-complete

bindkey "^G" autosuggest-accept

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

colorscript -r

eval "$(starship init zsh)"

eval "$(zoxide init zsh --cmd cd)"

[[ ! -d $HOME/.fzf ]] &&
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf &&
    $HOME/.fzf/install
