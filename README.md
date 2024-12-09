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
4. Enable key repeat properly: https://apple.stackexchange.com/a/58847
5. Speed up key repeat: https://apple.stackexchange.com/a/83923

## General

### Applications

- Kitty https://sw.kovidgoyal.net/kitty/
- Homebrew https://brew.sh/
- mise https://mise.jdx.dev/
- pure prompt https://github.com/sindresorhus/pure - choose the manual installation method.
- fzf https://github.com/junegunn/fzf - install using git. Use default for all options (`[y]`).
- neovim - `mise use -g neovim@0.9.5` to mitigate vscode-neovim bug. If this is no longer a problem, omit the version. See also: https://github.com/will-ockmore/vimrc
- ripgrep - `mise use -g ripgrep`
- tmux - `mise use -g tmux`
- tmuxp - https://github.com/tmux-python/tmuxp - `brew install tmuxp`
- eza https://github.com/eza-community/eza - `mise use -g eza`
- node - `mise use -g node`
- tig https://jonas.github.io/tig/ - `brew install tig`

### Security

[Generate a new SSH key](https://help.github.com/enterprise/2.12/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) for the machine, and follow the steps to add it to github.

### Tmux configuration

```
mkdir -p ~/.config/tmux
cp -a ./nightfox_tmux.tmux ~/.config/tmux/
cp -a .tmux.conf ~
```

#### Tmuxp configuration

```
cp -a .tmuxp ~/
```

### Kitty themes

Use the [kitty themes](https://github.com/dexpota/kitty-themes) repo for a general collection of themes.

To update the themes:

```
git clone --depth 1 https://github.com/dexpota/kitty-themes.git kitty/themes/kitty-themes
```

Then make sure any custom themes are also installed under the `./kitty/themes` path.

Install the configuration and themes locally:

```
cp -a ~/code/dotfiles/kitty ~/.config/
```

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
