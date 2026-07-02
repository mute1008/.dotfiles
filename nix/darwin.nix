{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  imports = [ ./main.nix ];

  home.file.".aerospace.toml".source = link "config/aerospace/aerospace.toml";
  xdg.configFile = {
    "karabiner/karabiner.json".source = link "config/karabiner/karabiner.json";
    "sketchybar".source = link "config/aerospace/sketchybar";
  };

  # Karabiner-Elementsなどのアプリはnixpkgsでは不安定になってしまう
  # そのためnixpkgsを利用せずにここでインストールする
  home.activation.brewBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x /opt/homebrew/bin/brew ]; then
      export NONINTERACTIVE=1
      run ${pkgs.bash}/bin/bash -c "$(${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    ${pkgs.gnugrep}/bin/grep -E '^tap ' ${dotfiles}/config/brew/Brewfile \
      | ${pkgs.gnused}/bin/sed -E 's/^tap "([^"]+)".*/\1/' \
      | while read -r t; do
          run /opt/homebrew/bin/brew trust "$t" || true
        done
    run /opt/homebrew/bin/brew bundle --file=${dotfiles}/config/brew/Brewfile
  '';
}
