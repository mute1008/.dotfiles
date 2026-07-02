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
      # --impure 前提。system/USER/HOME を実行マシンから取るので username を固定せず、
      # 任意の Linux ユーザーでもそのまま通る。
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
