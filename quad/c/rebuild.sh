#!/bin/bash
set -x

rm quad_openmp

gcc -O2 -Wall -fPIC -fopenmp -o quad_openmp quad_openmp.c 

