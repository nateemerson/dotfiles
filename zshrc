# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# doesn't work
# complete -C aws_completer aws

source /opt/homebrew/share/antigen/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen theme romkatv/powerlevel10k
export ZSH_THEME="powerlevel10k/powerlevel10k"
# Syntax highlighting supposed to go at the end
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Autosuggest config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
bindkey '^ ' autosuggest-accept

export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

 #COMPLETION SETTINGS
# Via (https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/)
# add custom completion scripts
fpath=($fpath ~/.zsh/completion)

export PATH=~/.bin:$PATH
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# Tmuxinator completion
source ~/.bin/tmuxinator.zsh

# compsys initialization
autoload -U compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
