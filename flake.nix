{
  description = "NixOS configuration of Feng";

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";
    home-manager.url = "git+https://gitee.com/mirrors/home-manager-nix";
    nixpkgs-stable.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";
    nixvim.url = "github:nix-community/nixvim";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    substituters = [
      "https://mirrors.nju.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    nixvim,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      thinkpad-t14 = let
        username = "feng";
        specialArgs = { inherit username; };
        system = "x86_64-linux";
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;

          modules = [
            ./hosts/thinkpad-t14

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
    };
  };
}
