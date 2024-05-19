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
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# these lazily load nvm before your node commands
nvm_lazy_load() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    load-nvmrc
}
nvm() {
    nvm_lazy_load
    nvm $@
}
node() {
    nvm_lazy_load
    node $@
}
npm() {
    nvm_lazy_load
    npm $@
}
npx() {
    nvm_lazy_load
    npx $@
}

autoload -U add-zsh-hook

# this loads nvmrc when a file exists, and finds the path of the nvmrc file itself
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path=""
  local dir="$PWD"

  # Look for .nvmrc file in current directory and parent directories
  while [[ "$dir" != "" && ! -e "$dir/.nvmrc" ]]; do
    dir="${dir%/*}"
  done

  # If .nvmrc file was found, set nvmrc_path
  if [[ -e "$dir/.nvmrc" ]]; then
    nvmrc_path="$dir/.nvmrc"
  fi

  if [ -n "$nvmrc_path" ]; then
    echo "Found $nvmrc_path, switching to node $(cat "${nvmrc_path}")"
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

# this is ran on every directory, and checks if an nvmrc file exists (parent or child) first
trigger-nvm() {
  if [[ -n $(find . -maxdepth 2 -name '*.nvmrc' -type f -print -quit) || -f ../.nvmrc || -f ../../.nvmrc || -f ../../../.nvmrc ]]; then 
    nvm_lazy_load
    load-nvmrc
  fi
}

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions tmux)

ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

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
# export ARCHFLAGS="-arch x86_64"

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
PATH="$PATH":"$HOME/.local/scripts/"

alias vi='nvim'

# Quick project workspace navigator with Tmux sessionizer
bindkey -s ^f "tmux-sess-man\n"

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
. "$HOME/.cargo/env"
# Python
eval "$(pyenv virtualenv-init -)"

# SpringBoot Completion
. ~/.sdkman/candidates/springboot/current/shell-completion/bash/spring

# Docker BuildKit
DOCKER_BUILDKIT=1

# Pub Cache
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Custo hooks
add-zsh-hook chpwd trigger-nvm
