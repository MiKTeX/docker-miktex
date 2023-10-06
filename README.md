# Dockerized MiKTeX

This image allows you to run MiKTeX on any computer that supports Docker.

## Example

Provided that your main input file is located in the current working directory,
you can run `pdflatex` as follows:

```sh
docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work -e MIKTEX_UID=`id -u` miktex/miktex:essential \
    pdflatex main.tex
```

## Tags

- 23.10-essential, essential (essential variant)
- 23.10-basic, basic (basic variant)

## Essential variant

The essential variant contains a bare MiKTeX system.

## Basic variant

The basic variant contains the basic package set.

## Volumes

### MiKTeX files

MiKTeX is configured to install missing package files in the container directory
`/var/lib/miktex`.

It is recommended that you mount this directory to a named Docker volume. This
ensures that data (such as downloaded packages) survives the container.

### Input files

The host directory containing the input files must be mounted to the container
path `/miktex/work`.

## User `miktex`

All commands inside the container are executed as user `miktex` and uid 1000.

It is possible to change the uid by setting the container environment variable
`MIKTEX_UID`.

To execute as the current user, you would pass option `-e MIKTEX_UID=$(id -u)`
to the Docker `run` command.
