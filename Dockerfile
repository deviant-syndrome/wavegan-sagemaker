FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/tensorflow-training:1.15.5-gpu-py37-cu100-ubuntu18.04

RUN pip3 install numba==0.48
RUN pip3 install librosa==0.6.2
RUN apt-get -y update && apt-get install -y libsndfile-dev

ENV PATH="/opt/program:${PATH}"

COPY wavegan /opt/program
COPY train /opt/program
WORKDIR /opt/program
