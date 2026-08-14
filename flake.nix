{
  description = "momo nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    everforest = {
      url = "github:angribot/everforest-darwin";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      darwin,
      everforest,
      home-manager,
      nixpkgs,
      ...
    }:
    let
      system = "aarch64-darwin";
      userConfig = {
        name = "momo";
        fullName = "Civi";
        email = "19486398+angribot@users.noreply.github.com";
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import ./overlays/oxlint.nix) ];
      };
    in
    {
      darwinConfigurations.moni = darwin.lib.darwinSystem {
        specialArgs = { inherit userConfig; };
        modules = [ ./modules/darwin.nix ];
      };

      homeConfigurations."momo@moni" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit userConfig; };
        modules = [
          ./modules/home.nix
          everforest.homeManagerModules.default
        ];
      };
    };
}
