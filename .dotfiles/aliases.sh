# Aliases

# Python
alias enva='if poetry check > /dev/null 2>&1; then source "$( poetry env list --full-path | grep Activated | cut -d'\'' '\'' -f1 )/bin/activate"; else source venv/bin/activate; fi'

# OS specific aliases
if [[ "$(uname)" == "Darwin" ]]; then
    alias ']'='open'
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    alias ']'='xdg-open'
fi

# Workflow
alias ,t="tig status"
alias l="eza -lahF"
