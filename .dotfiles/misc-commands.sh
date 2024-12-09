# General Scripts

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

# Git

,gb() {
    git checkout $(git branch --sort=-committerdate | fzf)
}
