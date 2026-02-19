{
  description = "momo nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nix-darwin
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Global catppuccin theme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim nightly
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # neovim tree-sitter-norg
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };

  outputs =
    {
      self,
      darwin,
      catppuccin,
      home-manager,
      nixpkgs,
      neovim-nightly-overlay,
      neorg-overlay,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      nixpkgsConfig = {
        allowUnfree = true;
      };
      # Define user configurations
      users = {
        momo = {
          avatar = ./files/avatar.jpg;
          wallpaper = ./files/wallpaper.png;
          email = "civi@rcg.fun";
          fullName = "Civi";
          gitKey = "94DC09E76258468C";
          name = "momo";
        };
      };
      # Function for NixOS system configuration
      mkNixosConfiguration =
        username: hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            { nixpkgs.config = nixpkgsConfig; }
            ./hosts/${hostname}
          ];
        };
      # Function for nix-darwin system configuration
      mkDarwinConfiguration =
        username: hostname:
        darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            darwinModules = "${self}/modules/darwin";
          };
          modules = [
            { nixpkgs.config = nixpkgsConfig; }
            ./hosts/${hostname}
          ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgsConfig;
            overlays = [
              neovim-nightly-overlay.overlays.default
              neorg-overlay.overlays.default
            ];
          };
          extraSpecialArgs = {
            inherit inputs outputs;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}/${hostname}
            # everforest.homeModules.everforest
            catppuccin.homeModules.catppuccin
          ];
        };
    in
    {
      nixosConfigurations = {
        "nixos" = mkNixosConfiguration "momo" "nixos";
      };

      darwinConfigurations = {
        "moni" = mkDarwinConfiguration "momo" "moni";
      };

      homeConfigurations = {
        "momo@moni" = mkHomeConfiguration "aarch64-darwin" "momo" "moni";
      };
    };
}
