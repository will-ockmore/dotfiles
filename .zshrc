DEFAULT_USER="will"

# Enable extended globbing eg. negation patterns
setopt extended_glob

# don't require explicitly matching a leading . in filenames
setopt glob_dots

# Custom configuration
# All commands and aliases are stored separately in the .dotfiles folder

# pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

source ~/.private-environment-variables
source ~/.dotfiles/backup-commands.sh
source ~/.dotfiles/misc-commands.sh
source ~/.dotfiles/aliases.sh

# Add scripts to PATH
export PATH=$PATH:$HOME/.dotfiles/misc_scripts

# Add further setup here (eg. NVM, GOPATH etc.)
export EDITOR='nvim'
alias vi='nvim'
alias vim='nvim'

export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!.git/*'"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# Add pip --user programs to PATH
export PATH=$PATH:$HOME/.local/bin


source /home/will/.config/broot/launcher/bash/br

export PATH="$HOME/.poetry/bin:$PATH"
source ~/.dotfiles/pyenv-config.sh

eval "$(luarocks path --bin)"
