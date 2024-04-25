{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nrf-udev";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "NordicSemiConductor";
    repo = "nrf-udev";
    rev = "refs/tags/v${version}";
    sha256 = "bEIAsz9ZwX6RTzhv5/waFZ5a3KlnwX4kQs29+475zN0=";
  };

  installPhase = ''
    install -D nrf-udev_1.0.1-all/lib/udev/rules.d/71-nrf.rules $out/lib/udev/rules.d/71-nrf.rules
    install -D nrf-udev_1.0.1-all/lib/udev/rules.d/99-mm-nrf-blacklist.rules $out/lib/udev/rules.d/99-mm-nrf-blacklist.rules
  '';

  meta = with lib; {
  description = "udev rules for Nordic products";
  homepage = "https://github.com/NordicSemiconductor/nrf-udev";
  platforms = platforms.unix;
  maintainers = with maintainers; [ belvaleth ];
  };
}
