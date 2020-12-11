# dotfiles

## Linux

### Backups

[Duplicacy](https://github.com/gilbertchen/duplicacy/wiki) is used for incremental backups to Backblaze B2.

Install the CLI version and ensure cron / anachron is installed - see
[guide](https://docs.fedoraproject.org/en-US/fedora/rawhide/system-administrators-guide/monitoring-and-automation/Automating_System_Tasks/) on fedora project.

Initialise the backup repositories. These commands were used the first time around, and may 
need to be modified to avoid overwriting the existing repos:

```bash
cd ~
duplicacy init --encrypt homedir_backup b2://wock-duplicacy-backups-homedir
cd /run/media/will/external_hd
duplicacy init --encrypt external_hdd_backup b2://wock-duplicacy-backups-external-hdd
```

Set the necessary variables so the backups can run without input

```bash
duplicacy set -storage backblaze_b2_backup -key b2_key -value "$B2_DUPLICACY_ACCOUNT_KEY"
duplicacy set -storage backblaze_b2_backup -key b2_id -value "$B2_DUPLICACY_KEY_ID"
duplicacy set -storage backblaze_b2_backup -key password -value "$DUPLICACY_STORAGE_PASSWORD" 
```

Create a backup logs folder under `/var/log/duplicacy_backups`.

The anacrontab should be updated once the backups are working, with lines in the form

```bash
1    25   backup-home             /home/will/.dotfiles/tasks/daily/backup_home >> /var/log/duplicacy_backups/backup_home.log 2>&1
1    25   backup-external-drive   /home/will/.dotfiles/tasks/daily/backup_externalhdd >> /var/log/duplicacy_backups/backup_externalhdd.log 2>&1
```


## Mac

### First Steps

1. Install chrome and login to account(s). Agree to sync, this will add your extensions.
2. Sign in with your Apple ID to the app store and install Magnet.
3. Open Preferences and under mouse, uncheck Natural Scroll Direction.

### Applications

Download and install:

- [ITerm2](https://www.iterm2.com/)
- [Sublime Text 3](https://www.sublimetext.com/3)
- [Spotify](https://www.spotify.com/uk/download/mac/)

Make sure package control is setup for Sublime - [follow the instructions](https://packagecontrol.io/installation).

### Security

[Generate a new SSH key](https://help.github.com/enterprise/2.12/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) for the machine, and follow the steps to add it to github.

### Setup Script

The setup script (`setup.sh`) will add packages and setup your environment.

**Make sure you close Sublime or it will break!**

1. The first step it takes is to copy over the dotfiles folder.
2. [Homebrew](https://brew.sh/) is then installed and updated.
3. Next step is to install [zsh](http://www.zsh.org/) and setup [OhMyZsh](https://github.com/robbyrussell/oh-my-zsh)
4. Then [pyenv](https://github.com/pyenv/pyenv) and [nvm](https://github.com/creationix/nvm) are installed
5. Extra programs are added from Homebrew:
  - [tig](https://github.com/jonas/tig)
  - [fzf](https://github.com/junegunn/fzf): Answer yes to auto-completion and key bindings, don't update shell configuration files.
6. Finally Sublime is configured:
    - The `subl` command is set up to work from the terminal
    - A symlink is made to user settings copied to dotfiles from this project
    - A script is added to add the nvm version of node to `PATH`, so packages which depend on it can work

There are a couple more steps to get Sublime completely working.
Start up an instance of it, and wait for Package Control to install everything.
Once that's done, go to the settings for [Sublime Linter](http://www.sublimelinter.com/en/latest/) and check the result of

```bash
echo $(pyenv root)/versions/$(pyenv global)/bin/
```

matches the OSX path (as described [here](https://thoughtstreams.io/paltman/getting-sublimelinter-to-work-with-pyenv-and-zsh/)).

Then, run the Boxy configuration and choose the theme.

Finally, install [Inconsolata](https://www.fontsquirrel.com/fonts/inconsolata).

### Iterm Preferences and color schemes

- Download color schemes from [here](http://iterm2colorschemes.com/).
- Set system wide hotkey.
- Make new tabs keep current working directory.
- [Set navigation keys](https://coderwall.com/p/h6yfda/use-and-to-jump-forwards-backwards-words-in-iterm-2-on-os-x)
