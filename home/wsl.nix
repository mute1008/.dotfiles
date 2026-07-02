{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  imports = [ ./main.nix ];

  # Windows FS は symlink 不可なのでコピー（best-effort）。
  home.activation.windowsSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    _windowsSync() {
      [ -d /mnt/c/Users ] || return 0
      user=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
      [ -n "$user" ] && [ -d "/mnt/c/Users/$user" ] || return 0
      cp ${dotfiles}/app/intellij/ideavimrc "/mnt/c/Users/$user/.ideavimrc" || return 1
      mkdir -p "/mnt/c/Users/$user/.glzr/glazewm" || return 1
      cp ${dotfiles}/app/glazewm/config.yaml "/mnt/c/Users/$user/.glzr/glazewm/config.yaml" || return 1
      glazewm.exe command wm-reload-config >/dev/null 2>&1 || true
    }
    _windowsSync || echo "windowsSync: コピーに失敗（Windows 側は手動確認）"
  '';

  home.activation.wingetSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    _wingetSync() {
      command -v wslpath >/dev/null 2>&1 || return 0
      user=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
      [ -n "$user" ] || return 0
      winget="/mnt/c/Users/$user/AppData/Local/Microsoft/WindowsApps/winget.exe"
      [ -e "$winget" ] || return 0
      "$winget" import -i "$(wslpath -w ${dotfiles}/home/winget.json)" \
        --accept-package-agreements --accept-source-agreements --ignore-unavailable
    }
    _wingetSync || echo "wingetSync: 一部失敗（Windows 側は手動確認）"
  '';
}
