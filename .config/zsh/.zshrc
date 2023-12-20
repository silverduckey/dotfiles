zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

autoload -Uz compinit
compinit

HISTFILE=$XDG_DATA_HOME/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt extendedglob notify
unsetopt beep
bindkey -v

alias ls="exa -ah"
alias ll="exa -alh"
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

. $ZDOTDIR/catppuccin_mocha-zsh-syntax-highlighting.zsh

[ ! -d $ZDOTDIR/.antidote ] &&
    git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

zsh_plugins=$ZDOTDIR/.zsh_plugins.zsh

fpath+=($ZDOTDIR/.antidote)
autoload -Uz $fpath[-1]/antidote

if [ ! $zsh_plugins -nt $zsh_plugins:r.txt ]; then
    (antidote bundle <$zsh_plugins:r.txt >|$zsh_plugins)
fi

source $zsh_plugins

[ ! -d $HOME/.fzf ] &&
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf &&
    $HOME/.fzf/install --all

if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

bindkey "^G" autosuggest-accept

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

eval "$(zoxide init zsh --cmd cd)"

eval "$(thefuck --alias f)"

[ ! -f ~/.config/zsh/.p10k.zsh ] || source ~/.config/zsh/.p10k.zsh
