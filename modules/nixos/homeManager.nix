{ inputs, ... }:

{
  home-manager = {
    # Also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "enlinks" = import ../homeManager/home.nix;
    };
  };
}
