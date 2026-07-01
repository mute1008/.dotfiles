{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  imports = [ ./common.nix ];

  # Windows 側は symlink 不可なのでコピーで反映（switch 時のみ実行）。
  home.activation.windowsSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d /mnt/c/Users ]; then
      win_user=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
      if [ -n "$win_user" ] && [ -d "/mnt/c/Users/$win_user" ]; then
        run cp ${dotfiles}/app/intellij/files/ideavimrc "/mnt/c/Users/$win_user/.ideavimrc"
        run mkdir -p "/mnt/c/Users/$win_user/.glzr/glazewm"
        run cp ${dotfiles}/app/glazewm/files/config.yaml "/mnt/c/Users/$win_user/.glzr/glazewm/config.yaml"
        glazewm.exe command wm-reload-config >/dev/null 2>&1 || true
      fi
    fi
  '';
}
