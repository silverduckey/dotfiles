#!/usr/bin/env dash

res="$(fd -H . | fzf --ansi --header='Find files' --preview 'bat -p {}')"
if [[ -n "$res" ]]; then
    if [[ -d "$res" ]]; then
        cd "$res"
    elif [[ -f "$res" ]]; then
        nvim "$res"
    fi
fi
