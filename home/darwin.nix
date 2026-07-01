{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  imports = [ ./common.nix ];

  # username / homeDirectory は flake.nix 側で注入する。

  # macOS 固有の dotfiles（GUI アプリの設定リンク）。
  # アプリ本体(karabiner-elements / aerospace)は Nix 管轄外で、
  # 将来 nix-darwin の homebrew モジュールに寄せる想定。ここは設定のリンクのみ。
  home.file.".aerospace.toml".source = link "app/aerospace/files/aerospace.toml";

  xdg.configFile = {
    "karabiner/karabiner.json".source = link "app/karabiner/files/karabiner.json";
    "sketchybar".source = link "app/aerospace/files/sketchybar";
  };
}
