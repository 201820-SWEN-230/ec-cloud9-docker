#!/bin/bash

export conda=$HOME/miniconda/bin/conda

$conda create -y -n py36 python=3.6

source ~/miniconda/bin/activate py36

conda install -y cython

conda install -y pandas

conda install -y scipy

conda install -y matplotlib

conda install -y jupyter


