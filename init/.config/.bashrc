#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTTIMEFORMAT="[%Y-%m-%d] [%T]  "

# Core aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lFh'
alias la='ls -Fah'
alias lla='ls -lFah'
alias ping='ping -c3'
alias sl=ls
alias vi=vim
if [ -f /usr/bin/zoxide ]; then
    alias cd=z
    eval "$(zoxide init bash)"
fi

if [ -f /usr/bin/nvim ]; then
    alias vim='/usr/bin/nvim'
else
    alias v='/usr/bin/vim'
fi

# Safety aliases.
if [ -f /usr/bin/trash ]; then
    alias rm='trash -v'
else
    alias rm='rm -i'
fi
alias cp='cp -iv'
alias mv='mv -iv'

# Application aliases.
alias ts='/usr/bin/tailscale'
alias sqlite='/usr/bin/sqlite3'
alias st='speedtest-cli --secure'

set -o noclobber
set -o vi

if [ -f /usr/bin/nvim ]; then
    export EDITOR=/usr/bin/nvim
else
    export EDITOR=/usr/bin/vim
fi

git_branch() {
    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return
    if [ -z "$branch" ]; then
        return
    else
        echo "(⦿─●─● $branch)"
    fi
}

PS1='\[\e[38;5;165m\][\u\[\e[38;5;171m\]@\[\e[38;5;213m\]\h] \[\e[38;5;219m\](\w) ($?) $(git_branch)\[\e[0m\]\n\$ '
