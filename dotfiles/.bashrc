# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=10000
HISTFILESIZE=20000

umask 022

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Disable the goddamn blinking cursor
echo -e -n "\x1b[\x32 q"

if [ -n "$SSH_CLIENT" ]; then
  TITLE="\[\e]0;\u@\h: \w\a\]"
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
  TITLE="\[\e]0;\W\a\]"
  PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    PS1="$TITLE$PS1"
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

alias clip='xclip -selection clipboard'
alias be='bundle exec'
alias rspec='bundle exec rspec'
alias rubocop='bundle exec rubocop'
alias ghit='git'
alias gti='git'
alias alida='xfreerdp -d UMROOT -u ulib-ouadmin9 -g 1920x1080 141.211.216.51'
alias branchdirs='read -n 1 -p "OK to make bunch of dirs in ../? [yN]" -r; echo ; [[ $REPLY =~ ^[Yy]$ ]] && git ls-remote --heads | cut -f 3 -d "/" | grep -v master | grep -v "From " | xargs -I{} git worktree add ../{} {}'

# asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
source <(kubectl completion bash)

# fd
# we have an ignore in ~/.config/fd/ignore

# fzf
fzfbin=`asdf which fzf`
source "${fzfbin%/bin/fzf}/shell/completion.bash"
source "${fzfbin%/bin/fzf}/shell/key-bindings.bash"
export FZF_DEFAULT_COMMAND='fd --type file --strip-cwd-prefix --hidden --exclude .git'

# bat
alias cat='bat --tabs 2'
export BAT_THEME="gruvbox-dark"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # use bat as manpager (for man)
# export MANROFFOPT="-c" # fixes issues with above
batlog() { # tail -f with syntax highlighting
  tail -f $@ | bat --paging=never -l log
}
alias bathelp='bat --plain --language=help' # This makes the help command a better
help() {                                    # way of asking for --help. Usually.
  "$@" --help 2>&1 | bathelp
}
batcolors() { # Lets you view try out all of the color themes on a given file
  bat --list-themes | fzf --preview="bat --theme={} --color=always $@"
}

# ripgrep

