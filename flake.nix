{
  description = "naoya's dotfiles — Home Manager (macOS + WSL)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
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
      # home-manager switch --flake ~/.dotfiles#naoya@mac
      # home-manager switch --flake ~/.dotfiles#mute@wsl
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
