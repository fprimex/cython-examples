#!/bin/bash

#MOAB -l nodes=1
#MOAB -j oe
#MOAB -m abe
#MOAB -N lorenz96-cython
#MOAB -l walltime=00:01:00

cd $PBS_O_WORKDIR
. /usr/local/profile.d/python26.sh
python lorenz96.py > $PBS_O_WORKDIR/output.txt
