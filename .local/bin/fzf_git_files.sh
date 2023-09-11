#!/usr/bin/env bash

res="$(fd -H --ignore-file .gitignore . | fzf --ansi --reverse --header='Git files' --preview 'pistol {}')"
if [[ -n "$res" ]]; then
    if [[ -d "$res" ]]; then
        cd "$res"
    elif [[ -f "$res" ]]; then
        nvim "$res"
    fi
fi
