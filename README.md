# RStan Container

Docker/Singularity image to run [RStan](https://cran.r-project.org/web/packages/rstan/index.html) optimised for NCI.


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for NCI

Put this repo on NCI e.g.

```
cd /scratch/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/rstan-contained.git
git checkout nci
```
Then `cd rstan-contained` and modify the `*.sh` scripts as needed and launch with `bash run_build.sh` to build the RStan Singularity image *once*. This must be done on a login node as it requires internet access. Then afterwards use `qsub run_nci.pbs` to run any workload.

Otherwise here are the full instructions for getting there....


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/rstan:latest
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and execute a run on the test images (that live in the container) run:
```
sudo docker run -it -v `pwd`:/scratch sydneyinformaticshub/rstan:latest /bin/bash -c "Rscript demostan.R"
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/rstan:latest
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/rstan](https://hub.docker.com/r/sydneyinformaticshub/rstan)


## Build with singularity
Use the `run_build.sh` script to build on an NCI Login node (or ARE, or some computer you have singularity). The key details are:
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build rstan_latest.sif docker://sydneyinformaticshub/rstan:latest
```

## Run with singularity
Use the `run_artemis.pbs` script to run an exampled workflow on an Artemis compute node.
To run the singularity image (noting singularity mounts the current folder by default):
```
singularity exec rstan_latest.sif /bin/bash -c "Rscript demostan.R"
```
