# on the terminal execute
cd /scratch/er01/
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`
singularity pull --dir . docker://sydneyinformaticshub/rstan:latest
