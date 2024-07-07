{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        enlinksIdeapad = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/enlinksIdeapad/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        enlinksThinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/enlinksThinkpad/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        workPc = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/workPc/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
