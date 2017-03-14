#!/bin/bash
set -x

rm *.o
rm *.so

python setup.py clean
gcc -O2 -Wall -fPIC -c lorenz96_solver.c
python setup.py build_ext --inplace
