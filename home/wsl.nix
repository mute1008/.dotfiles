{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  imports = [ ./common.nix ];

  # Windows FS は symlink 不可なのでコピー。ステップ全体を任意扱いにし、interop 不在は
  # 静かにスキップ、コピー失敗は警告（switch 本体は止めない）。
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
}
