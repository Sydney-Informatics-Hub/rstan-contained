#Dockerfile

#To build this file:
#sudo docker build . -t sydneyinformaticshub/rstan:4.0.5

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
# sudo docker run -it -v `pwd`:/project sydneyinformaticshub/rstan:4.0.5 /bin/bash -c "/usr/bin/time Rscript demostan.R"

# To push to docker hub:
# sudo docker push sydneyinformaticshub/rstan:4.0.5

# Pull base image.
FROM ubuntu:16.04
MAINTAINER Nathaniel Butterworth USYD SIH

# Install dependencies
RUN apt-get update
RUN apt-get install -y software-properties-common build-essential wget xserver-xorg-dev libx11-dev libxt-dev libpcre2-dev curl libcurl4-openssl-dev
RUN apt-get install -y libtbb-dev  texlive-latex-base libbz2-dev liblzma-dev libreadline-dev

# Install updated compilers
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update -y
RUN apt-get install gcc-6 g++-6 gfortran-6  -y
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 60
RUN	update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-6 60

RUN apt-get install gcc-7 g++-7 gfortran-7  -y
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 70
RUN	update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-7 70

# Install R
WORKDIR /build

RUN wget -c https://cran.r-project.org/src/base/R-4/R-4.0.5.tar.gz && tar -xf R-4.0.5.tar.gz

WORKDIR /build/R-4.0.5

RUN bash configure
RUN make -j 12
RUN make install

RUN /usr/local/bin/Rscript --version

# Install R libraries
RUN /usr/local/bin/Rscript -e 'install.packages(c("MASS","rstan","doParallel","LaplacesDemon"), repos="https://cloud.r-project.org", dependencies = TRUE)'

# Add extra items for Artemis HPC
RUN mkdir /project /scratch && touch /usr/bin/nvidia-smi

WORKDIR /project

RUN apt install -y time
