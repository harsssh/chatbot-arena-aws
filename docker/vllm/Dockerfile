FROM public.ecr.aws/neuron/pytorch-inference-neuronx:2.1.2-neuronx-py310-sdk2.19.0-ubuntu20.04

WORKDIR /app

# Patch transformers-neuronx
RUN pip uninstall -y transformers-neuronx
COPY changes.transformers-neuronx.patch /tmp/changes.transformers-neuronx.patch
RUN set -ex; \
    git clone https://github.com/aws-neuron/transformers-neuronx.git; \
    cd transformers-neuronx; \
    git checkout c8d6bdc025572f33031b5191ddd5d725c3dfb786; \
    git apply /tmp/changes.transformers-neuronx.patch; \
    pip install .

# Install patched vLLM
COPY changes.vllm.patch /tmp/changes.vllm.patch
ENV VLLM_TARGET_DEVICE=neuron
RUN set -ex; \
    git clone -b v0.5.0 https://github.com/vllm-project/vllm.git; \
    cd vllm; \
    git apply /tmp/changes.vllm.patch; \
    pip install -U -r requirements-neuron.txt; \
    pip install .

COPY entrypoint.sh /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
