#! /bin/bash

# Use vim instead of nano
export EDITOR=$(which vim)

# history settings
HISTSIZE=5000
HISTFILESIZE=10000
# append history instead of override it
shopt -s histappend

# save the history immediately, don't wait for the shell to terminate before updating the history file.
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# bind Up/Down arrows for searching history ONLY in interactive mode.
if [[ $- == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
