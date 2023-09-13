# commands and functions for personal optimal productivty

alias gw='git worktree '
alias gwa='git worktree add'
alias gb='git branch -a'
alias gc='git clone'
alias gco='git checkout'
alias gcm='git commit -m'
alias ga='git add'
alias gaA='git add -A'
alias gp='git push'
alias gpl='git pull origin --depth 1'
alias gst='git status'
alias g='git'
alias d='docker'
alias dc='docker compose'


mdm() {
    if [[ ! -z $1 ]]; then
        mkdir -p $1 && cd $1
    fi

}

log() {
    git log --oneline --graph main
}
