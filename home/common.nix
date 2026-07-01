{ config, pkgs, lib, ... }:

let
  # このリポジトリの実体（作業ディレクトリ）へのパス
  dotfiles = "${config.home.homeDirectory}/.dotfiles";

  # 作業ディレクトリの実体を指す「ライブ」シンボリックリンクを作るヘルパー。
  # 通常の `.source = ./path` は Nix store にコピーしてしまい、編集後に switch し
  # 直すまで反映されない。mkOutOfStoreSymlink なら従来の safe_ln と同じく、
  # ~/.zshrc 等がこのリポジトリのファイルを直接指すので、その場の編集が即反映される。
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  # 初回導入時の home-manager バージョン基準（むやみに上げない）
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # ユーザー名 / ホームは固定せず、実行時の環境から取る（--impure 前提）。
  # これで「セットアップしたマシンの、そのユーザー」に対して設定が入る。
  # $HOME は mac=/Users/xxx, linux=/home/xxx に解決されるのでパス差も吸収される。
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # README の brew / apt で手動導入していた CLI ツール群をここに集約。
  # mac / WSL 共通。言語ランタイム(python/node/go)は mise の担当なので入れない。
  home.packages = with pkgs; [
    ripgrep
    neovim
    trash-cli
    coreutils
    findutils
    binutils
  ];

  # dotfiles のリンク（app/*/set.sh の safe_ln の置き換え）
  home.file = {
    ".zshrc".source = link "app/zsh/files/zshrc";
    ".gitconfig".source = link "app/git/files/gitconfig";
    ".tmux.conf".source = link "app/tmux/files/tmux.conf";
    ".ssh/config".source = link "app/ssh/files/config";
    ".ideavimrc".source = link "app/intellij/files/ideavimrc";
  };

  # ~/.config 以下（nvim は files/ ディレクトリごとリンク）
  xdg.configFile."nvim".source = link "app/nvim/files";
}
