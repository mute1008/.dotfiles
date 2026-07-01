{ config, pkgs, lib, ... }:

{
  imports = [ ./common.nix ];

  # username / homeDirectory は common.nix で環境から自動取得する

  # WSL 固有の追加設定があればここに書く。
  # Windows 本体側(glazewm 等)は Nix 管轄外のため windows/ で別管理する。
}
