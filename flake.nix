{
  description = "Flake utils demo";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "foo";
          src = ./src;
          buildPhase = ''
            mkdir -p $out/bin
            cp $src/foo $out/bin/foo
            chmod +x $out/bin/foo
          '';
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [ packages.default ];
        };
      }
    );
}
