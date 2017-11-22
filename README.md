# Dockerized MiKTeX

This image allows you to run MiKTeX on any computer that supports Docker.

## Obtaining the image

Get the latest image from the registry:

    docker pull miktex/miktex

or build it yourself:

    docker build --tag miktex/miktex .

## Using the image

### Prerequisites

The host directory containing the input files must be mounted to the
container path `/miktex/work`.

The container image contains a bare MiKTeX setup and MiKTeX is
configured to install missing files in the container directory
`/miktex/.miktex`.  It is recommended that you mount this directory to
a Docker volume.

### Example

First, create a Docker volume named `miktex`:

    docker volume create --name miktex

This volume should be used to mount the the container directory
`/miktex/.miktex` in subsequent runs.

Provided that your maininput file is located in the current working
directory, you can run `pdflatex` as follows:

    docker run -ti \
      -v miktex:/miktex/.miktex \
      -v `pwd`:/miktex/work \
      miktex/miktex \
      pdflatex main.tex
