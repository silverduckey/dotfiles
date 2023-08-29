#!/usr/bin/env bash

res="$(fd -H . | fzf --ansi --reverse --header='Find files')"
if [[ -n "$res" ]]; then
    if [[ -d "$res" ]]; then
        cd "$res"
    elif [[ -f "$res" ]]; then
        nvim "$res"
    fi
fi
