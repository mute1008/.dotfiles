{
  description = "dotfiles — Home Manager (macOS + WSL)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = builtins.currentSystem;
      module =
        if nixpkgs.lib.hasInfix "darwin" system
        then ./nix/darwin.nix
        else ./nix/wsl.nix;
    in
    {
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [ "claude-code" ];
        };
        modules = [ module ];
      };
    };
}
