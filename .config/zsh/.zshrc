zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true

autoload -Uz compinit
compinit

HISTFILE=$XDG_DATA_HOME/zsh/.zsh_history
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
alias vi="command vim"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias gs="lazygit"
alias wf=". fzf_find_files.sh"
alias wg=". fzf_live_grep.sh"
alias gf=". fzf_git_files.sh"

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

eval "$(zoxide init zsh --cmd cd)"

eval "$(thefuck --alias f)"

eval "$(starship init zsh)"
