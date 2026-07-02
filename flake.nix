{
  description = "dotfiles — Home Manager (macOS + WSL)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = builtins.currentSystem;
      module =
        if nixpkgs.lib.hasInfix "darwin" system
        then ./home/darwin.nix
        else ./home/wsl.nix;
    in
    {
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ module ];
      };
    };
}
