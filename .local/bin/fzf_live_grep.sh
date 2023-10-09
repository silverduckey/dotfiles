#!/usr/bin/env dash

RG_PREFIX="rg --hidden --column --line-number --no-heading --color=always --smart-case "
res="$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX ''" \
        fzf --bind "change:reload:$RG_PREFIX {q} || true" --ansi --header 'Grep files' | cut -d':' -f1 | sed 's/\\/\\\\/g;s/"/\\"/g'
)"
[ -n "$res" ] && nvim "$res"
