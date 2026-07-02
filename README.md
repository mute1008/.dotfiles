# dotfiles

## セットアップ

```sh
# Nix をインストール: https://nixos.org/download/
git clone https://github.com/mute1008/.dotfiles ~/.dotfiles

home-manager switch --flake ~/.dotfiles#default --impure   # 衝突時は -b backup

# zsh を login shell に
echo "$HOME/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$HOME/.nix-profile/bin/zsh"
```

## 更新・ロールバック

```sh
nix flake update
home-manager switch --flake ~/.dotfiles#default --impure
home-manager generations
home-manager switch --rollback
```

## Windows

アプリは `home/winget.json`（`winget export -o` で更新）を WSL の switch で `winget import` する。
host 側で手動:

```powershell
wsl --install
ctrl2cap /install
```
