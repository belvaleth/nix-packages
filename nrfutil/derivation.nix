{ stdenv, lib, fetchurl, zlib, glibc, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "nrfutil";
  version = "7.0.1"; # Real version is unknown

  src = fetchurl {
    url = "https://developer.nordicsemi.com/.pc-tools/nrfutil/x64-linux/nrfutil";
    hash = "sha256-WITD1pjpAFUI57ZKWHBnV4aWfosU3Zaee/GwkVT8/qY=";
  };

  phases = [ "installPhase" ];

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ zlib glibc ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 -D $src $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.nordicsemi.com/Products/Development-tools/nRF-Util";
    description = "Unified command line utility for Nordic products";
    platforms = platforms.linux;
    maintainers = with maintainers; [ belvaleth ];
  };
}
