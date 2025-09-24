# commands and functions for personal optimal productivty

# alias flutter="fvm flutter"
# alias dart="fvm dart"
alias spacelink='./vpn/vpn.sh'
alias v='nvim'
alias gw='git worktree '
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias gb='git branch'
alias gc='git clone'
alias gco='git checkout'
alias gcm='git commit -m'
alias ga='git add'
alias gaA='git add -A'
alias gp='git push'
alias qc='cd ~/konohagakure/qccore/'
alias gpl='git pull --depth 1'
alias gst='git status'
alias g='git'
alias d='docker'
alias dc='docker compose'
alias j='java'
alias gcca='gcloud config configurations activate'
alias handees="cd ~/forks/handees/mobile"
alias gpr='git pull --rebase'
alias runserver='python manage.py runserver'
alias rplus='python manage.py runserver_plus'
alias migrate='python manage.py migrate'
alias makemigrations='python manage.py makemigrations'
alias wamiri="cd ~/projects/akatsuki/wamiri/"
alias wamiriweb="cd ~/projects/akatsuki/wamiri/Alkebulan/"
alias wamiribackend="cd ~/projects/akatsuki/wamiri/alkebulan-backend/"

# change directory into my dotfiles directory at the speed of light
alias dots='cd ~/.dotfiles'

# make new directory for me
# doesn't  matter if the subdirectory exists or not
mdm() {
	if [[ ! -z $1 ]]; then
		mkdir -p $1 && cd $1
	fi

}

log() {
	case "$1" in
	"")
		# If no argument is passed, then show the log between the current branch and the remote branch
		git log $(git rev-parse --abbrev-ref @{upstream})\..HEAD --oneline --graph --decorate --color=always
		;;
	"count")
		# If passed argument is count, then show the number of commits since the last pull
		# ref: https://stackoverflow.com/questions/3258243/git-how-to-find-out-if-there-have-been-any-changes-since-my-last-pull
		git log $(git rev-parse --abbrev-ref @{upstream})\..HEAD --oneline --graph --count
		;;
	"file")
		shift
		git log -1 --oneline --name-status --follow -- "$@"
		;;
	"tags")
		shift
		git log "$1".."$2" # show me the log between two release tags
		;;
	*)
		# write me a short documentation
		echo "Usage: log [count|file|tags]"
		echo """

        count: show the number of commits since the last pull
        file: show the log of a file
        tags: show the log between two release tags
        """

		;;
	esac
}

# Realias GitLab to reduce the long command output
gl() {
	glab $@ | head -n 35
}

# Git bisect alias
# ref: https://stackoverflow.com/questions/4713010/how-to-use-git-bisect
gbisect() {

	case "$1" in
	"start")
		git bisect start
		;;
	"bad")
		git bisect bad
		;;
	"good")
		git bisect good
		;;
	"reset")
		git bisect reset
		;;
	"auto")
		git bisect start
		git bisect bad
		git bisect good $(git describe --tags --abbrev=0)
		;;
	*)
		echo "Usage: gbisect [start|bad|good|reset|auto]"
		;;
	esac
}
