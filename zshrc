# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# doesn't work
# complete -C aws_completer aws

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

source /usr/local/share/antigen/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen theme avit
export ZSH_THEME="avit"
# Syntax highlighting supposed to go at the end
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Autosuggest config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
bindkey '^ ' autosuggest-accept

export PATH=$PATH:~/Code/ecs_config/bin
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
# Add Mysql libraries to path
export PATH="/usr/local/opt/openssl/bin:$PATH"

 #COMPLETION SETTINGS
# Via (https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/)
# add custom completion scripts
fpath=($fpath ~/.zsh/completion)

export PATH=~/.bin:$PATH
export EDITOR=/usr/local/bin/vim
export VISUAL=/usr/local/bin/vim

# Tmuxinator completion
source ~/.bin/tmuxinator.zsh

# compsys initialization
autoload -U compinit
compinit
