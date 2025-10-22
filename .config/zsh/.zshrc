# ENV
source $ZDOTDIR/exports.zsh
[[ -f "$ZDOTDIR/secrets.zsh" ]] && source "$ZDOTDIR/secrets.zsh"

# Antidote Plugin Manager
export ANTIDOTE_HOME="$ZDOTDIR/antidoteplugins"

# Use Homebrew-installed antidote
source $(brew --prefix)/share/antidote/antidote.zsh
antidote load

# Prompt config (pure)
source $ZDOTDIR/prompt.zsh

# Aliases, functions, completions
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/completion.zsh