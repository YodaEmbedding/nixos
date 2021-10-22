{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "frece";
  version = "1.0.6";

  src = fetchFromGitHub {
    owner = "YodaEmbedding";
    repo = pname;
    rev = "v${version}";
    sha256 = lib.fakeSha256;
  };

  cargoSha256 = lib.fakeSha256;

  meta = with lib; {
    description = "Frecency sorted database";
    homepage = "https://github.com/YodaEmbedding/frece";
    license = licenses.mit;
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
