# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

CASE_SENSITIVE='false'
HYPHEN_INSENSITIVE='false'

# Commands starting from " " (whitespace) won't be saved in history:
HIST_IGNORE_SPACE='true'

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  git-flow
  nvm
)

source $ZSH/oh-my-zsh.sh
source "$HOME/.aliases"

# export ANDROID_HOME=$HOME/Library/Android/sdk && export PATH=$PATH:$ANDROID_HOME/emulator && export PATH=$PATH:$ANDROID_HOME/platform-tools
# export JAVA_HOME=$(/usr/libexec/java_home)
# export PATH="$HOME/bin:$PATH"

export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

bindkey -s '^Z' 'fg\n'

# fpath=(~/_git-flow $fpath)
# fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# source $ZSH/oh-my-zsh.sh

