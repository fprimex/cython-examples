#!/bin/bash
set -x

rm *.o
rm *.so

export CC=gcc-4.2
export ARCHFLAGS="-arch x86_64"

python setup.py clean
$CC -O2 -Wall -fPIC -c lorenz96_solver.c
python setup.py build_ext --inplace
