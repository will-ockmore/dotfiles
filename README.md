# dotfiles

## Linux

### Scripts

Any scripts under the `misc_scripts` directory will be available on `$PATH`. See `.zshrc`

### Fonts

- [IBM Plex Mono](https://fonts.google.com/specimen/IBM+Plex+Mono)
- [Hack](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)

## Mac

### First Steps

1. Install chrome and login to account(s). Agree to sync, this will add your extensions.
2. Sign in with your Apple ID to the app store and install Magnet.
3. Open Preferences and under mouse, uncheck Natural Scroll Direction.

### Applications

Download and install:

- [ITerm2](https://www.iterm2.com/)
- [Spotify](https://www.spotify.com/uk/download/mac/)

## General

### Applications

- Kitty
- Pyenv
- Nvm
- neovim

### Security

[Generate a new SSH key](https://help.github.com/enterprise/2.12/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) for the machine, and follow the steps to add it to github.

### Tmux configuration

```
mkdir -p ~/.config/tmux
cp -a ./nightfox_tmux.tmux ~/.config/tmux/
cp -a .tmux.conf ~
```

### Kitty themes

Use the [kitty themes](https://github.com/dexpota/kitty-themes) repo for a general collection of themes.

```
mkdir -p ~/.config/kitty/themes
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/themes/kitty-themes
cp -a
```

Then make sure any custom themes are also installed under the `~/.config/kitty/themes` path.

To change to a new theme:

```
cd ~/.config/kitty
ln -sf $(find . | fzf) ~/.config/kitty/theme.conf
cd -
```

Then close and restart kitty.

Don't forget to commit the changes to this repo:

```
cp -a ~/.config/kitty .
```
