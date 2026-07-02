# dotfiles

macOS / WSL の設定を Home Manager で管理する。CLI ツール・dotfiles・言語ランタイム(mise)・
mac の GUI アプリ(brew) は `switch` で入る。Windows ネイティブアプリだけは winget（下記）。

## セットアップ

1. Nix を入れる: https://nixos.org/download/
2. このリポジトリを `~/.dotfiles` に clone する
3. zsh をログインシェルにする（zsh 本体は OS 側で入れて `chsh`）
4. 適用（`--impure` は system と USER/HOME を実行環境から取るため）:

   ```sh
   home-manager switch --flake ~/.dotfiles#default --impure
   ```

   既存ファイルがあって "would be clobbered" で止まる場合は `-b backup` を付ける。

## 更新・ロールバック

```sh
nix flake update                                       # input を更新
home-manager switch --flake ~/.dotfiles#default --impure
home-manager generations                               # 世代一覧
home-manager switch --rollback                         # 直前へ戻す
```

## Windows（ネイティブアプリ）

Nix は WSL 内から Windows アプリを入れられないので winget で。

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
