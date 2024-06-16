#!/bin/bash -ex

git clone -b v0.3.3 https://github.com/vllm-project/vllm.git
cd vllm
git apply ../changes.patch
pip install -U -r requirements-neuron.txt
pip install .