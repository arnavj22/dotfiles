# ENV
source $ZDOTDIR/exports.zsh
[[ -f "$ZDOTDIR/secrets.zsh" ]] && source "$ZDOTDIR/secrets.zsh"

# Antidote Plugin Manager
export ANTIDOTE_HOME="$ZDOTDIR/antidoteplugins"
zsh_plugins="${ZDOTDIR}/.zsh_plugins"

[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt
fpath=($ZDOTDIR/.antidote/functions $fpath)
autoload -Uz antidote
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >! ${zsh_plugins}.zsh
fi
source ${zsh_plugins}.zsh

# Prompt config (pure)
source $ZDOTDIR/prompt.zsh

# Aliases, functions, completions
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/completion.zsh