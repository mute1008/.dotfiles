# Nix (Home Manager) — 試験導入

macOS / WSL の dotfiles と CLI ツールを宣言的に管理する。
言語ランタイム(python/node/go)は従来どおり mise の担当で、Nix では扱わない。
Windows 本体(glazewm 等)は Nix 管轄外のため別管理（winget 等）。

前提: このリポジトリは `~/.dotfiles` に clone してある。

```sh
# 1. Nix 本体を入れる（未導入の場合のみ）
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. 初回のみ: 既存の dotfiles を退避する。
#    install.sh 由来の symlink や手置きの実ファイルが残っていると switch が
#    "would be clobbered" で止まるため。(`-b backup` でも回避できるがこちらが確実)
for f in ~/.zshrc ~/.gitconfig ~/.tmux.conf ~/.ssh/config ~/.ideavimrc; do
  [ -e "$f" ] && mv "$f" "$f.pre-hm"
done
[ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.pre-hm

# 3. 反映（マシンに対応するラベルを選ぶ。--impure は不要）
home-manager switch --flake ~/.dotfiles#naoya@mac    # macOS
home-manager switch --flake ~/.dotfiles#mute@wsl     # WSL

# 世代の確認 / ロールバック
home-manager generations
home-manager switch --rollback
```

`flake.lock` は Nix 導入済みマシンで `nix flake lock` して commit する（未導入環境では生成不可）。

構成:
- `flake.nix` … outputs=`naoya@mac` / `mute@wsl`
- `home/common.nix` … 共通（CLI ツール + dotfiles リンク + mise 導入 hook）
- `home/darwin.nix` … macOS 固有（karabiner / aerospace / sketchybar）
- `home/wsl.nix` … WSL 固有（IdeaVim / GlazeWM を Windows 側へコピー）

メモ:
- 設定ファイルの中身編集は switch 不要（`mkOutOfStoreSymlink`）。switch が要るのはツール追加や `*.nix` 変更時。
- Windows 側へのコピーは switch 時のみ。`config.yaml` 変更後は `home-manager switch` する。
- Nix 導入マシンでは `install.sh` を実行しない（所有を Home Manager に一本化）。install.sh は未導入マシン用に残す。

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
