if [ -f /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash ] ; then
    source /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash
    PS1='\[\033[1;34m\]\u\[\033[0m\] at \[\033[1;34m\]\H\[\033[0m\] \[\033[1;32m\]\w\[\033[0m\] \[\033[33m\]$(__git_ps1 "git:(%s)")\[\033[00m\]
\$ '
else
    PS1='\[\033[1;34m\]\u\[\033[0m\] at \[\033[1;34m\]\H\[\033[0m\] \[\033[1;32m\]\w\[\033[0m\]
\$ '
fi
