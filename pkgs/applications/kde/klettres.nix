{ mkDerivation, lib, extra-cmake-modules, kdoctools, ki18n, kio, phonon, knewstuff }:

mkDerivation {
  name = "klettres";
  meta = with lib; {
    homepage = "https://kde.org/applications/en/utilities/org.kde.klettres";
    description = "KLettres is an application specially designed to help the user to learn an alphabet";
    maintainers = with maintainers; [ freezeboy ];
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
  nativeBuildInputs = [
    extra-cmake-modules
  ];
  buildInputs = [
    phonon
    knewstuff
    kdoctools
    ki18n
    kio
  ];
}
