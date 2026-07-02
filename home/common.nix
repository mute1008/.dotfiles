{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  # 実行ユーザーから解決（--impure 前提）。マシンごとの username 固定を避ける。
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.packages = with pkgs; [
    zsh
    git
    ripgrep
    neovim
    trash-cli
    coreutils
    findutils
    binutils
  ];

  home.file = {
    ".zshrc".source = link "app/zsh/zshrc";
    ".gitconfig".source = link "app/git/gitconfig";
    ".tmux.conf".source = link "app/tmux/tmux.conf";
    ".ssh/config".source = link "app/ssh/config";
    ".ideavimrc".source = link "app/intellij/ideavimrc";
  };
  xdg.configFile."nvim".source = link "app/nvim";
  xdg.configFile."mise/config.toml".source = link "app/mise/config.toml";

  # 言語ランタイムは Nix ではなく mise の担当。
  home.activation.miseBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "$HOME/.local/bin/mise" ]; then
      run ${pkgs.curl}/bin/curl -fsSL https://mise.run | run ${pkgs.bash}/bin/bash
    fi
    run "$HOME/.local/bin/mise" install
  '';
}
