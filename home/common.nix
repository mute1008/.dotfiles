{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  # safe_ln 相当。Nix store にコピーせず作業ディレクトリの実体を指すので編集が即反映される。
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  # username / homeDirectory は flake.nix で注入。

  home.packages = with pkgs; [
    ripgrep
    neovim
    trash-cli
    coreutils
    findutils
    binutils
  ];

  home.file = {
    ".zshrc".source = link "app/zsh/files/zshrc";
    ".gitconfig".source = link "app/git/files/gitconfig";
    ".tmux.conf".source = link "app/tmux/files/tmux.conf";
    ".ssh/config".source = link "app/ssh/files/config";
    ".ideavimrc".source = link "app/intellij/files/ideavimrc";
  };
  xdg.configFile."nvim".source = link "app/nvim/files";

  # ランタイムは mise 管理のまま、mise 本体の導入だけ switch に畳む（冪等）。
  home.activation.miseBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "$HOME/.local/bin/mise" ]; then
      run ${pkgs.curl}/bin/curl -fsSL https://mise.run | run ${pkgs.bash}/bin/bash
    fi
  '';
}
