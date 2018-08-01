{ fetchurl, stdenv, libtool, makeWrapper
, coreutils, ctags, ncurses, pythonPackages, sqlite, universal-ctags
}:

stdenv.mkDerivation rec {
  name = "global-${version}";
  version = "6.6.2";

  src = fetchurl {
    url = "mirror://gnu/global/${name}.tar.gz";
    sha256 = "0zvi5vxwiq0dy8mq2cgs64m8harxs0fvkmsnvi0ayb0w608lgij3";
  };

  nativeBuildInputs = [ libtool makeWrapper ];

  buildInputs = [ ncurses ];

  propagatedBuildInputs = [ pythonPackages.pygments ];

  configureFlags = [
    "--with-ltdl-include=${libtool}/include"
    "--with-ltdl-lib=${libtool.lib}/lib"
    "--with-ncurses=${ncurses.dev}"
    "--with-sqlite3=${sqlite.dev}"
    "--with-exuberant-ctags=${ctags}/bin/ctags"
    "--with-universal-ctags=${universal-ctags}/bin/ctags"
    "--with-posix-sort=${coreutils}/bin/sort"
  ];

  doCheck = true;

  postInstall = ''
    mkdir -p "$out/share/emacs/site-lisp"
    cp -v *.el "$out/share/emacs/site-lisp"

    wrapProgram $out/bin/gtags \
      --prefix PYTHONPATH : "$(toPythonPath ${pythonPackages.pygments})"
    wrapProgram $out/bin/global \
      --prefix PYTHONPATH : "$(toPythonPath ${pythonPackages.pygments})"
  '';

  meta = with stdenv.lib; {
    description = "Source code tag system";
    longDescription = ''
      GNU GLOBAL is a source code tagging system that works the same way
      across diverse environments (Emacs, vi, less, Bash, web browser, etc).
      You can locate specified objects in source files and move there easily.
      It is useful for hacking a large project containing many
      subdirectories, many #ifdef and many main() functions.  It is similar
      to ctags or etags but is different from them at the point of
      independence of any editor.  It runs on a UNIX (POSIX) compatible
      operating system like GNU and BSD.
    '';
    homepage = http://www.gnu.org/software/global/;
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ pSub peterhoeg ];
    platforms = platforms.unix;
  };
}
