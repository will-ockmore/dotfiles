bkdotfiles() {
  echo 'backing up dotfiles...'
  cp -r ~/.{zshrc,bash_history,bash_profile,dotfiles} ~/Projects/dotfiles
  cd ~/Projects/dotfiles
  git add .
  git commit -m 'Backup dotfiles'
  git push
}

bktoext () {
  # Backup tweets database from droplet
  mongodump --host $DOKKU_TWEET_SERVER_ADDR \
    --port $DOKKU_TWEET_SERVER_PORT \
    --db tweets-2 \
    --username tweets-2 \
    --password $DOKKU_TWEET_SERVER_PASS \
    --out $@/data-dumps/tweets2-`date "+%Y-%m-%d"` \

  # Backup home directory folders
  echo 'backing up documents, pictures and projects...'
  rsync -azh ~/Documents $@/Backups
  rsync -azh ~/Pictures $@/Backups
  rsync -azh ~/Projects/haskell $@/Backups/Projects
  rsync -azh ~/Projects/node $@/Backups/Projects
  rsync -azh ~/Projects/personal-projects $@/Backups/Projects
  rsync -azh ~/Projects/python-scripts $@/Backups/Projects
  rsync -azh ~/Projects/tutorials $@/Backups/Projects

  # Sync dotfiles
  bkdotfiles
  rsync -azh ~/Projects/dotfiles $@/Backups/Projects
  rsync -azh ~/.ssh/* $@/Backups/ssh
}
