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
antigen theme bhilburn/powerlevel9k powerlevel9k
# Syntax highlighting supposed to go at the end
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Autosuggest config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
bindkey '^ ' autosuggest-accept

export PATH=$PATH:~/Code/ecs_config/bin
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
