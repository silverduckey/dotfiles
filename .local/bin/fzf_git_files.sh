#!/usr/bin/env dash

res="$(fd -H --ignore-file .gitignore . | fzf --ansi --header='Git files' --preview 'bat -p {}')"
if [[ -n "$res" ]]; then
    if [[ -d "$res" ]]; then
        cd "$res"
    elif [[ -f "$res" ]]; then
        nvim "$res"
    fi
fi
