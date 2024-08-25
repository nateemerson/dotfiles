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

# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

source ~/.local/bin/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme romkatv/powerlevel10k
# Syntax highlighting supposed to go at the end
antigen apply

# Autosuggest config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

 #COMPLETION SETTINGS
# Via (https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/)
# add custom completion scripts
fpath=($fpath ~/.zsh/completion)

export PATH=~/.bin:$PATH:/usr/local/go/bin
export EDITOR=/usr/local/bin/nvim
export VISUAL=/usr/local/bin/nvim
export XDG_CONFIG_HOME=~/.config

# Tmuxinator completion
# source ~/.bin/tmuxinator.zsh

# compsys initialization
# autoload -U compinit
# compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim=nvim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/Users/nate/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(direnv hook zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1

# bun completions
[ -s "/Users/nate/.bun/_bun" ] && source "/Users/nate/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opam configuration
[[ ! -r /Users/nate/.opam/opam-init/init.zsh ]] || source /Users/nate/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
