{ config, pkgs, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  imports = [ ./common.nix ];

  # 設定リンク（本体は下の brew で導入）
  home.file.".aerospace.toml".source = link "app/aerospace/aerospace.toml";
  xdg.configFile = {
    "karabiner/karabiner.json".source = link "app/karabiner/karabiner.json";
    "sketchybar".source = link "app/aerospace/sketchybar";
  };

  # GUI アプリ(aerospace/karabiner/sketchybar)は Nix で扱えないため brew cask で導入。
  # 導入するものは home/Brewfile で宣言し、bundle で反映（初回は sudo を要求する）。
  home.activation.brewBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x /opt/homebrew/bin/brew ]; then
      export NONINTERACTIVE=1
      run ${pkgs.bash}/bin/bash -c "$(${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    run /opt/homebrew/bin/brew bundle --file=${dotfiles}/home/Brewfile
  '';
}
