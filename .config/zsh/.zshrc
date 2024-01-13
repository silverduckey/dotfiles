zstyle ":completion:*" completer _expand _complete _ignored _correct _approximate
zstyle ":completion:*" list-colors ""
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" matcher-list "r:|[._-]=** r:|=**" "l:|=* r:|=*"
zstyle ":completion:*" menu select=0
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s

autoload -Uz compinit
compinit

HISTFILE=$XDG_DATA_HOME/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt extendedglob notify
unsetopt beep
bindkey -v

alias fd="fd -H"
alias rg="rg --hidden"
alias cat="bat"
alias ps="procs"
alias top="btm"
alias du="dust"
alias vim="nvim"
alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -ri"
alias gs="lazygit"
alias wf=". fzf_find_files"
alias wg=". fzf_live_grep"
alias gf=". fzf_git_files"

if [ ! -f $ZDOTDIR/.zi/bin/zi.zsh ]; then
    print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
    command mkdir -p "$HOME/.config/zsh/.zi" && command chmod go-rwX "$ZDOTDIR/.zi"
    command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$ZDOTDIR/.zi/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$ZDOTDIR/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit

if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zi depth"1" for \
    romkatv/powerlevel10k \
    jeffreytse/zsh-vi-mode \
    z-shell/F-Sy-H \
    z-shell/zsh-eza

zi wait lucid for \
    z-shell/zsh-zoxide \
    z-shell/H-S-MW \
    hlissner/zsh-autopair \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search

[ ! -d $HOME/.fzf ] &&
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf &&
    $HOME/.fzf/install --all

[ ! -f ~/.config/zsh/.p10k.zsh ] || source ~/.config/zsh/.p10k.zsh

ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

fast-theme -q CONFIG:catppuccin-mocha

eza_params=("--all" "--icons")

_ZO_CMD_PREFIX="cd"
_ZO_FZF_OPTS="--ansi"

bindkey "^G" autosuggest-accept

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

eval "$(thefuck --alias f)"
