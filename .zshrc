# Path to your oh-my-zsh installation.
export ZSH=/home/will/.oh-my-zsh

DEFAULT_USER="will"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/

# ZSH_THEME="bureau"
ZSH_THEME=""

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Enable extended globbing eg. negation patterns
setopt extended_glob

# don't require explicitly matching a leading . in filenames
setopt glob_dots

# Custom configuration
# All commands and aliases are stored separately in the .dotfiles folder

source $ZSH/oh-my-zsh.sh

# pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

source ~/.private-environment-variables
source ~/.dotfiles/pyenv-config.sh
source ~/.dotfiles/backup-commands.sh
source ~/.dotfiles/misc-commands.sh
source ~/.dotfiles/aliases.sh

# Add scripts to PATH
export PATH=$PATH:$HOME/.dotfiles/misc_scripts

# Add further setup here (eg. NVM, GOPATH etc.)
export EDITOR='vim'
alias vi='vimx'
alias vim='vimx'

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
