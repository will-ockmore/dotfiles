# dotfiles

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

## Setup for linux:

- Install Numix theme, and the Unity tweak tool

        sudo add-apt-repository ppa:numix/ppa
        sudo apt-get update
        sudo apt-get install numix-gtk-theme numix-icon-theme-circle
        sudo apt-get install numix-wallpaper-notd
        sudo apt-get install unity-tweak-tool
    - You then want to install the Aller font found [here](https://www.fontsquirrel.com/fonts/aller) and set it in the unity tweak tool

- Install Python, node js

- Install terminator, zsh and oh-my-zsh:

         sudo apt-get install oh-my-zsh terminator
    - You need to follow the steps on [this](http://jabran.me/articles/ubuntu-dev-workspace-with-terminator-oh-my-zsh-cobalt2/) page, and install the powerline fonts package using the last set of steps [here](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation) to get it to display properly.

- Install Atom and assorted packages.

        sudo add-apt-repository ppa:webupd8team/atom
        sudo apt-get update
        sudo apt-get install atom
    Functionality:
    - atom-bootstrap3
    - autocomplete-paths
    - color-picker
    - expand-region
    - css-edit-groups
    - file-icons
    - git-projects
    - jshint
    - less-than-slash
    - linter
    - linter-csslint
    - linter-eslint
    - linter-flake8
    - merge-conflicts
    - minimap
    - minimap-find-and-replace
    - minimap-git-diff

    UI
    - atom-material-ui
    - atom-material-syntax

    Latex
    - pdf-view
    - latex
    - language-latex

### General software
- Spotify

        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
        echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
        sudo apt-get update
        sudo apt-get install spotify-client

- VLC

        sudo apt-get install vlc

- Lastpass
