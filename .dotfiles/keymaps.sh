# OS-specific keymaps
if [[ "$(uname)" == "Darwin" ]]; then
    bindkey "^[[1;3D" backward-word     # ⌥←
    bindkey "^[[1;3C" forward-word      # ⌥→
# elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
fi
