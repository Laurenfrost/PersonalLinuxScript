#!/bin/sh
## Temporarily source the env setting script in Intel(R) Parallel Studio XE.

export INTEL_LICENSE_FILE=/opt/intel/license

## COMPILER ##
INTEL_HOME=/opt/intel/compilers_and_libraries/linux
. ${INTEL_HOME}/bin/compilervars.sh intel64

## MPI ##
. ${INTEL_HOME}/mpi/intel64/bin/mpivars.sh 

## MKL ##
. ${INTEL_HOME}/mkl/bin/mklvars.sh intel64
