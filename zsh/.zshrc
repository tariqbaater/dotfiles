# claude-code
export ANTHROPIC_AUTH_TOKEN=o1lama
export ANTHROPIC_BASE_URL=http://100.92.119.107:11434

# flutter sdk path
export PATH="$HOME/Projects/flutter_app/flutter/bin:$PATH"

# bash settings
export PS4=$'\e[31m[debug]\e[0m ' # include timestamp in debug output with red color

# User Settings
source ~/.dotfiles/zsh/.zshrcu

# Global secret variables
source ~/.env

# copilot settings
# eval "$(gh copilot alias -- zsh)"

# add custom bin directory to PATH
export PATH="/opt/homebrew/bin:$PATH"

#homebrew command-not-found
HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
  source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER";
fi
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# custom oh-my-zsh prompt
# PROMPT='%n@%m %~ %# '
# Oh-my-zsh settings
ZSH_THEME="robbyrussell"
# plugins=(git zsh-autosuggestions grc colorize zsh-syntax-highlighting web-search tmux aliases vi-mode themes copypath copyfile tmux)
ZSH_COLORIZE_STYLE="monokai"
ZSH_TMUX_AUTOSTART=true


source $ZSH/oh-my-zsh.sh

logos=(
 "Aisaka"
 "Geass"
 "Link-green"
 "Loli"
 "Pochita"
 "Ryuzaki"
 "agk clan"
 "chelsea"

  )
# Select a random logo
random_logo="${logos[RANDOM % ${#logos[@]} + 1]}"
# Set the logo variable
fastfetch --logo ~/.config/fastfetch/images/"$random_logo".png

# End of lines added by compinstall
autoload -Uz compinit
compinit

# fzf settings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh
# override fzf default command
export FZF_DEFAULT_COMMAND='find .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:$HOME/go/bin

#tmux settings
export LC_ALL=en_US.UTF-8   export LANG=en_US.UTF-8
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"

#zoxide settings
eval "$(zoxide init zsh --cmd cd)"

# yazi settings
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH="/opt/homebrew/sbin:$PATH"


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
#zinit light zsh-users/zsh-completions
#zinit light Aloxaf/fzf-tab
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

#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' menu no
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
## The following lines have been added by Docker Desktop to enable Docker CLI completions.
#fpath=(/Users/tariq/.docker/completions $fpath)
#autoload -Uz compinit
#compinit
# End of Docker CLI completions

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/tariq/.lmstudio/bin"
# End of LM Studio CLI section


# Added by Antigravity
export PATH="/Users/tariq/.antigravity/antigravity/bin:$PATH"

# Added by MiniMax Agent
export PATH="/Users/tariq/.mavis/bin:$PATH"
eval "$(atuin init zsh)"
