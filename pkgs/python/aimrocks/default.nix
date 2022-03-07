{ lib
, buildPythonPackage
, fetchFromGitHub
, cython
, setuptools
, rocksdb
, bzip2
, lz4
, snappy
, zlib
, zstd
, pytest
}:

buildPythonPackage rec {
  pname = "aimrocks";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "aimhubio";
    repo = "${pname}";
    rev = "19e39102cdcee3a65088af8a181ffa5288df39e5";
    sha256 = "sha256-L2ds58ggieADsSE9pggDiYcViUHmYnnPqsVaNLG3OcM=";
  };

  nativeBuildInputs = [
    cython
    setuptools
    rocksdb
    bzip2
    lz4
    snappy
    zlib
    zstd
  ];

  propagatedBuildInputs = [
    cython
    setuptools
    rocksdb
    bzip2
    lz4
    snappy
    zlib
    zstd
  ];

  checkInputs = [
    pytest
  ];

  doCheck = false;

  postUnpack = ''
    third_party_libs="$(echo \
      '[' \
      '"${rocksdb.out}/lib/librocksdb.so", ' \
      '"${snappy.out}/lib/libsnappy.so", ' \
      '"${bzip2.out}/lib/libbz2.so", ' \
      '"${zlib.out}/lib/libz.so", ' \
      '"${lz4.out}/lib/liblz4.so", ' \
      '"${zstd.out}/lib/libzstd.so", ' \
      ']' \
    )"

    third_party_headers='["${rocksdb.out}/include/rocksdb"]'

    sed -i \
      -e "s:third_party_libs = .*:third_party_libs = $third_party_libs:" \
      -e "s:third_party_headers = .*:third_party_headers = $third_party_headers:" \
      -e "s:'Cython==.*':'Cython>=0.29.24':" \
      "$sourceRoot/setup.py"
  '';

  meta = with lib; {
    description = "Python wrapper for RocksDB";
    homepage = "https://github.com/aimhubio/aimrocks";
    maintainers = [
      {
        email = "mulhaq2005@gmail.com";
        github = "YodaEmbedding";
        githubId = 721196;
        name = "Mateen Ulhaq";
      }
    ];
  };
}
