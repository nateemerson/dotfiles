eval "$(/opt/homebrew/bin/brew shellenv)"

# Autosuggest config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

 #COMPLETION SETTINGS
# Via (https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/)
# add custom completion scripts
# fpath=($fpath ~/.zsh/completion)

export PATH=$HOME/.local/bin:$PATH
export EDITOR=/usr/local/bin/nvim
export VISUAL=/usr/local/bin/nvim

# XDG Base Directory Spec
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

VIM="nvim"
export GIT_EDITOR=$VIM
export DOTFILES=$HOME/Code/dotfiles

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
