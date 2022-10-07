# makeMachineConfig = defaultUser: hostname:
#   nixpkgs.lib.nixosSystem {
#     inherit system;
#     modules = [/home/d/code/repos/dotfiles/nixos/machines/import-machine.nix];
#     specialArgs = {inherit defaultUser hostname;};
#   };
# {
#   outputs = {
#     home-manager
#     , nixpkgs
#     , ...
#   }:
# }
