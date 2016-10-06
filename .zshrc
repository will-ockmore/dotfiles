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
plugins=(git)


# Exports - User configuration

export PATH=${PATH}:~/usr/local/bin
export PATH=${PATH}:~/usr/local/bin/mysql
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
  else
      command ctf project "$@"
  fi
}

# Scripts - split by project

# iComply
#

icomply() {
  # Set up new copy of database
  if [[ $@ == "recreate" ]]; then
    echo "Recreating database"
    dropdb icomply
    createdb icomply
    echo "Running migrations and migration scripts"
    ctf project run manage.py migrate &&
    ctf project run manage.py migrate_data mysql://root:root@localhost/icomply_dev &&
    ctf project run manage.py interpret_groups &&
    ctf project run manage.py migrate_set_up_stages &&
    ctf project run manage.py migrate_todo_deadlines &&
    echo "Create super user" &&
    ctf project run manage.py createsuperuser
  fi
}




# GitHub Personal Token (Mostly - Catfish)

if [ -f ~/.github_token ]; then
    export GITHUB_TOKEN=`cat ~/.github_token`
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
