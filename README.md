# Nix (Home Manager)

macOS / WSL のセットアップを Home Manager に集約する。`switch` 一発で、CLI ツール・
dotfiles リンク・言語ランタイム・(mac)GUI アプリまで揃う。Windows ネイティブアプリ
(glazewm 本体等)だけは Nix で扱えないので winget（末尾）で入れる。

前提: このリポジトリは `~/.dotfiles` に clone してある。ログインシェルの zsh 本体だけは
OS のパッケージ管理で入れておく（`brew install zsh` / `apt install zsh` → `chsh`）。

```sh
# 1. Nix 本体を入れる（未導入の場合のみ）
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. 初回のみ: 既存の dotfiles を退避する。
#    既存の symlink や手置きの実ファイルが残っていると switch が
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

switch が何を担うか:

| 対象 | やり方 | どこ |
|---|---|---|
| CLI (git, neovim, ripgrep, trash-cli, coreutils, findutils, binutils) | 宣言 (`home.packages`) | `home/common.nix` |
| dotfiles リンク (zshrc, gitconfig, tmux, ssh, ideavim, nvim) | 宣言 (symlink) | `home/common.nix` |
| 言語ランタイム (python/node/go) | mise。バージョンは宣言、install は hook | `app/mise/config.toml` |
| mac GUI (aerospace, karabiner, sketchybar) | brew cask。リストは宣言、bundle は hook | `home/Brewfile` |
| Windows 側コピー (ideavim, glazewm) | WSL の activation hook | `home/wsl.nix` |
| Windows ネイティブアプリ本体 | winget（Nix で扱えない） | 末尾 |

メモ:
- 設定ファイルの中身編集は switch 不要（`mkOutOfStoreSymlink`）。switch が要るのはツール追加や `*.nix` 変更時。
- mac の GUI cask 導入は初回 `sudo` を要求する。Windows 側コピーは switch 時のみ反映される。

# Windows（ネイティブアプリ）
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
