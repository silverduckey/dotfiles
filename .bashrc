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

shopt -s extglob

set -o vi

[[ ! -d $HOME/.fzf ]] &&
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf &&
    $HOME/.fzf/install --all

colorscript -r

eval "$(zoxide init bash --cmd cd)"

eval "$(thefuck --alias f)"

eval "$(starship init bash)"
