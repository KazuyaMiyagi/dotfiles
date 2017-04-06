# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
MAGENTA="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
WHITE="\[\e[0;37m\]"
BOLD_BLACK="\[\e[1;30m\]"
BOLD_RED="\[\e[1;31m\]"
BOLD_GREEN="\[\e[1;32m\]"
BOLD_YELLOW="\[\e[1;33m\]"
BOLD_BLUE="\[\e[1;34m\]"
BOLD_MAGENTA="\[\e[1;35m\]"
BOLD_CYAN="\[\e[1;36m\]"
BOLD_WHITE="\[\e[1;37m\]"
RESET="\[\e[0m\]"

if [ $(id -u) -eq 0 ] ; then
    USER_COLOR=$BOLD_RED
else
    USER_COLOR=$WHIE
fi

GROUP="LOCAL"
GROUP_COLOR=$BOLD_BLUE
GIT_COLOR=$BOLD_MAGENTA

if [ -d /usr/local/src/git ] ; then
    source /usr/local/src/git/contrib/completion/git-completion.bash
    source /usr/local/src/git/contrib/completion/git-prompt.sh

    # プロンプトに各種情報を表示
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUPSTREAM=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWSTASHSTATE=1

    PROMPT_COMMAND="__git_ps1 '[${USER_COLOR}\u${RESET}@\H(${GROUP_COLOR}${GROUP}${RESET}) \w]' '\n\$ ' ' ${GIT_COLOR}git:(%s)${RESET}'"
else
    PS1="[${USER_COLOR}\u${RESET}@\H(${GROUP_COLOR}${GROUP}${RESET}) \w]\n\$ "
fi
