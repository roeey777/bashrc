#! /bin/bash

# history alias
alias hist="history | less"

# cd aliases
alias ..="cd .."
alias ...="cd ../.."

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# use the minimal ps1 (useful in terminal within vim)
alias minimal_ps1="source ${HOME}/.bash/minimal.sh"
