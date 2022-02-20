{
  config,
  pkgs,
  pythonPackages,
  ...
}:

with pkgs;
rec {
  arxiv = with pythonPackages;
    pkgs.callPackage ./arxiv {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        feedparser
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

  pytorch-msssim = with pythonPackages;
    pkgs.callPackage ./pytorch-msssim {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        pytorch
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
