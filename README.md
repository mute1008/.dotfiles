# dotfiles

```sh
$ # Nix をインストール
$ #   - https://nixos.org/download/
```

```sh
$ # インストール
$ git clone https://github.com/mute1008/.dotfiles ~/.dotfiles
$ make
```

```sh
$ # デフォルトシェルの変更
$ echo "$HOME/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
$ chsh -s "$HOME/.nix-profile/bin/zsh"
```
