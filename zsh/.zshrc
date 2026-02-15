# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# autoload -U add-zsh-hook

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Should speed up NVIM startup
#
# @see https://stackoverflow.com/questions/62499268/zsh-shell-taking-abnormally-long-time-during-initial-startup
#
# alternative  approach: 
# ```bash
#
# [[ $UID = 0 || -n $SUDO_USER ]] && compinit -u || compinit
# ```
[[ $UID = 0 || -n $SUDO_USER ]] && compinit -u || compinit

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

####################
# Node Version manager (nvm)
# 
# In order to speed up Zsh, I am disabling the default 
# lines added by `nvm` and using lazy loading
#
# @see https://aronschueler.de/blog/2021/12/10/fix-slow-zsh-startup-nvm/
####################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# source ~/lazy-nvm.sh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux)

ZSH_TMUX_AUTOSTART=true

if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
	source $ZSH/oh-my-zsh.sh
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='nvim'
# else
#   export EDITOR='nvim'
# fi
#
# Compilation flags
export ARCHFLAGS="-arch x86_64"

export CC=clang

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Java SDK
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Gradle -- let gradle builds utilize local gradle installation rather than downloading one everytime
export GRADLE_USER_HOME=$GRADLE_HOME

# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Go SDK
export PATH=$PATH:/usr/local/go/bin

# My local scripts folder
export PATH="$PATH":"$HOME/.local/scripts/"

alias vi='nvim'

# Quick project workspace navigator with Tmux sessionizer (ctrl+f)
bindkey -s ^f "tmux-sess-man\n"

# launch up tmux cheatseets using alt+f
bindkey -s ^\[f "tmux-cht-sh\n"

# PNPM
export PNPMPATH="$HOME/.pnpm-global/bin"
alias pn='pnpm'

# Npx but uses PNPM
alias pnx="npm_execpath=$(which pnpm) npx"

# Add PNPM to PATH
export PATH="$PNPMPATH:$PATH"

# Add `user scripts` to PATH
export PATH="$HOME/.local/bin:$PATH"


# load project-specific node version if it exists
# otherwise, load the default version
#
# This function is called in the `chpwd` hook
# load_nvmrc() {
#     local nvmpath
#     nvmpath=$(nvm_find_nvmrc)
#
#     if [ -n "$nvmpath" ]; then
#         local node_version
#         node_version=$(nvm version "$(cat "${nvmpath}")")
#
#         if [ -n "$node_version" = "N/A" ]; then
#             echo "Node version '$(cat "${nvmpath}")' not found in nvm"
#             echo "Installing it..."
#             nvm install
#         elif [ "$node_version" != "$(nvm current)" ]; then
#             nvm use
#         fi
#     elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
#         echo "Reverting to nvm default version"
#         nvm use default
#     fi
# }

####################

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Rust
#. "$HOME/.cargo/env"

## QC

alias lintqc='black --line-length 120 --skip-string-normalization src tests'
alias isortqc='isort --atomic --profile black -c src'

# SpringBoot Completion
# . ~/.sdkman/candidates/springboot/current/shell-completion/bash/spring

# Docker BuildKit
export DOCKER_BUILDKIT=1

# Pub Cache
# export PATH="$PATH":"$HOME/.pub-cache/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/erioluwa/google-cloud-sdk/path.zsh.inc' ]; then . '/home/erioluwa/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/erioluwa/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/erioluwa/google-cloud-sdk/completion.zsh.inc'; fi

# Go
GOBINPATH=$HOME/go/bin
export PATH=$PATH:$GOBINPATH

# Jira
export JIRA_API_TOKEN=ATATT3xFfGF0yaqh-Mzgh7KlSJAhrT9sKGoRLVl09a7HbepJH4k0II4ftYplr9GRoqPlVxDY-gbwhNUypsBKug4bqOGRQ7ZqviJpo9fXcsUUgx-cOoBLle9ekkLK6UnTPMO4b02cmEFpvMDaa9eYuSY1wja3Iib8YCipanu5pmMK76CGPXVYQ54=14FD4D24

# pnpm
export PNPM_HOME="/home/erioluwa/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Emacs
# export PATH="$HOME/.emacs.d/bin:$PATH"
# export PATH=/usr/share/swift/usr/bin:/usr/share/swift/usr/bin:/home/erioluwa/.emacs.d/bin:/home/erioluwa/.local/share/pnpm:/home/erioluwa/google-cloud-sdk/bin:/home/erioluwa/.pyenv/plugins/pyenv-virtualenv/shims:/home/erioluwa/.cargo/bin:/home/erioluwa/.poetry/bin:/home/erioluwa/.pyenv/shims:/home/erioluwa/.pyenv/bin:/home/erioluwa/.local/bin:/home/erioluwa/.pnpm-global/bin:/home/erioluwa/.sdkman/candidates/springboot/current/bin:/home/erioluwa/.sdkman/candidates/maven/current/bin:/home/erioluwa/.sdkman/candidates/java/current/bin:/home/erioluwa/.sdkman/candidates/gradle/current/bin:/home/erioluwa/.nvm/versions/node/v21.5.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/erioluwa/Android/Sdk/emulator:/home/erioluwa/Android/Sdk/platform-tools:/home/erioluwa/.fzf/bin:/usr/local/go/bin:/home/erioluwa/.local/scripts/:/home/erioluwa/.pub-cache/bin:/home/erioluwa/go/bin

# Erlang/OTP/Elixir
# export PATH=$HOME/.elixir-install/installs/otp/27.2.3/bin:$PATH
# export PATH=$HOME/.elixir-install/installs/elixir/1.18.3-otp-27/bin:$PATH

# completion for my cheatsheet script
fpath=(~/.zsh.d/ $fpath)

# nvm use --lts > /dev/null 2>&1

# FVM
# export PATH="/home/erioluwa/.fvm_flutter/bin:$PATH"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/erioluwa/.dart-cli-completion/zsh-config.zsh ]] && . /home/erioluwa/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# Flutter
# export PATH="$HOME/development/flutter/bin:$PATH"

# prometheus multiproc dir
export PROMETHEUS_MULTIPROC_DIR="/tmp/prometheus"

# working with demo testing branch of QC bills payment on VPS
alias mount-qc-vps='sshfs myvps:/home/eri/qccore ~/vps_qc -o auto_cache,reconnect,follow_symlinks'

# PORT
export ROBOT_NAME="robot\$ocean-integration"
export ROBOT_TOKEN="RfiYkY2l3zUTSIEf6FQyPcKwAoVLy2ci"
