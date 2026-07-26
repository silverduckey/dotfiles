set XDG_DATA_HOME "$HOME/.local/share"
set XDG_CONFIG_HOME "$HOME/.config"
set XDG_STATE_HOME "$HOME/.local/state"
set XDG_CACHE_HOME "$HOME/.cache"

set fish_greeting
set EDITOR nvim
set PAGER less

set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin $HOME/.local/share/bob/nightly/bin $fish_user_paths

if status is-interactive
    set -Ux FZF_DEFAULT_OPTS "
	--color=fg:#908caa,bg:#232136,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#232136
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

    alias cat bat
    alias man batman
    alias rg "batgrep --hidden"
    alias fd "fd -H"
    alias top btop
    alias ps procs
    alias du dust
    alias cp "cp -riv"
    alias mv "mv -iv"
    alias rm "rm -riv"
    alias gs lazygit
    alias archwiki "archwiki-offline -m fzf -o w3m"

    fish_vi_key_bindings

    if not functions -q fisher
        curl -sL https://git.io/fisher | source
        fisher update
    end

    fzf --fish | source
    eval (batpipe)
    set --universal zoxide_cmd cd
    set -Ux EZA_STANDARD_OPTIONS --icons
    fish_config theme choose "Rosé Pine Auto"

    fortune | cowsay -rC
end
