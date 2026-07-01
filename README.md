# Nix (Home Manager) — 試験導入

macOS / WSL の dotfiles と CLI ツールを宣言的に管理する。
言語ランタイム(python/node/go)は従来どおり mise の担当で、Nix では扱わない。
Windows 本体(glazewm 等)は Nix 管轄外のため別管理（winget 等）。

```sh
# 1. Nix 本体を入れる（未導入の場合のみ）
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. 反映（このリポジトリは ~/.dotfiles にある前提）
home-manager switch --flake ~/.dotfiles#naoya@mac    # macOS
home-manager switch --flake ~/.dotfiles#naoya@wsl    # WSL

# 世代の確認 / ロールバック
home-manager generations
home-manager switch --rollback
```

構成:
- `flake.nix` … 入口。inputs=nixpkgs+home-manager, outputs=mac/wsl 用の環境
- `home/common.nix` … mac/WSL 共通（CLI ツール + dotfiles リンク）
- `home/darwin.nix` / `home/wsl.nix` … OS 固有の差分
- `app/*/files/` … 既存の設定ファイル。Home Manager から実体を指すリンクで参照（従来の safe_ln と同じ挙動）

既存の `install.sh`（symlink 方式）は Nix 未導入環境向けに当面併存させる。

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
