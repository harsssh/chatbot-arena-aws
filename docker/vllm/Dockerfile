FROM public.ecr.aws/neuron/pytorch-inference-neuronx:2.1.2-neuronx-py310-sdk2.18.2-ubuntu20.04

RUN set -ex; \
    apt-get update; \
    apt-get install -y numactl

COPY changes.patch /tmp/changes.patch

RUN set -ex; \
    git clone -b v0.3.3 https://github.com/vllm-project/vllm.git; \
    cd vllm; \
    git apply /tmp/changes.patch; \
    pip install -U -r requirements-neuron.txt; \
    pip install .

ENTRYPOINT []
