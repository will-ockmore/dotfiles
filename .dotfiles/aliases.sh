# Aliases


# Python
alias enva='if poetry check > /dev/null 2>&1; then source "$( poetry env list --full-path | grep Activated | cut -d'\'' '\'' -f1 )/bin/activate"; else source venv/bin/activate; fi'

# Javascript
alias ni="npm install"
alias ns="npm start"
alias nt="npm test"

alias nu="nvm use"
alias nvmc="nvm current"


# Useful AWS commands / aliases
alias subscription_filters="saw groups | xargs -P8 -I {} aws logs describe-subscription-filters --log-group-name {} | jq -r '.subscriptionFilters | select(length > 0) | .[0] | .logGroupName'"

# OS specific aliases
if [[ "$(uname)" == "Darwin" ]]; then
    alias ']'='open'
    alias notes="python ~/.dotfiles/generate_notes_pdfs.py && ] -a /Applications/Firefox.app ~/notes/pdf"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    alias ']'='xdg-open'
    alias notes="python ~/.dotfiles/generate_notes_pdfs.py && firefox ~/notes/pdf"
fi

# Workflow
alias ,t="tig status"
alias l="exa -lahF"
