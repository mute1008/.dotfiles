{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  imports = [ ./common.nix ];

  # 設定リンクのみ。アプリ本体(karabiner/aerospace)は Nix 管轄外。
  home.file.".aerospace.toml".source = link "app/aerospace/files/aerospace.toml";

  xdg.configFile = {
    "karabiner/karabiner.json".source = link "app/karabiner/files/karabiner.json";
    "sketchybar".source = link "app/aerospace/files/sketchybar";
  };
}
