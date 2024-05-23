zstyle ":completion:*" completer _expand _complete _ignored _correct _approximate
zstyle ":completion:*" list-colors ""
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" matcher-list "m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**"
zstyle ":completion:*" menu select=0
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s

HISTFILE=$XDG_DATA_HOME/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt extendedglob histignorealldups histfindnodups sharehistory notify
unsetopt beep
bindkey -v

alias ls="eza -a --icons"
alias ll="eza -alh --icons"
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

ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz compinit
compinit

zinit depth"1" for \
    romkatv/powerlevel10k \
    jeffreytse/zsh-vi-mode \
    zdharma-continuum/fast-syntax-highlighting

zinit wait lucid for \
    zdharma-continuum/history-search-multi-word \
    hlissner/zsh-autopair \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search

[ ! -d $HOME/.fzf ] &&
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf &&
    $HOME/.fzf/install --all --no-bash --xdg

eval "$(zoxide init zsh --cmd cd)"
fastfetch

if [ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
    source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ ! -f ~/.config/zsh/.p10k.zsh ] || source ~/.config/zsh/.p10k.zsh

ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

fast-theme -q XDG:catppuccin-mocha

bindkey "^J" autosuggest-accept

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
