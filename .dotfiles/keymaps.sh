# OS-specific keymaps
if [[ "$(uname)" == "Darwin" ]]; then
    bindkey "^[b" backward-word     # ⌥←
    bindkey "^[f" forward-word      # ⌥→
# elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
fi
