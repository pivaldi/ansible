# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

[ ! -z "${BASH_ARGC}${BASH_ARGV}" ] && ISINCLUDED=yes || ISINCLUDED=no

# dont do anything for non-interactive shells
[[ -z "$PS1" ]] && [[ "$ISINCLUDED" == "no" ]] && return

iatest=$(expr index "$-" i)

if [[ $iatest -gt 0 ]]; then
  # Disable the bell
  bind "set bell-style visible"

  # Ignore case on auto-completion
  # Note: bind used instead of sticking these in .inputrc
  bind "set completion-ignore-case on"

  # Show auto-completion list automatically, without double tab
  bind "set show-all-if-ambiguous Off"
fi

source /etc/profile

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# To prevent history lines being lost if Bash terminates abnormally
unset HISTFILESIZE
HISTSIZE=10000
PROMPT_COMMAND="history -a"
export HISTSIZE PROMPT_COMMAND
shopt -s histappend
# Don't put duplicate lines in the history
export HISTCONTROL=erasedups:ignoredups

# enable custom tab completion
shopt -s progcomp

# Set colorful only on colorful terminals.
# src: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.
# We run dircolors directly due to its changes in file syntax and
# terminal name patching.
# Come from https://gitweb.gentoo.org/repo/gentoo.git/plain/app-shells/bash/files/bashrc
use_color=false
if type -P dircolors >/dev/null; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors
  LS_COLORS=
  if [[ -f ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dir_colors)"
  elif [[ -f /etc/DIR_COLORS ]]; then
    eval "$(dircolors -b /etc/DIR_COLORS)"
  else
    eval "$(dircolors -b)"
  fi
  # Note: We always evaluate the LS_COLORS setting even when it's the
  # default.  If it isn't set, then `ls` will only colorize by default
  # based on file attributes and ignore extensions (even the compiled
  # in defaults of dircolors). #583814
  if [[ -n ${LS_COLORS:+set} ]]; then
    use_color=true
  else
    # Delete it if it's empty as it's useless in that case.
    unset LS_COLORS
  fi
else
  # Some systems (e.g. BSD & embedded) don't typically come with
  # dircolors so we need to hardcode some terminals in here.
  case ${TERM} in
  [aEkx]term* | rxvt* | gnome* | konsole* | screen | cons25 | *color) use_color=true ;;
  esac
fi

# enable color support of ls and also add handy aliases
if ${use_color}; then
  alias ls='ls --color=auto -h'
  alias ll='ls -l --color=auto -h'
  alias lla='ls -la --color=auto -h'
  alias e='exa -lg --icons --group-directories-first -s name'
  alias ea='exa -lag --icons --group-directories-first -s name'
  alias eg='exa -Glg --icons --group-directories-first -s name'
  alias lsdf='ls --color=auto -lFGh1v --group-directories-first'
  alias lsdfa='ls --color=auto -lFaGh1v --group-directories-first'
  alias grep='grep --colour=auto'
  alias egrep='egrep --colour=auto'
  alias fgrep='fgrep --colour=auto'
  alias rmS='shred --force --iterations=9 --zero --remove'
  type bat &>/dev/null && {
    alias cat='bat --paging=never'
  }

  # Color for manpages in less makes manpages a little easier to read
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;31m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[01;44;33m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[01;32m'

fi

alias cp='cp -i'
alias mv='mv -i'
alias gg='git graph'
alias gg2='git graph2'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Reset
__NO_COLOR='\[\033[0m\]' # Text Reset

# Regular Colors
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
WHITE='\[\033[0;37m\]'

# Bold
B_BLACK='\[\033[1;30m\]'
B_RED='\[\033[1;31m\]'
B_GREEN='\[\033[1;32m\]'
B_YELLOW='\[\033[1;33m\]'
B_BLUE='\[\033[1;34m\]'
B_PURPLE='\[\033[1;35m\]'
B_CYAN='\[\033[1;36m\]'
B_WHITE='\[\033[1;37m\]'

# Underline
U_BLACK='\[\033[4;30m\]'
U_RED='\[\033[4;31m\]'
U_GREEN='\[\033[4;32m\]'
U_YELLOW='\[\033[4;33m\]'
U_BLUE='\[\033[4;34m\]'
U_PURPLE='\[\033[4;35m\]'
U_CYAN='\[\033[4;36m\]'
U_WHITE='\[\033[4;37m\]'

# Background
BG_BLACK='\[\033[40m\]'
BG_RED='\[\033[41m\]'
BG_GREEN='\[\033[42m\]'
BG_YELLOW='\[\033[43m\]'
BG_BLUE='\[\033[44m\]'
BG_PURPLE='\[\033[45m\]'
BG_CYAN='\[\033[46m\]'
BG_WHITE='\[\033[47m\]'

# High Intensity
HI_BLACK='\[\033[0;90m\]'
HI_RED='\[\033[0;91m\]'
HI_GREEN='\[\033[0;92m\]'
HI_YELLOW='\[\033[0;93m\]'
HI_BLUE='\[\033[0;94m\]'
HI_PURPLE='\[\033[0;95m\]'
HI_CYAN='\[\033[0;96m\]'
HI_WHITE='\[\033[0;97m\]'

# Bold High Intensity
B_HI_BLACK='\[\033[1;90m\]'
B_HI_RED='\[\033[1;91m\]'
B_HI_GREEN='\[\033[1;92m\]'
B_HI_YELLOW='\[\033[1;93m\]'
B_HI_BLUE='\[\033[1;94m\]'
B_HI_PURPLE='\[\033[1;95m\]'
B_HI_CYAN='\[\033[1;96m\]'
B_HI_WHITE='\[\033[1;97m\]'

# High Intensity background
BG_HI_BLACK='\[\033[0;100m\]'
BG_HI_RED='\[\033[0;101m\]'
BG_HI_GREEN='\[\033[0;102m\]'
BG_HI_YELLOW='\[\033[0;103m\]'
BG_HI_BLUE='\[\033[0;104m\]'
BG_HI_PURPLE='\[\033[0;105m\]'
BG_HI_CYAN='\[\033[0;106m\]'
BG_HI_WHITE='\[\033[0;107m\]'

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | *rxvt* | aterm | *screen*)
  [ -e /etc/rc/bashrc ] && . /etc/rc/bashrc
  PROMPT_COMMAND="$PROMPT_COMMAND ; [ -e ./ovyaproject.rc ] && . ./ovyaproject.rc"

  DECORATION_PROMPT_COLOR="$B_BLUE"

  PROMPT_SYMB='#'
  if [ "$(id -u)" != "0" ]; then
    USER_PROMPT_COLOR="$B_GREEN"
    PROMPT_SYMB='$'
  else
    USER_PROMPT_COLOR="$B_RED"
    DECORATION_PROMPT_COLOR="$B_WHITE"
  fi

  GIT_PROMPT_PART='$(__git_ps1 " %s")'

  OVYA_APP_PROMT_PART='$({ [ -n "$APP_NAMESPACE" ] && echo -n ${APP_NAMESPACE}; }; [ -n "${APP_ENV}" ] && echo -n /${APP_ENV})'
  [ -e /usr/lib/git-core/git-sh-prompt ] && . /usr/lib/git-core/git-sh-prompt &&
    PS1="${debian_chroot:+($debian_chroot)}${DECORATION_PROMPT_COLOR}[${USER_PROMPT_COLOR}\u@\h \W ${B_YELLOW}${OVYA_APP_PROMT_PART}${WHITE}${GIT_PROMPT_PART}${DECORATION_PROMPT_COLOR}]$PROMPT_SYMB${__NO_COLOR} "

  PS2='> '
  PS4='+ '

  ;;
*) ;;
esac

export EDITOR=emacsclient
export ALTERNATE_EDITOR=nano

unset LANG LC_MESSAGES
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="$LC_ALL"
export LESSCHARSET="utf-8"
export TIME_STYLE="long-iso"
export TZ="Europe/Paris"
export PERL_UTF8_LOCALE=1 PERL_UNICODE=AS
export LC_MEASUREMENT="fr_FR.UTF-8"
export LC_PAPER="fr_FR.UTF-8"
export LC_MONETARY="fr_FR.UTF-8"

export PATH=$PATH:/opt/emacs/bin/:${JAVA_HOME}/bin:${HOME}/bin:${HOME}/.local/bin:${HOME}/bin/go
export NODE_DISABLE_COLORS=1

type direnv &>/dev/null && eval "$(direnv hook bash)"
type golangci-lint &>/dev/null && eval "$(golangci-lint completion bash)"

export NODE_OPTIONS="--max_old_space_size=8096"

# Load Angular CLI autocompletion.
type ng &>/dev/null && source <(ng completion script)
# Load npm autocompletion.
type npm &>/dev/null && source <(npm completion)

SOURCE_FILES="/home/{{ default_user }}/.deno/env
/usr/local/etc/bash_completion.d/deno.bash
/usr/share/powerline/bindings/bash/powerline.sh
$HOME/.cargo/env
$HOME/vendor/bashmarks/bashmarks.sh
$HOME/vendor/go_completion
"

for file in $SOURCE_FILES; do
  [ -e "$file" ] && source "$file"
done
