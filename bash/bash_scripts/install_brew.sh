#!/usr/bin/env bash

print_logo() {
cat <<'EOF'

  ______           _       ____              __
 /_  __/___ ______(_)___ _/ __ )____ _____ _/ /____  _____
  / / / __ `/ ___/ / __ `/ __  / __ `/ __ `/ __/ _ \/ ___/
 / / / /_/ / /  / / /_/ / /_/ / /_/ / /_/ / /_/  __/ /       MacOS Setup Script
/_/  \__,_/_/  /_/\__, /_____/\__,_/\__,_/\__/\___/_/        by: Tariq Baater
                    /_/

EOF
}
# This script installs Homebrew packages from a file named "brew_list".
# It reads the file line-by-line and installs each package if it's not already installed.


clear
print_logo

# check the OS type
if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script is intended for macOS only. Exiting..."
    exit 1
fi

# Exit on error, undefined variable, or pipe failure
set -euo pipefail

# list of brew packages to install
BREW_LIST_FILE="brew_list"
# Dotfiles repository URL (update this URL accordingly)
DOTFILES_REPO_URL="https://github.com/tariqbaater/dotfiles.git"
# Target directory for dotfiles, within the .config directory
DOTFILES_DIR="$HOME/.config/dotfiles"

# Check if the brew_list file exists
echo "Checking if $BREW_LIST_FILE exists..."
if [[ ! -f "$BREW_LIST_FILE" ]]; then
    echo "Error: $BREW_LIST_FILE does not exist. Please create the file with a list of brew packages to install."
    exit 1
fi

# Check if Homebrew is installed
echo "Checking if Homebrew is installed..."
if ! command -v brew >/dev/null 2>&1; then
    echo "Error: Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Read the brew_list file line-by-line
echo "Do you want to install the packages? This will take a while... (y/n)"
read -r answer

if [[ "$answer" != "y" ]]; then
    echo "Exiting..."
    exit 0
fi


echo "Installing brew packages..."
while IFS= read -r package || [[ -n "$package" ]]; do
    # Skip empty lines and comments (# at the beginning)
    if [[ -z "$package" || "$package" =~ ^# ]]; then
        continue
    fi
    # Check if the package is already installed
    if ! brew list "$package" >/dev/null 2>&1; then
        echo "Installing $package..."
        brew install "$package"
    else
        echo "$package is already installed."
    fi
done < "$BREW_LIST_FILE"

echo "Finished installing brew packages."


echo "Pulling dotfiles repository..."

# Create .config directory if it doesn't exist
echo "Checking if .config directory exists..."
if [[ ! -d "$HOME/.config" ]]; then
    echo "Creating .config directory..."
    mkdir -p "$HOME/.config"
fi

# Clone dotfiles repository if it doesn't exist, else pull latest changes
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
else
    echo "Dotfiles repository already exists. Pulling latest changes..."
    cd "$DOTFILES_DIR" && git pull
fi

echo "Enjoy your new setup!"
return 0





























