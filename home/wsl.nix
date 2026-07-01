{ config, pkgs, lib, ... }:

{
  imports = [ ./common.nix ];

  # WSL(Ubuntu) のユーザー名に合わせて調整すること
  home.username = "naoya";
  home.homeDirectory = "/home/naoya";

  # WSL 固有の追加設定があればここに書く。
  # Windows 本体側(glazewm 等)は Nix 管轄外のため windows/ で別管理する。
}
