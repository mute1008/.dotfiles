# dotfiles

## セットアップ

```sh
# Nix: https://nixos.org/download/
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

```powershell
winget source update
winget install -e --id Google.Chrome --accept-source-agreements --accept-package-agreements
winget install -e --id AgileBits.1Password --accept-source-agreements --accept-package-agreements
winget install -e --id Discord.Discord --accept-source-agreements --accept-package-agreements
winget install -e --id Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements
winget install -e --id glzr-io.glazewm --accept-source-agreements --accept-package-agreements
winget install -e --id Microsoft.PowerToys --accept-source-agreements --accept-package-agreements
winget install -e --id Google.JapaneseIME --accept-source-agreements --accept-package-agreements
winget install -e --id Microsoft.Sysinternals.Ctrl2Cap --accept-source-agreements --accept-package-agreements
wsl --install
ctrl2cap /install
```
