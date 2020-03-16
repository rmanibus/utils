# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#IGNOREEOF=10
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4096
HISTFILESIZE=8192

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u\[\033[00m\]\[\033[01;34m\]@\[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]\$(__git_ps1 '(%s)')\[\033[01;00m\]\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias l='ls -lhp --color=always --time-style=long-iso'
alias ll='ls -lrthp --color=always --time-style=long-iso'
alias lll='ls -lArthp --color=always --time-style=long-iso'
alias rm='rm -iv'
alias du='du -h --si'
alias df='df -h --si'
alias cp='cp -iv'
alias scp='scp -v'
alias less='less -R'
alias v='vim -R'
alias p='python3'
alias mv='mv -iv'
alias ..='cd ..'
alias ...='cd ../..'
alias c='cc -Wall -g -O0 -std=c11'
alias g='g++ -Wall -g -O0 -std=c++1y -Werror=conversion -Werror=uninitialized'
alias date='date +%Y-%m-%d" "%H:%M:%S," "%A'
alias j='jobs'
alias vi='vim -u /etc/vim/vimrc'
cd() { builtin cd "$@" && ls -arthlG; }

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

TTY=$(tty | grep -o tty)
if [ -z $TTY ]; then
        man() {
                env LESS_TERMCAP_mb=$'\E[01;31m' \
                        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
                        LESS_TERMCAP_me=$'\E[0m' \
                        LESS_TERMCAP_se=$'\E[0m' \
                        LESS_TERMCAP_so=$'\E[38;5;246m' \
                        LESS_TERMCAP_ue=$'\E[0m' \
                        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
                        man "$@"
        }
fi

#date() {
#       /bin/date --rfc-3339='seconds' | cut -d'+' -f1 | tr ' ' '_' | tr ':' '-'
#}

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#noir           30      40
#rouge          31      41
#vert           32      42
#jaune          33      43
#bleu           34      44
#violet         35      45
#bleu clair     36      46
#blanc          37      47

#bind 'set show-all-if-ambiguous on'
#bind 'TAB:menu-complete'
#bind 'set completion-ignore-case on'
