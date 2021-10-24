{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "frece";
  version = "1.0.6";

  src = fetchFromGitHub {
    owner = "YodaEmbedding";
    repo = pname;
    rev = "v${version}";
    sha256 = "1p1pxf730jcr59n3fa1n7cqbqiv5wynm8iazdpm3mfsa7slqh208";
  };

  cargoSha256 = "0i89hiji1b9x830shc4slv56s5xdi89xs9shbba4p5zsnbbpvcvq";

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
