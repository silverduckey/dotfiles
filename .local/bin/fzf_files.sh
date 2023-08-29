#!/usr/bin/env bash

res="$(fd -H . | fzf --ansi --reverse --header='Find files')"
if [[ -n "$res" ]]; then
    if [[ -d "$res" ]]; then
        cd "$res" && lf .
    elif [[ -f "$res" ]]; then
        nvim "$res"
    fi
fi
