{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    namaka = {
      url = "github:nix-community/namaka/v0.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, namaka, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake.checks = namaka.lib.load {
        src = ./tests;
        inputs = {
          utf8 = import ../.;
        };
      };

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = { inputs', pkgs, ... }:
        let
          rust = inputs'.fenix.packages.minimal.toolchain;
          rustPlatform = pkgs.makeRustPlatform {
            cargo = rust;
            rustc = rust;
          };
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [
              inputs'.namaka.packages.default
            ];
          };

          packages.default = rustPlatform.buildRustPackage {
            pname = "utf8-gen";
            version = "0.1.0";
            src = ./.;
            cargoLock.lockFile = ./Cargo.lock;
          };
        };
    };
}
