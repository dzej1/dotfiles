# This below is to automate the process of creating the
# com.linkarzu.autoPushGithub.plist file which will run every X seconds and
# automaticaly push changes to some github repos
#
# Check if the com.linkarzu.autoPushGithub.plist file exists, create it if missing
PLIST_PATH="$HOME/Library/LaunchAgents/com.linkarzu.autoPushGithub.plist"
SCRIPT_PATH="$HOME/github/dotfiles-latest/scripts/macos/mac/400-autoPushGithub.sh"

# NOTE: If you modify the StartInterval below, make sure to also change it in
# the ~/github/dotfiles-latest/scripts/macos/mac/400-autoPushGithub.sh script
if [ ! -f "$PLIST_PATH" ]; then
  echo "Creating $PLIST_PATH..."
  cat <<EOF >"$PLIST_PATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.linkarzu.autoPushGithub</string>
    <key>ProgramArguments</key>
    <array>
        <string>$SCRIPT_PATH</string>
    </array>
    <key>StartInterval</key>
    <integer>180</integer>
    <key>StandardOutPath</key>
    <string>/tmp/autoPushGithub.out</string>
    <key>StandardErrorPath</key>
    <string>/tmp/autoPushGithub.err</string>
</dict>
</plist>
EOF
  echo "Created $PLIST_PATH."
fi

# Check if the plist file is loaded, and load it if not
# If you want to verify manually if running, run
# launchctl list | grep -i autopush
# First column (-) means the job is NOT currently running. Normal as our script runs every X seconds
# Second Column (0) means the job ran successfully the last execution, other values mean error
if ! launchctl list | grep -q "com.linkarzu.autoPushGithub"; then
  echo "Loading $PLIST_PATH..."
  launchctl load "$PLIST_PATH"
  echo "$PLIST_PATH loaded."
fi

# Automate tmux session cleanup every X hours using a LaunchAgent
# This will create plist file to run the script every X hours
# and log output/errors to /tmp/$PLIST_LABEL.out and /tmp/$PLIST_LABEL.err
# NOTE: If you modify the INTERVAL_SEC below, make sure to also change it in
# the ~/github/dotfiles-latest/tmux/tools/linkarzu/tmuxKillSessions.sh script
#
# 1 hour = 3600 s
INTERVAL_SEC=7200
PLIST_ID="tmuxKillSessions"
PLIST_NAME="com.linkarzu.$PLIST_ID.plist"
PLIST_LABEL="${PLIST_NAME%.plist}"
PLIST_PATH="$HOME/Library/LaunchAgents/$PLIST_NAME"
SCRIPT_PATH="$HOME/github/dotfiles-latest/tmux/tools/linkarzu/$PLIST_ID.sh"

# Ensure the script file exists
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: $SCRIPT_PATH does not exist."
else
  # If the PLIST file does not exist, create it
  if [ ! -f "$PLIST_PATH" ]; then
    echo "Creating $PLIST_PATH..."
    cat <<EOF >"$PLIST_PATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$PLIST_LABEL</string>
    <key>ProgramArguments</key>
    <array>
        <string>$SCRIPT_PATH</string>
    </array>
    <key>StartInterval</key>
    <integer>$INTERVAL_SEC</integer>
    <key>StandardOutPath</key>
    <string>/tmp/$PLIST_ID.out</string>
    <key>StandardErrorPath</key>
    <string>/tmp/$PLIST_ID.err</string>
</dict>
</plist>
EOF
  fi
fi

# Check if the plist is loaded, and load it if not
if ! launchctl list | grep -q "$PLIST_LABEL"; then
  echo "Loading $PLIST_PATH..."
  launchctl load "$PLIST_PATH"
  echo "$PLIST_PATH loaded."
fi

# To unload
# launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.linkarzu.tmuxKillSessions
# Not sure why its not unloading it so I just remove the plist file
# rm $PLIST_PATH

install_xterm_kitty_terminfo() {
  # Attempt to get terminfo for xterm-kitty
  if ! infocmp xterm-kitty &>/dev/null; then
    echo "xterm-kitty terminfo not found. Installing..."
    # Create a temp file
    tempfile=$(mktemp)
    # Download the kitty.terminfo file
    # https://github.com/kovidgoyal/kitty/blob/master/terminfo/kitty.terminfo
    if curl -o "$tempfile" https://raw.githubusercontent.com/kovidgoyal/kitty/master/terminfo/kitty.terminfo; then
      echo "Downloaded kitty.terminfo successfully."
      # Compile and install the terminfo entry for my current user
      if tic -x -o ~/.terminfo "$tempfile"; then
        echo "xterm-kitty terminfo installed successfully."
      else
        echo "Failed to compile and install xterm-kitty terminfo."
      fi
    else
      echo "Failed to download kitty.terminfo."
    fi
    # Remove the temporary file
    rm "$tempfile"
  fi
}
install_xterm_kitty_terminfo

# Open man pages in neovim, if neovim is installed
if command -v nvim &>/dev/null; then
  export MANPAGER='nvim +Man!'
  export MANWIDTH=999
fi

#############################################################################
#                        Cursor configuration
#############################################################################

# # NOTE: I think the issues with my cursor started happening when I moved to wezterm
# # and started using the "wezterm" terminfo file, when in wezterm, I switched to
# # the "xterm-kitty" terminfo file, and the cursor is working great without
# # the configuration below. Leaving the config here as reference in case it
# # needs to be tested with another terminal emulator in the future

# # https://unix.stackexchange.com/questions/433273/changing-cursor-style-based-on-mode-in-both-zsh-and-vim
# # You can customise the type of cursor you want (blinking or not, |, rectangle or _)
# # by changing the numbers in the following sequences \e[5 q (5 is for beam, 1 is for block) as follows:
# #  Set cursor style (DECSCUSR), VT520.
# # 0  ⇒  blinking block.
# # 1  ⇒  blinking block (default).
# # 2  ⇒  steady block.
# # 3  ⇒  blinking underline.
# # 4  ⇒  steady underline.
# # 5  ⇒  blinking bar, xterm.
# # 6  ⇒  steady bar, xterm.

# # vi mode
# bindkey -v
# export KEYTIMEOUT=1
#
# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#     [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#     [[ ${KEYMAP} == viins ]] ||
#     [[ ${KEYMAP} = '' ]] ||
#     [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#   zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#   echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q'                # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.

#############################################################################
#                        Colorscheme configuration
#############################################################################

# This is set in ~/github/dotfiles-latest/colorscheme/colorscheme-vars.sh
~/github/dotfiles-latest/zshrc/colorscheme-set.sh "$colorscheme_profile"

#############################################################################

# Add SSH keys to the agent as these keys won't persist after the computer is restarted
# Check and add the personal GitHub key
# if [ -f ~/.ssh/key-github-pers ]; then
#   ssh-add ~/.ssh/key-github-pers >/dev/null 2>&1
# fi

# Check and add the work GitHub key
if [ -f ~/.ssh/id_rsa ]; then
  ssh-add ~/.ssh/id_rsa >/dev/null 2>&1
fi

# disable auto-update when running 'brew something'
export HOMEBREW_NO_AUTO_UPDATE="1"

# Stuff in my private dotfiles that is still in beta, so I'm still testing it
# Usually shared in my discord in the #early-releases channel with youtube members
# NOTE: If you want to become a YouTube member
# https://www.youtube.com/channel/UCrSIvbFncPSlK6AdwE2QboA/join
if [ -f ~/github/dotfiles-private/zshrc/zshrc-macos.sh ]; then
  source ~/github/dotfiles-private/zshrc/zshrc-macos.sh
fi

# Stuff that I want to load, but not to have visible in my public dotfiles
if [ -f "$HOME/Library/Mobile Documents/com~apple~CloudDocs/github/.zshrc_local" ]; then
  source "$HOME/Library/Mobile Documents/com~apple~CloudDocs/github/.zshrc_local"
fi

# Configuration below is local only, not in icloud
if [ -f "$HOME/.zshrc_local/env-setup.sh" ]; then
  source "$HOME/.zshrc_local/env-setup.sh"
fi

# Set JAVA_HOME to the OpenJDK installation managed by Homebrew
export JAVA_HOME="/opt/homebrew/opt/openjdk"
# Add JAVA_HOME/bin to the beginning of the PATH
export PATH="$JAVA_HOME/bin:$PATH"

# Brew autocompletion settings
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# -v makes command display a description of how the shell would
# invoke the command, so you're checking if the command exists and is executable.
if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

#############################################################################
#                       Command line tools
#############################################################################

# Tool that I use the most and the #1 in my heart is tmux

# Initialize fzf if installed
# https://github.com/junegunn/fzf
# The following are custom fzf menus I configured
# hyper+e+n tmux-sshonizer-agen
# hyper+t+n prime's tmux-sessionizer
# hyper+c+n colorscheme selector
#
# Useful commands
# ctrl+r - command history
# ctrl+t - search for files
# ssh ::<tab><name> - shows you list of hosts in case don't remember exact name
# kill -9 ::<tab><name> - find and kill a process
# telnet ::<TAB>
#
if [ -f ~/.fzf.zsh ]; then

  # After installing fzf with brew, you have to run the install script
  # echo -e "y\ny\nn" | /opt/homebrew/opt/fzf/install

  source ~/.fzf.zsh

  # Preview file content using bat
  export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

  # Use :: as the trigger sequence instead of the default **
  export FZF_COMPLETION_TRIGGER='::'

  # Eldritch Colorscheme / theme
  # https://github.com/eldritch-theme/fzf
  export FZF_DEFAULT_OPTS='--color=fg:#ebfafa,bg:#09090d,hl:#37f499 --color=fg+:#ebfafa,bg+:#0D1116,hl+:#37f499 --color=info:#04d1f9,prompt:#04d1f9,pointer:#7081d0 --color=marker:#7081d0,spinner:#f7c67f,header:#323449'
fi

# # Starship
# # Not sure if counts a CLI tool, because it only makes my prompt more useful
# # https://starship.rs/config/#prompt
# # I was getting this error
# # starship_zle-keymap-select-wrapped:1: maximum nested function level reached; increase FUNCNEST?
# # Check that the function `starship_zle-keymap-select()` is defined
# # https://github.com/starship/starship/issues/3418
if command -v starship &>/dev/null; then
  type starship_zle-keymap-select >/dev/null ||
    {
      #FIXME: invalid dir
      export STARSHIP_CONFIG=$HOME/github/dotfiles-latest/starship-config/active-config.toml
      eval "$(starship init zsh)" >/dev/null 2>&1
    }
fi

# eza
# ls replacement
# exa is unmaintained, so now using eza
# https://github.com/ogham/exa
# https://github.com/eza-community/eza
# uses colours to distinguish file types and metadata. It knows about
# symlinks, extended attributes, and Git.
if command -v eza &>/dev/null; then
  alias ls='eza'
  alias ll='eza -lhg'
  alias lla='eza -alhg'
  alias tree='eza --tree'
fi

# Bat -> Cat with wings
# https://github.com/sharkdp/bat
# Supports syntax highlighting for a large number of programming and markup languages
if command -v bat &>/dev/null; then
  # --style=plain - removes line numbers and git modifications
  # --paging=never - doesnt pipe it through less
  alias cat='bat --paging=never --style=plain'
  alias catt='bat'
  # alias cata='bat --show-all --paging=never'
  alias cata='bat --show-all --paging=never --style=plain'
fi

# Zsh Vi Mode
# vi(vim) mode plugin for ZSH
# https://github.com/jeffreytse/zsh-vi-mode
# Insert mode to type and edit text
# Normal mode to use vim commands
# test {really} long (command) using a { lot } of symbols {page} and {abc} and other ones [find] () "test page" {'command 2'}
# if [ -f "$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]; then
#   source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
#   # Following 4 lines modify the escape key to `kj`
#   ZVM_VI_ESCAPE_BINDKEY=kj
#   ZVM_VI_INSERT_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
#   ZVM_VI_VISUAL_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
#   ZVM_VI_OPPEND_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
#
#   # Function to switch to the left tmux pane and maximize it
#   function tmux_left_pane() {
#     # This defines if the tmux pane created by neovim is on the right or
#     # bottom, make sure you also configure the neovi keymap to match
#     export TMUX_PANE_DIRECTION="right"
#     if [[ $TMUX_PANE_DIRECTION == "right" ]]; then
#       tmux select-pane -L # Move to the left (opposite of right)
#     elif [[ $TMUX_PANE_DIRECTION == "bottom" ]]; then
#       tmux select-pane -U # Move to the top (opposite of bottom)
#     fi
#     tmux resize-pane -Z
#     # zle reset-prompt # Refresh the prompt after switching panes
#   }
#
#   # Register the function as a ZLE widget
#   # zle -N tmux_left_pane
#   zvm_define_widget tmux_left_pane
#
#   function zvm_after_lazy_keybindings() {
#     # Remap to go to the beginning of the line
#     zvm_bindkey vicmd 'gh' beginning-of-line
#     # Remap to go to the end of the line
#     zvm_bindkey vicmd 'gl' end-of-line
#     # Moves me to my left pane in tmux and maximizes it
#     # Bind Alt-t to the tmux_left_pane function in normal and insert mode
#     # To know that alt-t is ^[t I used `/bin/cat -v` and then pressed alt-t
#     zvm_bindkey vicmd '^[t' tmux_left_pane
#     zvm_bindkey viins '^[t' tmux_left_pane
#     # I used ',' to switch to left pane and maximize it  before switching to alt-t
#     # zvm_bindkey vicmd ',' tmux_left_pane
#     # Move to the left tmux pane with escape on normal and insert mode
#     # zvm_bindkey vicmd '^[' tmux_left_pane
#     # zvm_bindkey viins '^[' tmux_left_pane
#   }
#
#   # zvm_bindkey vicmd '\e' tmux_left_pane
#
#   # Disable the cursor style feature
#   # I my cursor above in the cursor section
#   # https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#custom-cursor-style
#   #
#   # NOTE: My cursor was not blinking when using wezterm with the "wezterm"
#   # terminfo, setting it to a blinking cursor below fixed that
#   # I also set my term to "xterm-kitty" for this to work
#   #
#   # This also specifies the blinking cursor
#   # ZVM_CURSOR_STYLE_ENABLED=false
#   ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
#   ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
#   ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
#
#   # Source .fzf.zsh so that the ctrl+r bindkey is given back fzf
#   zvm_after_init_commands+=('[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh')
# fi

# https://github.com/zsh-users/zsh-autosuggestions
# Right arrow to accept suggestion
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Changed from z.lua to zoxide, as it's more maintaned
# smarter cd command, it remembers which directories you use most
# frequently, so you can "jump" to them in just a few keystrokes.
# https://github.com/ajeetdsouza/zoxide
# https://github.com/skywind3000/z.lua
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"

  alias cd='z'
  # Alias below is same as 'cd -', takes to the previous directory
  alias cdd='z -'

  #Since I migrated from z.lua, I can import my data
  # zoxide import --from=z "$HOME/.zlua" --merge

  # Useful commands
  # z foo<SPACE><TAB>  # show interactive completions
fi

#############################################################################
