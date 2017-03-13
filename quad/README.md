# About

This directory contains examples of speeding up Python using C and Cython.

All implementations perform intagrations using quadrature. The integration is
parallelized using OpenMP. The original C version is by John Burkardt and
available at:

https://people.sc.fsu.edu/~jburkardt/c_src/openmp/openmp.html

# List of directories/examples

* c: Slightly modified original C code.
* cython_c: Python calls a cython wrapper to a C routine.

# Building the examples

These examples require that extensions and code be compiled. There is a script
in each of these directories called `rebuild.sh`.  Change to the directory of
the code you wish to rebuild and run `./rebuild.sh` to remove any previous
compilation and rebuild the required extensions.

The `rebuild.sh` script may need to be edited to point to a compiler that
supports `-fopenmp`. In particular, the LLVM Clang compiler that masquarades as
`gcc` on Mac does not support OpenMP. To get around this on Mac, install GCC
from, e.g., homebrew and use that to compile the examples.

On MacOS, I recommend using the Anaconda Python Distribution and installing
their gcc package with `conda install gcc`, perhaps after creating a new conda
environment and activating it.

