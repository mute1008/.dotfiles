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

> **flake.lock について**: 再現性のため `flake.lock` をコミットで固定する。まだ無い場合は
> Nix 導入済みマシンで一度 `nix flake lock` を実行し、生成された `flake.lock` を commit すること
> （ローカルに Nix が無い環境では生成できない）。

構成:
- `flake.nix` … 入口。inputs=nixpkgs(24.11)+home-manager, outputs=`naoya@mac` / `mute@wsl`
- `home/common.nix` … mac/WSL 共通（CLI ツール + dotfiles リンク + mise 導入 hook）
- `home/darwin.nix` … macOS 固有（karabiner / aerospace / sketchybar）
- `home/wsl.nix` … WSL 固有（IdeaVim / GlazeWM を Windows 側へコピーする activation hook）
- `app/*/files/` … 既存の設定ファイル。Home Manager から実体を指すリンクで参照（従来の safe_ln と同じ挙動）

補足:
- 設定ファイル(`zshrc`, `nvim/init.lua` 等)の**中身の編集は switch 不要**でその場反映される（`mkOutOfStoreSymlink`）。switch が要るのは「入れるツールを変えた / flake・*.nix・activation hook を変えた」とき。
- **Windows 側への反映（IdeaVim・GlazeWM）は switch 実行時にのみコピーされる**。`config.yaml` を編集しただけでは反映されないので、変更後は `home-manager switch` を実行する。
- 言語ランタイム(python/node/go)は従来どおり mise の担当。バージョンは `app/mise/set.sh` / `mise.toml` 側で管理する。
- Windows アプリ本体(glazewm 等)の**導入**は Nix 管轄外（winget、下記参照）。Nix が扱うのは設定ファイルの配置のみ。

### install.sh との併存ルール
- **Nix を導入したマシンでは `install.sh` を実行しない**（dotfiles の所有を Home Manager に一本化するため）。
- `install.sh`（symlink 方式）は Nix 未導入マシン向けのフォールバックとして残す。
- 将来的には全マシンを Home Manager へ寄せる想定。

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
