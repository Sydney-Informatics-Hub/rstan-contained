#Dockerfile

#To build this file:
#sudo docker build . -t sydneyinformaticshub/rstan

#To run this, mounting your current host directory in the container directory,
# sudo docker run -it sydneyinformaticshub/rstan /bin/bash -c "/usr/bin/time Rscript demostan.R"

# To push to docker hub:
# sudo docker push sydneyinformaticshub/rstan

# Use the official R base image
FROM rocker/r-ver:4.3.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c('tidyverse', 'brms', 'rstan', 'sf', 'terra'), repos='https://cloud.r-project.org/')"

# Add NCI specific folders to container
RUN touch /apps /g /opt/nci /scratch /jobfs

# Set the entrypoint
CMD ["R"]
