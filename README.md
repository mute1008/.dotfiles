# dotfiles

## セットアップ

```sh
# Nix をインストール: https://nixos.org/download/

# flakes を有効化
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

git clone https://github.com/mute1008/.dotfiles ~/.dotfiles

# 初回は home-manager が未導入なので nix run で適用（衝突時は末尾に -b backup）
nix run github:nix-community/home-manager/release-24.11 -- switch --flake ~/.dotfiles#default --impure

# 以降の再適用
home-manager switch --flake ~/.dotfiles#default --impure

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

アプリは `app/winget/packages.json`（`winget export -o` で更新）を WSL の switch で `winget import` する。
host 側で手動:

```powershell
wsl --install
ctrl2cap /install
```
