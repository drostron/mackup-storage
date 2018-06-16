self: super:
let
  buildRustPackage =
    { name, cargoSha256 ? "unset"
    , src ? null
    , srcs ? null
    , sourceRoot ? null
    , logLevel ? ""
    , buildInputs ? []
    , cargoUpdateHook ? ""
    , cargoDepsHook ? ""
    , cargoBuildFlags ? []

    , cargoVendorDir ? null
    , ... } @ args:
    with super; (rustPlatform.buildRustPackage args).overrideAttrs (attrs: {
      # Remove `--frozen` flag, since it's tripping up the pijul build
      buildPhase = with builtins; args.buildPhase or ''
        runHook preBuild
        echo "Running cargo build --release ${concatStringsSep " " cargoBuildFlags}"
        cargo build --release ${concatStringsSep " " cargoBuildFlags}
        runHook postBuild
      '';
    });
in {
  # From https://github.com/NixOS/nixpkgs/pull/40622
  pijul = with super; buildRustPackage rec {
    name = "pijul-${version}";
    version = "0.10.0";

    src = fetchurl {
      url = "https://pijul.org/releases/${name}.tar.gz";
      sha256 = "1lkipcp83rfsj9yqddvb46dmqdf2ch9njwvjv8f3g91rmfjcngys";
    };

    nativeBuildInputs = [ pkgconfig ];

    buildInputs = [ libsodium openssl ] ++
      stdenv.lib.optionals stdenv.isDarwin
        (with darwin.apple_sdk.frameworks; [ Security ]);

    doCheck = false;

    cargoSha256 = "1419mlxa4p53hm5qzfd1yi2k0n1bcv8kaslls1nyx661vknhfamw";

    meta = with stdenv.lib; {
      description = "A distributed version control system";
      homepage = https://pijul.org;
      license = with licenses; [ gpl2Plus ];
      maintainers = [ maintainers.gal_bolle ];
      platforms = platforms.all;
    };
  };
}
