# Path to your oh-my-zsh installation.
export ZSH=/Users/will/.oh-my-zsh

DEFAULT_USER="Will"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/

# ZSH_THEME="agnoster-custom"
ZSH_THEME="bureau"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions git)

# Enable extended globbing eg. negation patterns
setopt extended_glob


# Exports - User configuration

export PATH=${PATH}:~/usr/local/bin
export PATH=${PATH}:~/usr/local/bin/mysql
export PATH=$HOME/.local/bin:$PATH
export PATH=${PATH}:/Applications/MAMP/Library/bin/mysql
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_SDK=/usr/local/opt/android-sdk
export ANDROID_NDK=/usr/local/opt/android-ndk

export REACT_EDITOR="subl" # Add sublime to REACT_EDITOR for scriptin


# Exports - User configuration

source $ZSH/oh-my-zsh.sh


# Aliases

alias enva="source env/bin/activate"

alias ni="npm install"
alias ns="npm start"
alias nt="npm test"

alias nu="nvm use"
alias nvmc="nvm current"

# test command for django projects (catfish - uses runtests)
alias ctest="NO_MIGRATIONS=true ctf project run -- runtests --keepdb"
alias ct="IN_TEST=true FILE_STORAGE='django.core.files.storage.FileSystemStorage' ctf project run manage.py -- test --keepdb"

ctp() {
  if [[ $@ == "start" ]]; then
      command ctf project start
  elif [[ $@ == "stop" ]]; then
      command ctf project stop
  elif [[ $@ == "restart" ]]; then
      command ctf project restart
  elif [[ $@ == "status" ]]; then
      command ctf project status
  elif [[ $@ == "stop" ]]; then
      command ctf project stop
  elif [[ $@ == "logs" ]]; then
      command ctf project logs
  elif [[ $@ == "what" ]]; then
      ctp stop && ctp start & ctp logs
  elif [[ $@ == "shell" ]]; then
      command ctf project run -- python manage.py shell
  elif [[ $@ == "migrate" ]]; then
      command ctf project run -- python manage.py migrate
  elif [[ $@ == "test" ]]; then
      command ctf project run -- runtests --keepdb
  else
      command ctf project "$@"
  fi
}

# General Scripts

renamealljpg() {
  a=1
  for i in *.png; do
    new=$(printf "png_%02d.png" "$a") #04 pad to length of 2
    mv -- "$i" "$new"
    let a=a+1
  done
}

bkdotfiles() {
  cp -r ~/.{zshrc,bash_history,bash_profile,dotfiles} ~/Projects/dotfiles
  echo 'copied'
  cd ~/Projects/dotfiles
  ls -a
  git status
  git add .
  echo 'added to git'
  git status
  git commit -m 'Backup dotfiles on `date %F`'
  echo 'committed'
  git push
}

bktoext () {
  # Backup tweets database from droplet
  mongodump --host 67.205.133.245 \
    --port 18681 \
    --db tweets-2 \
    --username tweets-2 \
    --password 9af4a73a6fb590fbb657d1dc0a24b2ba \
    --out $@/data-dumps/tweets2-`date %F` \

  # Backup home directory folders
  sudo rsync -azvh /Users/will/Documents $@/Backups/Documents
  sudo rsync -azvh /Users/will/Pictures $@/Backups/Pictures
  sudo rsync -azvh /Users/will/Projects/haskell $@/Backups/Projects/haskell
  sudo rsync -azvh /Users/will/Projects/node $@/Backups/Projects/node
  sudo rsync -azvh /Users/will/Projects/personal-projects $@/Backups/Projects/personal-projects
  sudo rsync -azvh /Users/will/Projects/python-scripts $@/Backups/Projects/python-scripts
  sudo rsync -azvh /Users/will/Projects/tutorials $@/Backups/Projects/tutorials

  # Sync dotfiles, commit and backup
  cp ~/.{zshrc,bash_history,bash_profile,dotfiles} ~/Projects/dotfiles
  sudo rsync -azvh /Users/will/Projects/dotfiles $@/Backups/Projects/dotfiles
  sudo rsync -azvh ~/.ssh/* /Volumes/Maxtor\ External\ HDD/Backups/ssh

}


# GitHub Personal Token (Mostly - Catfish)

if [ -f ~/.github_token ]; then
    export GITHUB_TOKEN=`cat ~/.github_token`
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
