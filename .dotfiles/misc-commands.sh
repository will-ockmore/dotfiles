# General Scripts

renamealljpg() {
  a=1
  for i in *.png; do
    new=$(printf "png_%02d.png" "$a") #04 pad to length of 2
    mv -- "$i" "$new"
    let a=a+1
  done
}
