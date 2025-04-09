{ stdenv, lib, fetchFromGitHub,
libz,
autoconf,
automake,
libtool,
perl}:

stdenv.mkDerivation rec {
    name = "breseq-${version}";
    version = "0.39.0";

    src = fetchFromGitHub {
        owner = "barricklab";
        repo = "breseq";
        rev = "v${version}";
        sha256 = "DsDX2oGn7Ex50Wnp1phJjCziCzZIeeZOHriUGJbejsk=";
    };

    buildInputs = [
        perl
        libz
        autoconf
        automake
        libtool
    ];

  buildPhase = ''
    ./bootstrap.sh
    ./configure --prefix=$out --silent
    make -s
  '';

  meta = with lib; {
    description = "A computational pipeline for finding mutations relative to a reference sequence in short-read DNA re-sequencing data.";
    homepage = "https://github.com/barricklab/breseq";
    license = with lib.licenses; [ gpl2 gpl3 ];
    maintainers = with maintainers; [ croots ];
    platforms = platforms.all;
    };
}
