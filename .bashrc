export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export PAGER="bat -p"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

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
alias wf=". fzf_files.sh"

shopt -s extglob

set -o vi

colorscript -r

eval "$(starship init bash)"

eval "$(zoxide init bash --cmd cd)"

[[ ! -d $HOME/.fzf ]] &&
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && ~/.fzf/install

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
