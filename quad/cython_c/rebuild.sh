#!/bin/bash
set -x

rm *.o
rm *.so

export ARCHFLAGS="-arch x86_64"

python setup.py clean
gcc -O2 -Wall -fPIC -fopenmp -c quad_openmp.c 
python setup.py build_ext --inplace

