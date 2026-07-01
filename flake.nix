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
      lib = nixpkgs.lib;

      # --impure 実行時に「コマンドを打ったマシン」から自動取得する。
      # これによりプラットフォームもユーザーも固定せず、全マシン共通の1コマンドで済む。
      #   home-manager switch --flake ~/.dotfiles#default --impure
      system = builtins.currentSystem;

      # mac か linux(WSL) かを system 名から自動判定してモジュールを選ぶ
      module =
        if lib.hasInfix "darwin" system
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
