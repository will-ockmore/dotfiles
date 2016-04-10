# dotfiles

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
