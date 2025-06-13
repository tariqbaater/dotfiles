#!/usr/bin/env bash

print_logo() {
  cat <<EOF

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

set -euo pipefail

BREW_LIST_FILE="brew_list"

# Check if the brew_list file exists
if [[ ! -f "$BREW_LIST_FILE" ]]; then
    echo "Error: $BREW_LIST_FILE does not exist. Please create the file with a list of brew packages to install."
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    echo "Error: Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Read the brew_list file line-by-line
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


# Pull dotfiles from GitHub
echo "Finished installing brew packages."
echo "Pulling dotfiles repository..."


# Dotfiles repository URL (update this URL accordingly)
DOTFILES_REPO_URL="https://github.com/tariqbaater/dotfiles.git"
# Target directory for dotfiles, within the .config directory
DOTFILES_DIR="$HOME/.config/dotfiles"

# Create .config directory if it doesn't exist
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





























