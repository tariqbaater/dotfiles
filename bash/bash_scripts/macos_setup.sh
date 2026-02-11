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
BREW_LIST_FILE="$HOME/.dotfiles/bash/bash_scripts/brew_list"
# Dotfiles repository URL (update this URL accordingly)
DOTFILES_REPO_URL="https://github.com/tariqbaater/dotfiles.git"
# Target directory for dotfiles, within the .config directory
DOTFILES_DIR="$HOME/.dotfiles"

# Check if Homebrew is installed
echo "Checking if Homebrew is installed..."
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "Homebrew installed successfully."
else
  echo "Homebrew is already installed."
fi

# Ask the user if they want to set up Git with SSH for private repos
read -p "Do you want to set up Git with SSH for private repos? (y/n): " SETUP_GIT

if [[ "$SETUP_GIT" != "y" ]]; then
  echo "Skipping Git SSH setup."
  echo "Exiting..."
  exit 0
else
  # Check if Git is installed
if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Installing Git..."
    brew install git
    echo "Git installed successfully."
  else
    echo "Git is already installed."
  fi
fi

# Ask for git identity (name and email) to set up Git configuration
read -p "Enter your Git name: " GIT_NAME
read -p "Enter your Git email: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Check if SSH keys already exist and if not, generate a new SSH key pair
SSH_KEY="$HOME/.ssh/id_ed25519"

if [[ -f "$SSH_KEY" ]]; then
  echo "SSH key already exists at $SSH_KEY"
else
  ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY"
fi

# Add to ssh-agent + macOS Keychain
eval "$(ssh-agent -s)"

ssh-add --apple-use-keychain "$SSH_KEY"

# Ensure the above is appended to the ssh config file
if ! grep -q "UseKeychain" ~/.ssh/config 2>/dev/null; then
  cat <<EOF >> ~/.ssh/config

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
fi

# Display the public key and prompt the user to add it to their GitHub account
echo ""
echo "Copy this SSH key and add it to GitHub:"
echo "---------------------------------------------"
cat "${SSH_KEY}.pub"
echo "---------------------------------------------"
pbcopy < "${SSH_KEY}.pub"
echo "SSH key already copied to clipboard."

read -p "Press Enter after you've added the SSH key to GitHub..."
# # Test the SSH connection to GitHub
# ssh -T git@github.com
# exit 0
echo ""
echo "Git SSH setup completed successfully."

# Pull the latest changes from the dotfiles repository first, as it may contain updates to the
# brew_list file
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
    git clone --depth=5 "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
else
    echo "Dotfiles repository already exists. Pulling latest changes..."
    cd "$DOTFILES_DIR" && git pull
fi

# Check if the brew_list file exists
echo "Checking if $BREW_LIST_FILE exists..."
if [[ ! -f "$BREW_LIST_FILE" ]]; then
    echo "Error: $BREW_LIST_FILE not found. Please ensure the brew_list file exists in the correct location."
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

# stow dotfiles using GNU Stow
echo "Stowing dotfiles..."
# Check if stow is installed
if ! command -v stow >/dev/null 2>&1; then
    echo "Error: GNU Stow is not installed. Please install stow first."
    exit 1
fi
cd "$DOTFILES_DIR"
# Stow all directories in the dotfiles repository
for dir in */; do
    stow -v --target="$HOME" "$dir"
done

echo "Enjoy your new setup!"
return 0
