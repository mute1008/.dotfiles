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

  # username / homeDirectory は flake.nix 側で明示的に注入する（--impure 回避）。

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

  # 言語ランタイムの所有は従来どおり mise に委ねるが、mise 本体の導入だけは
  # switch に畳んでおく（冪等: 既に入っていれば何もしない）。これで新マシンでも
  # 「Nix 導入 → switch」だけで mise が使える状態になり、手順分岐を避けられる。
  # ランタイムのバージョン固定は app/mise/set.sh / mise.toml 側の責務。
  home.activation.miseBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "$HOME/.local/bin/mise" ]; then
      run ${pkgs.curl}/bin/curl -fsSL https://mise.run | run ${pkgs.bash}/bin/bash
    fi
  '';
}
