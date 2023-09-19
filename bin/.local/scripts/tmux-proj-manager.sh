#!/bin/bash

# Opens a new project in vim from the command line
# 
# If, project directory is a git directory, open a new named session with new window 
# containing the project, otherwise open a new window in the current session
# 
# Licensed under the MIT License by @codemage (Eri)


# if fzf is not installed, just inform me and jump out of this script
if ! command -v fzf &>/dev/null; then
    echo "Fzf is not installed on this machine dude, reinstall your dotfiles"

    exit -1;
fi


