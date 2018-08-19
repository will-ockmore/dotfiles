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
  echo "openssl enc -base64 -d -A <<< `openssl enc -base64 <<< $@` | say"
}

printargs() {
  echo "$@"

  cnt=1
  for arg in "$@"; do
    echo "Argument $cnt: $arg"
    let "cnt+=1"
  done
}
