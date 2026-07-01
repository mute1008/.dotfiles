{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  imports = [ ./common.nix ];

  # username / homeDirectory は flake.nix 側で注入する。

  # Windows 側への同期（旧 app/intellij/set.sh・app/glazewm/set.sh の置き換え）。
  # Windows のファイルシステムは symlink を扱えないため、mkOutOfStoreSymlink ではなく
  # 従来どおり「コピー」で反映する。activation なので switch 実行時にのみ走る
  # （＝旧 install.sh 実行時と同じタイミング。config.yaml を編集しただけでは反映されない点に注意）。
  home.activation.windowsSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d /mnt/c/Users ]; then
      win_user=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
      if [ -n "$win_user" ] && [ -d "/mnt/c/Users/$win_user" ]; then
        # IdeaVim
        run cp ${dotfiles}/app/intellij/files/ideavimrc "/mnt/c/Users/$win_user/.ideavimrc"

        # GlazeWM（設定コピー後に reload。glazewm.exe が PATH に無くても失敗させない）
        run mkdir -p "/mnt/c/Users/$win_user/.glzr/glazewm"
        run cp ${dotfiles}/app/glazewm/files/config.yaml "/mnt/c/Users/$win_user/.glzr/glazewm/config.yaml"
        glazewm.exe command wm-reload-config >/dev/null 2>&1 || true
      fi
    fi
  '';
}
