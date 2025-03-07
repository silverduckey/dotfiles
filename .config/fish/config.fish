set XDG_DATA_HOME "$HOME/.local/share"
set XDG_CONFIG_HOME "$HOME/.config"
set XDG_STATE_HOME "$HOME/.local/state"
set XDG_CACHE_HOME "$HOME/.cache"

set fish_greeting
set EDITOR "nvim"
set VISUAL "neovide"
set TERM "xterm-256color"
set PAGER "less"

set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin $fish_user_paths

set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --color=border:#313244,label:#cdd6f4"

alias fd "fd -H"
alias rg "rg --hidden"
alias cat "bat"
alias ps "procs"
alias top "btm"
alias du "dust"
alias vim "nvim"
alias cp "cp -ri"
alias mv "mv -i"
alias rm "rm -ri"
alias gs "lazygit"
alias archwiki "archwiki-offline -m fzf -o w3m"

fish_vi_key_bindings

if not functions -q fisher
    curl -sL https://git.io/fisher | source
    fisher update
end

[ ! -d $HOME/.fzf ] &&
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf &&
$HOME/.fzf/install --all --xdg --no-bash --no-zsh

set --universal zoxide_cmd cd

set -Ux EZA_STANDARD_OPTIONS --icons

set fzf_preview_dir_cmd eza -alh --color=always --icons
set fzf_preview_file_cmd bat -p

fish_config theme choose "Catppuccin Mocha"

if status is-interactive
    fortune | cowsay -rC
end
