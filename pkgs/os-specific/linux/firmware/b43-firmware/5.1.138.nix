{ lib, stdenv, fetchurl, b43FirmwareCutter }:

let version = "5.100.138"; in

stdenv.mkDerivation {
  pname = "b43-firmware";
  inherit version;

  src = fetchurl {
    url = "http://www.lwfinger.com/b43-firmware/broadcom-wl-${version}.tar.bz2";
    sha256 = "0vz4ka8gycf72gmnaq61k8rh8y17j1wm2k3fidxvcqjvmix0drzi";
  };

  buildInputs = [ b43FirmwareCutter ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/lib/firmware
    b43-fwcutter -w $out/lib/firmware linux/wl_apsta.o
  '';

  meta = {
    description = "Firmware for cards supported by the b43 kernel module";
    homepage = "http://wireless.kernel.org/en/users/Drivers/b43";
    license = lib.licenses.unfree;
  };
}

