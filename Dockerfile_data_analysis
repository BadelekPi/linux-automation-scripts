# syntax=docker/dockerfile:1

# create new
#FROM debian
FROM python:3.7-slim
LABEL maintainer="piotr.badelek@trumpf.com"
LABEL build_date="2022-11-26"

WORKDIR /home/badi/Tools/scripts/linux-automation-scripts

# run neccessary packages to execute data analysis scipt
# python image works fine as it has gcc already installed
RUN apt update && apt install -y --no-install-recommends gcc \
 && pip install pandas \
 && apt remove -y gcc \
 && rm -rf /var/lib/apt/lists/*

# check if remote disk is mounted on host

# ENV - sets environment variables

# run command
CMD ./pc_info.sh

