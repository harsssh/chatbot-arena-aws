#!/bin/bash

git clone https://github.com/aws-neuron/transformers-neuronx.git
cd transformers-neuronx
git checkout 0623de20a3934f8d1b3cb73e1672138657134d7f
git apply ../changes.patch

pip uninstall transformers-neuronx
python3 setup.py bdist_wheel
pip install $(ls -t dist/*.whl | head -1)
