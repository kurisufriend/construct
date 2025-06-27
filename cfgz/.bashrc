#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


function nonzero_return() {
	RETVAL=$?
	echo "$RETVAL"
}

export PS1="[\[\e[31m\]\`nonzero_return\`\[\e[m\]] \[\e[33;40m\]\u\[\e[m\]\[\e[37;40m\]@\[\e[m\]\[\e[36;40m\]\h\[\e[m\]:\w\\$ "
#export PS1="\[\e[33;40m\]\u\[\e[m\]\[\e[37;40m\]@\[\e[m\]\[\e[36;40m\]\h\[\e[m\]:\w\\$ "


alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PATH=~/.local/bin:$PATH

export EDITOR="nano"

insanity() {
    while true
    do
        "$@"
        if [ $? -eq 0 ]; then
            return 0
        fi
        sleep 1
    done
}

# k8s

## krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

## woovit k8s
alias wuvt_k8s_old='export HTTPS_PROXY="socks5://127.0.0.1:8081" && kubectl --kubeconfig ~/.kube/wuvt_oldcluster'
alias wuvt_k8s_new='export HTTPS_PROXY="socks5://127.0.0.1:8081" && kubectl --kubeconfig ~/.kube/wuvt_newcluster'
alias wuvt_tacoman_http_proxy='ssh -L 8888:localhost:8888 ladmin@tacomanarrows.wuvt.vt.edu'
alias wuvt_tacoman_socks_proxy='ssh -D 8081 ladmin@tacomanarrows.wuvt.vt.edu'

# rsk
## unlock sudo
alias rsk_unlocksudo='faillock --user rishi --reset'
alias rsk_irc='ssh ircuser@nano.cynic.moe'
alias nano='nano -T 4 -S -k -l -i'
