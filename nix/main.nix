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
    tmuxPlugins.resurrect
    tmuxPlugins.continuum
    mise
    trash-cli
    coreutils
    findutils
    binutils
    claude-code
    devcontainer
  ];

  home.file = {
    ".zshrc".source = link "config/zsh/zshrc";
    ".gitconfig".source = link "config/git/gitconfig";
    ".tmux.conf".source = link "config/tmux/tmux.conf";
    ".local/bin/tmux-resurrect-save-safe" = {
      source = link "config/tmux/resurrect-save-safe.sh";
    };
    ".local/bin/tmux-resurrect-restore-safe" = {
      source = link "config/tmux/resurrect-restore-safe.sh";
    };
    ".ssh/config".source = link "config/ssh/config";
    ".ideavimrc".source = link "config/intellij/ideavimrc";
  };
  xdg.configFile."nvim".source = link "config/nvim";
  xdg.configFile."mise/config.toml".source = link "config/mise/config.toml";

  home.activation.miseInstall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.mise}/bin/mise install
  '';
}
