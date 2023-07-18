# RStan Container

Docker/Singularity image to run [RStan](https://cran.r-project.org/web/packages/rstan/index.html) on a Centos 6.10 kernel.


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g.

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/rstan-contained.git
```
Then `cd rstan-contained` and modify the `run_artemis.pbs` script and launch with `qsub run_artemis.pbs`.

Otherwise here are the full instructions for getting there....


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/rstan:4.0.5
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and execute a run on the test images (that live in the container) run:
```
sudo docker run -it -v `pwd`:/project sydneyinformaticshub/rstan:4.0.5 /bin/bash -c "Rscript demostan.R"
```

## Push to docker hub
```
sudo docker push nbutter/cellranger:ubuntu1604
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/rstan](https://hub.docker.com/r/sydneyinformaticshub/rstan)


## Build with singularity
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build rstan.img docker://sydneyinformaticshub/rstan:4.0.5
```

## Run with singularity
To run the singularity image (noting singularity mounts the current folder by default)
```
singularity run --bind /project:/project rstan.img /bin/bash -c "export TMPDIR="$PBS_O_WORKDIR" && Rscript code/test.R
```
