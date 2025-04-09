{
  description = "Breseq shell (nix develop)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachSystem
      [
        "aarch64-darwin"
        "x86_64-linux"
      ]
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          packages.default = pkgs.callPackage ./derivation.nix { };
          devShells.default = pkgs.mkShell {
            packages = [
              self.packages.${system}.default
            ];
          };
        }
      );
}
