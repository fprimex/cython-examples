# About

This directory contains examples of speeding up Python using C and Cython.
For reference and comparison, the original Fortran and Matlab code for this
model is provided.

Original Matlab and Fortran code provided by Celestine Woodruff. Other ports
done by Brent Woodruff. The program solves the Lorenz 96 climate model, which
displays long term chaotic behavior.

Note that the Fortran, Python, Cython, and C code ports do not record their
output. These ports were made just for demonstration and run time comparisons.

# List of directories/examples

* matlab: original m code. extremely slow. running not suggested. reference only
* fortran: port to fortran. good reference for speed comparison. very fast
* python: port of m code to python. also slow
* cython: python with the main solving routine moved to cython in pyx file. fast
* cython\_c: python calls a cython wrapper to a C routine. fastest

# Building some of the examples

The Fortran, Cython, and Cython\_c versions require that extensions and code be
compiled. There is a script in each of these directories called 'rebuild.sh'.
Change to the directory of the code you wish to rebuild and run ./rebuild.sh
to remove any previous compilation and rebuild the required extensions.
