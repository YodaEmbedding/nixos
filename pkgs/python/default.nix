{
  config,
  pkgs,
  pythonPackages,
  ...
}:

with pkgs;
rec {

  aim = with pythonPackages;
    pkgs.callPackage ./aim {
      inherit
        lib
        buildPythonPackage
        fetchFromGitHub
        fetchPypi
        cython
        aimrecords
        aimrocks
        cachetools
        click
        cryptography
        filelock
        GitPython
        numpy
        packaging
        protobuf
        psutil
        py3nvml
        RestrictedPython
        tqdm
        aiofiles
        alembic
        async-exit-stack
        async_generator
        fastapi
        jinja2
        pytz
        sqlalchemy
        uvicorn
        pillow
        grpcio
        pytest
        ;
    };

  aimrecords = with pythonPackages;
    pkgs.callPackage ./aimrecords {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        base58
        ;
    };

  aimrocks = with pythonPackages;
    pkgs.callPackage ./aimrocks {
      inherit
        lib
        buildPythonPackage
        fetchFromGitHub
        cython
        setuptools
        pytest
        ;
      rocksdb = pkgs.rocksdb;
      bzip2   = pkgs.bzip2;
      lz4     = pkgs.lz4;
      snappy  = pkgs.snappy;
      zlib    = pkgs.zlib;
      zstd    = pkgs.zstd;
    };

  arxiv = with pythonPackages;
    pkgs.callPackage ./arxiv {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        feedparser
        ;
    };

  async-exit-stack = with pythonPackages;
    pkgs.callPackage ./async-exit-stack {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        ;
    };

  async-generator = with pythonPackages;
    pkgs.callPackage ./async-generator {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        ;
    };

  catalyst = with pythonPackages;
    pkgs.callPackage ./catalyst {
      inherit
        lib
        buildPythonPackage
        fetchFromGitHub
        fetchPypi
        hydra-slayer
        numpy
        pytest
        pytorch
        pyyaml
        tensorboardx
        tqdm
        ;
    };

  compressai = with pythonPackages;
    pkgs.callPackage ./compressai {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        matplotlib
        numpy
        pillow
        pybind11
        pytest
        pytorch
        pytorch-msssim
        scipy
        torchvision
        ;
    };

  hydra-slayer = with pythonPackages;
    pkgs.callPackage ./hydra-slayer {
      inherit lib buildPythonPackage fetchPypi pytest;
    };

  metadata-filter = with pythonPackages;
    pkgs.callPackage ./metadata-filter {
      inherit lib buildPythonPackage fetchPypi;
    };

  mlflow_python = with pythonPackages;
    pkgs.callPackage ./mlflow {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        isPy27
        fetchpatch
        alembic
        click
        cloudpickle
        requests
        six
        flask
        numpy
        pandas
        python-dateutil
        protobuf
        GitPython
        pyyaml
        querystring_parser
        simplejson
        docker
        databricks-cli
        entrypoints
        sqlparse
        sqlalchemy
        gorilla
        gunicorn
        prometheus-flask-exporter
        importlib-metadata
        ;
    };

  mpris2 = with pythonPackages;
    pkgs.callPackage ./mpris2 {
      inherit lib buildPythonPackage fetchPypi dbus-python;
    };

  py3nvml = with pythonPackages;
    pkgs.callPackage ./py3nvml {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        cudatoolkit
        xmltodict
        ;
    };

  pytorch-msssim = with pythonPackages;
    pkgs.callPackage ./pytorch-msssim {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        pytorch
        ;
    };

  RestrictedPython = with pythonPackages;
    pkgs.callPackage ./RestrictedPython {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        ;
    };

  scrobblez = with pythonPackages;
    pkgs.callPackage ./scrobblez {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        metadata-filter
        mpris2
        pylast
        pyxdg
        setuptools
        ;
      };
}
