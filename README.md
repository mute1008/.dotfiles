# WSL (Ubuntu)
```sh
sudo apt update
sudo apt install -y zsh git neovim ripgrep trash-cli
```

# macOS
```sh
brew update
brew install zsh git neovim ripgrep trash-cli coreutils binutils findutils
```


# Windows
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
