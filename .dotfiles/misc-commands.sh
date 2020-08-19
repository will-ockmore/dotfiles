# General Scripts

renamealljpg() {
  a=1
  for i in *.png; do
    new=$(printf "png_%02d.png" "$a") #04 pad to length of 2
    mv -- "$i" "$new"
    let a=a+1
  done
}


encodemessage() {
  echo "openssl enc -base64 -d -A <<< $(openssl enc -base64 <<< $@) | say"
}


printargs() {
  echo "$@"

  cnt=1
  for arg in "$@"; do
    echo "Argument $cnt: $arg"
    let "cnt+=1"
  done
}


# Search firefox history
fhist() {
  local cols sep firefox_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  firefox_history="$(find "$HOME/Library/Application Support/Firefox/Profiles" -name "places.sqlite" -print0 | xargs -0 ls -1 -t | head -1)"
  cp -f "$firefox_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from moz_historyvisits
     join moz_places
     on moz_historyvisits.place_id = moz_places.id
     order by visit_date desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#'
}

# Search chrome history
chist() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}


# display octal file permissions
lso() { ls -alG "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}'; }


# display absolute path
abspath() {
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 = /* ]]; then
            echo "$1"
        elif [[ $1 == */* ]]; then
            echo "$(cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}


# Fuzzy find CloudWatch Logs and tail them
cwl() {
  GROUP="$(saw groups --profile production | fzf)"

  echo
  echo "Tailing CloudWatch Logs for log group \e[1m$GROUP\e[0m..."
  echo

  saw watch --profile production $GROUP
}

# Start development instance and return IP address
start_dev_instance() {
  aws ec2 start-instances --profile production --instance-ids $DEV_INSTANCE_ID > /dev/null

  echo 'Waiting for instance to start...'

  while [[ $(aws ec2 describe-instances --profile production --instance-ids $DEV_INSTANCE_ID |  jq -r '.Reservations[0].Instances[0].State.Name') != 'running'  ]]; do
    echo '.'
    sleep 3
  done

  echo 'Instance started. '
  echo

  DEV_INSTANCE_IP_ADDRESS=$(aws ec2 describe-instances --profile production --instance-ids $DEV_INSTANCE_ID | jq -r '.Reservations[0].Instances[0].NetworkInterfaces[0].Association.PublicIp')

  echo "IP address: $DEV_INSTANCE_IP_ADDRESS"
  echo
  echo 'Connecting to instance...'

# -o 'XAuthLocation=/opt/X11/bin/xauth' \


  ssh \
    -o 'ForwardX11Trusted=yes' \
    -o 'ForwardX11=yes' \
    -o 'IdentityFile=~/.ssh/similarity-search.pem' \
    -o 'ForwardAgent=yes' \
    -o 'IdentitiesOnly=yes' \
    "ubuntu@$DEV_INSTANCE_IP_ADDRESS"
}

# Daily coronavirus updates
coronastats() {
    [ "$(stat -c %y ~/.cache/corona 2>/dev/null | cut -d' ' -f1 )" != "$(date '+%Y-%m-%d')" ] && curl -s https://corona-stats.online > ~/.cache/corona

    rg -e "Canada|UK|US|Country" ~/.cache/corona | cat
}

# Update git remote configuration to match SSH config
,gitseturl() {
    local REMOTE_NAME REMOTE_URL GIT_EMAIL
    REMOTE_NAME=$(git remote -v | head -n 1 | awk '{print $1}')
    REMOTE_URL=$(git remote -v | head -n 1 | awk -f ~/.dotfiles/modify_git_remote.awk)
    GIT_EMAIL=$(git remote -v | head -n 1 | awk -f ~/.dotfiles/modify_git_email.awk)
    GIT_SIGNINGKEY=$(git remote -v | head -n 1 | awk -f ~/.dotfiles/modify_git_signingkey.awk)

    git remote set-url "$REMOTE_NAME" "$REMOTE_URL"
    git config user.email "$GIT_EMAIL"
    git config user.signingkey "$GIT_SIGNINGKEY"
}

,gitclone() {
    local REMOTE_URL GIT_EMAIL
    REMOTE_URL=$(awk -f ~/.dotfiles/modify_git_remote.awk <<< "origin $1")
    GIT_EMAIL=$(awk -f ~/.dotfiles/modify_git_email.awk <<< "origin $1")
    GIT_SIGNINGKEY=$(awk -f ~/.dotfiles/modify_git_signingkey.awk <<< "origin $1")

    git clone "$REMOTE_URL"

    # Enter repository directory
    cd $(awk '{match($2, /git@.*\/(.*)\.git/, groups); print groups[1]}' <<< "origin $1")
    git config user.email "$GIT_EMAIL"
    git config user.signingkey "$GIT_SIGNINGKEY"
    cd -
}

