#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ~/bash_scripts/say.sh "Welcome Welcome back Tariq Abubakar"
# neofetch
 # zmodload zsh/zprof # uncomment to profile startup time
#toilet "tariqbaater" -F metal -F border
# for displaying a logo during terminal start up
# figlet -f script "tariq" | lolcat

# echo "Remaining balance:"
# mysql -e "USE finances; SELECT * FROM asset_payments;" | tail -n +2 | awk '{sum += $3} END {result = (3500000) - sum; printf "%'\''d\n", result}'

export PATH="/opt/homebrew/bin:$PATH"


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#homebrew command-not-found
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Oh-my-zsh settings
ZSH_THEME="robbyrussell"
# plugins=(git zsh-autosuggestions grc colorize zsh-syntax-highlighting web-search tmux aliases vi-mode themes copypath copyfile tmux)
ZSH_COLORIZE_STYLE="monokai"
# ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh



# User configuration

# aliases
alias arc='open -a "Arc"'
alias raycast='open -a "Raycast"'
alias vpn='open -a "OpenVPN Connect"'
alias expai='open raycast://ai-commands/explain-ai'
alias search="~/bash_scripts/google.sh"
alias icat="kitten icat"
alias c='clear'
alias la='eza -lah'
alias ll='eza -la'
alias ls='eza'
alias tree='eza --tree'
alias nz='vi ~/.zshrc'
alias sz='source ~/.zshrc'
alias st='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3'
alias vi='nvim'
alias vim='nvim'
alias sar='curl -s https://api.exchangerate-api.com/v4/latest/SAR | jq '.rates.KES''
alias usd='curl -s https://api.exchangerate-api.com/v4/latest/USD | jq '.rates.KES''
alias gbp='curl -s https://api.exchangerate-api.com/v4/latest/GBP | jq '.rates.SAR''
alias myip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"                                                   ─╯
alias ip="echo $(ifconfig | grep broadcast | awk '{print $2}')" # use the $(command) to escape stdout issues
alias cd='z'
alias gb='git branch'
alias rm='trash'
alias what-i-got='compgen -c | fzf | xargs -I {} {}'
alias zellij='zsh <(curl -L zellij.dev/launch) '
# Mac setup for pomo
alias work="timer 60m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"
# Search for uses of linux commands
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias fman='compgen -c | fzf | xargs man'
# Search a file with fzf and open it using neovim
alias vifzf='vi $(fzf -m --preview "bat --style=numbers --color=always --line-range :500 {}")'

# man page in vim
export MANPAGER='nvim +Man!'

# nvim configuration picker
alias nvim-lazy='NVIM_APPNAME=LazyVim nvim'
alias nvim-astro='NVIM_APPNAME=AstroNvim nvim'
alias nvim-chad='NVIM_APPNAME=nvchad nvim'
# alias nvim-default='NVIM_APPNAME=kickstart nvim'
# alias functions

#nvim picker function
function nvims() {
  items=("default" "LazyVim" "AstroNvim" "nvchad")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Nvim Config → " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a 'nvims\n'

# git
function gcap() {
  git add . && git commit -m "$1" && git push -f origin main
}

# git commit picker
function gcop() {
    git log \
        --reverse \
        --color=always \
        --format="%C(cyan)%h %C(blue)%ar%C(auto)%d %C(yellow)%s%+b %C(black)%ae" "$@" |
    fzf -i -e +s \
        --reverse \
        --tiebreak=index \
        --no-multi \
        --ansi \
        --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'" \
        --header "Press Enter to view, Ctrl+C to copy hash" \
        --bind "ctrl-x:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xclip -r -selection clipboard)"
}

# quick notes
function note() {
    echo "*$(date)*" >> "$HOME/iCloud/notes/quick_notes.md"
    echo ": $@" | base64 >> "$HOME/iCloud/notes/quick_notes.md"
    echo "\n" >> "$HOME/iCloud/notes/quick_notes.md"
    vi "$HOME/iCloud/notes/quick_notes.md"

}
# Promo project
function promo() {
    # execute a bash script ~/bash_scripts/promo-checker.sh
    ~/bash_scripts/promo-checker.sh "$@"
}

# MAC reminder
function reminder() {
    # execute a bash script ~/bash_scripts/reminder.sh
    ~/bash_scripts/reminder.sh "$@"

}

# Password Generator
function passgen() {
    ~/bash_scripts/passGen.sh "$@"
}

# End of lines added by compinstall
autoload -Uz compinit
compinit

# fzf settings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh
# override fzf default command
export FZF_DEFAULT_COMMAND='find .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#tmux settings
export LC_ALL=en_US.UTF-8   export LANG=en_US.UTF-8
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"

#zoxide settings
eval "$(zoxide init zsh)"

#
# timezsh() {
#   shell=${1-$SHELL}
#   for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
# }
#
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export PATH=$PATH:$HOME/go/bin

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH="/opt/homebrew/sbin:$PATH"


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/tariq/Library/Application Support/Herd/config/php/83/"


# Herd injected NVM configuration
export NVM_DIR="/Users/tariq/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP binary.
export PATH="/Users/tariq/Library/Application Support/Herd/bin/":$PATH

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
#
# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode
zinit load zpm-zsh/colorize

# ZSH Basic Options
######################################################

setopt autocd #change to directory by typing it's name 
setopt correct #auto correct mistakes
setopt interactivecomments #allow comments in interactive mode 
setopt magicequalsubst #enable filename expansion for arguments of the form ‘argument=value’
setopt nonomatch #hide error message if there are no matches for expansion 
setopt notify #report the status of background jobs immediately
setopt numericglobsort #sort filenames numerically when it makes sense
setopt promptsubst #enable parameter expansion, backslash substitution, and command substitution in prompts 

# ZSH History Options
######################################################

HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_dups

# ZSH Completion Options
######################################################

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
