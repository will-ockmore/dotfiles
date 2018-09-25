# Aliases

# Python
alias enva="source env/bin/activate"


# Javascript
alias ni="npm install"
alias ns="npm start"
alias nt="npm test"

alias nu="nvm use"
alias nvmc="nvm current"


# AWS

# Fuzzy find CloudWatch Logs and tail them
alias cwl="saw watch $(saw groups | fzf)"
