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
      inherit (nixpkgs) lib;

      users.momo = {
        name = "momo";
        fullName = "Civi";
        email = "19486398+angribot@users.noreply.github.com";
        avatar = ./files/avatar.jpg;
        wallpaper = ./files/wallpaper.png;
      };

      hosts.moni = {
        username = "momo";
        system = "aarch64-darwin";
      };

      mkSpecialArgs = username: {
        userConfig = users.${username};
      };

      mkDarwinConfiguration =
        hostname:
        { username, ... }:
        darwin.lib.darwinSystem {
          specialArgs = mkSpecialArgs username;
          modules = [ ./hosts/${hostname} ];
        };

      mkHomeConfiguration =
        hostname:
        { system, username, ... }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = mkSpecialArgs username;
          modules = [
            ./home/${username}/${hostname}
            everforest.homeManagerModules.default
          ];
        };
    in
    {
      darwinConfigurations = lib.mapAttrs mkDarwinConfiguration hosts;

      homeConfigurations = lib.mapAttrs' (
        hostname: hostConfig:
        lib.nameValuePair "${hostConfig.username}@${hostname}" (mkHomeConfiguration hostname hostConfig)
      ) hosts;
    };
}
