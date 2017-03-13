#!/bin/bash
set -x

rm lorenz96
gfortran -O2 -o lorenz96 lorenz96.f95
