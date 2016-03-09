# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

if [ -d /usr/local/src/git ] ; then
    source /usr/local/src/git/contrib/completion/git-completion.bash
    source /usr/local/src/git/contrib/completion/git-prompt.sh

    # プロンプトに各種情報を表示
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUPSTREAM=1
    GIT_PS1_SHOWUNTRACKEDFILES=
    GIT_PS1_SHOWSTASHSTATE=1

    PS1='\[\033[1;34m\]\u\[\033[0m\] at \[\033[1;34m\]\H\[\033[0m\] \[\033[1;32m\]\w\[\033[0m\] \[\033[33m\]\[\033[1;34m\]$(__git_ps1 "git:(\[\033[1;31m\]%s\[\033[1;34m\])")\[\033[00m\]\n\$ '
else
    PS1='\[\033[1;34m\]\u\[\033[0m\] at \[\033[1;34m\]\H\[\033[0m\] \[\033[1;32m\]\w\[\033[0m\]\n\$ '
fi
