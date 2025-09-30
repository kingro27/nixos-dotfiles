{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #obsidian-nvim.url = "github:epwalsh/obsidian.nvim";

    nvf = {
        url = "github:NotAShelf/nvf";
        inputs.nixpkgs.follows = "nixpkgs";
        #inputs.obsidian-nvim.follows = "obsidian-nvim";
      };
  };

  outputs = inputs@{ nixpkgs, home-manager, nvf, ... }: {

    nixosConfigurations = {
      TARDIS = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

          nvf.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.doctor = import ./home.nix;
          }
        ];
      };
    };
  };
}

