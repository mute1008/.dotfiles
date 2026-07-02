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
      isDarwin = nixpkgs.lib.hasInfix "darwin" system;
      isWSL = builtins.getEnv "WSL_DISTRO_NAME" != "";
      module =
        if isDarwin then ./nix/darwin.nix
        else if isWSL then ./nix/wsl.nix
        else ./nix/linux.nix;
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
