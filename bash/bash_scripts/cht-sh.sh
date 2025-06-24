#!/bin/bash

# This script is used to run the cht.sh command with the provided arguments.
# It checks if the command is available and then executes it with the given parameters.
# Usage: ./cht-sh.sh [options] [query]
# # Example: ./cht-sh.sh -s python "list comprehensions"
URL="https://cht.sh"

languages=()

# read from cht-sht-lists.txt

while IFS= read -r line; do
    languages+=("$line")
done < /Users/tariq/bash_scripts/cht-sht-lists.txt

# use fzf to select a language
selected_language=$(printf "%s\n" "${languages[@]}" | fzf --height 40% --border --prompt "Select a language: ")
if [ -z "$selected_language" ]; then
    echo "No language selected. Exiting."
    exit 1
fi
# if the user selects a language, run curl with the selected language and the provided arguments
curl -s "$URL/$selected_language" | less -R
if [ $? -ne 0 ]; then
    echo "Error: cht.sh command failed."
    exit 1
fi


