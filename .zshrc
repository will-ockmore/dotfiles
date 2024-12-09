# Enable extended globbing eg. negation patterns
setopt extended_glob

# don't require explicitly matching a leading . in filenames
setopt glob_dots

# Skip identical history entries in search
setopt histignoredups

# Custom configuration
# All commands and aliases are stored separately in the .dotfiles folder

# Save history from concurrent sessions
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space
HISTSIZE=100000000
SAVEHIST=100000000

# pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

source ~/.dotfiles/misc-commands.sh
source ~/.dotfiles/aliases.sh
source ~/.dotfiles/keymaps.sh

# Add scripts to PATH
export PATH=$PATH:$HOME/.dotfiles/misc_scripts

# Add further setup here (eg. NVM, GOPATH etc.)
export EDITOR='nvim'
alias vi='nvim'
alias vim='nvim'

# Console Do Not Track https://consoledonottrack.com/
export DO_NOT_TRACK=1

export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!.git/*'"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Add pip --user programs to PATH
export PATH=$PATH:$HOME/.local/bin

export PATH="$HOME/.poetry/bin:$PATH"
