#!/bin/bash
set -x

python setup.py clean
python setup.py build_ext --inplace
