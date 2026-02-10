#!/bin/bash

BREW="/opt/homebrew/bin/brew"

echo "=== Outdated Packages ==="
$BREW outdated
echo ""
echo "=== Updating Homebrew ==="
$BREW update
echo ""
echo "=== Upgrading Packages ==="
$BREW upgrade
echo ""
echo "Done! You can close this window."
exec bash
