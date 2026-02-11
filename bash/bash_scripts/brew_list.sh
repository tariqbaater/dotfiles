#!/bin/bash
brew list --formula > /Users/tariq/bash_scripts/brew_list
# append "--cask" to the cask list and append it to the brew_list file
brew list --cask | sed 's/^/--cask /' >> /Users/tariq/bash_scripts/brew_list
