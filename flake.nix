{
  description = "naoya's dotfiles — Home Manager (macOS + WSL)";

  inputs = {
    # パッケージ集合。24.11 リリースブランチに固定し、flake.lock で厳密にピンする。
    # （unstable は追従が速く、マシン/時期でバージョンがばらけるため避ける）
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # dotfiles / CLI ツールを宣言的に管理する層
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # home-manager が使う nixpkgs を上の inputs に揃える（バージョンの二重管理を防ぐ）
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # 環境(username / homeDirectory / OSモジュール)を明示して構成を1つ作るヘルパー。
      # builtins.getEnv / currentSystem を使わないので --impure が不要になり、
      # flake.lock による再現性がそのまま効く。
      mk = { system, module, username, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            module
            { home.username = username; home.homeDirectory = homeDirectory; }
          ];
        };
    in
    {
      # マシンごとに明示。switch 時にラベルで選ぶ（--impure 不要）:
      #   home-manager switch --flake ~/.dotfiles#naoya@mac
      #   home-manager switch --flake ~/.dotfiles#mute@wsl
      homeConfigurations = {
        "naoya@mac" = mk {
          system = "aarch64-darwin";
          module = ./home/darwin.nix;
          username = "naoya";
          homeDirectory = "/Users/naoya";
        };
        "mute@wsl" = mk {
          system = "x86_64-linux";
          module = ./home/wsl.nix;
          username = "mute";
          homeDirectory = "/home/mute";
        };
      };
    };
}
