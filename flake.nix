{
  description = "Helm lint config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs = { self, nixpkgs, utils, pre-commit-hooks }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              helmlint = {
                name = "helmlint";
                enable = true;
                entry = "./helmlint.sh";
                types = [ "yaml" ];
              };
            };
          };
        };
        devShell = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          packages = with pkgs; [
            kubernetes-helm
          ];
        };
      });
}

