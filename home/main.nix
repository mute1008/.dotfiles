{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.packages = with pkgs; [
    zsh
    git
    ripgrep
    neovim
    tmux
    mise
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

  home.activation.miseInstall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.mise}/bin/mise install
  '';
}
