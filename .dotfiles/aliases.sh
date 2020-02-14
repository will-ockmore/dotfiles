# Aliases


# Python
alias enva="source env/bin/activate"


# Javascript
alias ni="npm install"
alias ns="npm start"
alias nt="npm test"

alias nu="nvm use"
alias nvmc="nvm current"


# Useful AWS commands / aliases
alias subscription_filters="saw groups | xargs -P8 -I {} aws logs describe-subscription-filters --log-group-name {} | jq -r '.subscriptionFilters | select(length > 0) | .[0] | .logGroupName'"
