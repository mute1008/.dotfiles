{
  description = "naoya's dotfiles — Home Manager (macOS + WSL)";

  inputs = {
    # パッケージ集合。nixpkgs のこのブランチを追従する（flake.lock でバージョン固定）
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # dotfiles / CLI ツールを宣言的に管理する層
    home-manager = {
      url = "github:nix-community/home-manager";
      # home-manager が使う nixpkgs を上の inputs に揃える（バージョンの二重管理を防ぐ）
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # 環境を1つ組み立てるヘルパー。system(CPU/OS) と module(構成) を渡す
      mkHome = { system, module }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ module ];
        };
    in
    {
      # `home-manager switch --flake .#<名前>` で選ぶ環境たち
      homeConfigurations = {
        # macOS (Apple Silicon)
        "naoya@mac" = mkHome {
          system = "aarch64-darwin";
          module = ./home/darwin.nix;
        };

        # WSL (Ubuntu)
        "naoya@wsl" = mkHome {
          system = "x86_64-linux";
          module = ./home/wsl.nix;
        };
      };
    };
}
