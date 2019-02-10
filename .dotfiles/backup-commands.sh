bkdotfiles() {
  echo 'backing up dotfiles...'
  cp -r ~/.{zshrc,bash_profile,dotfiles,gitconfig} ~/Projects/dotfiles
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
  rsync -azh /Library/Audio/Plug-Ins $@/Backups/audio-plug-ins
  rsync -azh ~/Projects/haskell $@/Backups/Projects
  rsync -azh ~/Projects/node $@/Backups/Projects
  rsync -azh ~/Projects/personal-projects $@/Backups/Projects
  rsync -azh ~/Projects/python-scripts $@/Backups/Projects
  rsync -azh ~/Projects/tutorials $@/Backups/Projects

  # Sync dotfiles
  bkdotfiles
  rsync -azh ~/Projects/dotfiles $@/Backups/Projects
  rsync -azh ~/.ssh/* $@/Backups/ssh
  rsync -azh ~/.zsh_history $@/Backups/.zsh_history
}

bkglacier () {
  local PHOTOS_ARCHIVE_PATH="$1/photos.tar.gz"
  local BACKUPS_ARCHIVE_PATH="$1/backups.tar.gz"
  # zip archives
  tar -zcvf $PHOTOS_ARCHIVE_PATH $1/photos
  tar -zcvf $BACKUPS_ARCHIVE_PATH $1/Backups

  # upload to glacier archive
  AWS_SECRET_ACCESS_KEY=$BACKUP_AWS_SECRET_ACCESS_KEY \
  AWS_ACCESS_KEY_ID=$BACKUP_AWS_ACCESS_KEY_ID \
  aws glacier upload-archive \
    --vault-name personal-backups \
    --account-id - \
    --body $PHOTOS_ARCHIVE_PATH

  AWS_SECRET_ACCESS_KEY=$BACKUP_AWS_SECRET_ACCESS_KEY \
  AWS_ACCESS_KEY_ID=$BACKUP_AWS_ACCESS_KEY_ID \
  aws glacier upload-archive \
    --vault-name personal-backups \
    --account-id - \
    --body $BACKUPS_ARCHIVE_PATH

}

