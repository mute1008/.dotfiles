{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  imports = [ ./main.nix ];

  home.file.".aerospace.toml".source = link "app/aerospace/aerospace.toml";
  xdg.configFile = {
    "karabiner/karabiner.json".source = link "app/karabiner/karabiner.json";
    "sketchybar".source = link "app/aerospace/sketchybar";
  };

  # Karabiner-Elementsなどのアプリはnixpkgsでは不安定になってしまう
  # そのためnixpkgsを利用せずにここでインストールする
  home.activation.brewBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x /opt/homebrew/bin/brew ]; then
      export NONINTERACTIVE=1
      run ${pkgs.bash}/bin/bash -c "$(${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    run /opt/homebrew/bin/brew bundle --file=${dotfiles}/app/brew/Brewfile
  '';
}
