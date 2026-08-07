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
      url = "github:AkinoYuiko/everforest-darwin";
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
      userConfig = {
        name = "momo";
        fullName = "Civi";
        email = "19486398+angribot@users.noreply.github.com";
        avatar = ./files/avatar.jpg;
        wallpaper = ./files/wallpaper.png;
      };
    in
    {
      darwinConfigurations.moni = darwin.lib.darwinSystem {
        specialArgs = { inherit userConfig; };
        modules = [ ./modules/darwin.nix ];
      };

      homeConfigurations."momo@moni" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        extraSpecialArgs = { inherit userConfig; };
        modules = [
          ./modules/home.nix
          everforest.homeManagerModules.default
        ];
      };
    };
}
