# syntax=docker/dockerfile:1
FROM public.ecr.aws/neuron/pytorch-inference-neuronx:2.1.2-neuronx-py310-sdk2.19.0-ubuntu20.04 AS base
WORKDIR /app

FROM base AS transformers-neuronx-builder
COPY changes.transformers-neuronx.patch /tmp/changes.transformers-neuronx.patch
RUN set -ex; \
    git clone https://github.com/aws-neuron/transformers-neuronx.git; \
    cd transformers-neuronx; \
    git checkout c8d6bdc025572f33031b5191ddd5d725c3dfb786; \
    git apply /tmp/changes.transformers-neuronx.patch; \
    pip install .

FROM base AS vllm-builder
COPY changes.vllm.patch /tmp/changes.vllm.patch
ENV VLLM_TARGET_DEVICE=neuron
RUN set -ex; \
    git clone -b v0.5.0 https://github.com/vllm-project/vllm.git; \
    cd vllm; \
    git apply /tmp/changes.vllm.patch; \
    pip install -U -r requirements-neuron.txt; \
    pip install .

FROM base
COPY --from=vllm-builder /opt/conda/lib/python3.10/site-packages /opt/conda/lib/python3.10/site-packages
COPY --from=transformers-neuronx-builder /opt/conda/lib/python3.10/site-packages/transformers_neuronx /opt/conda/lib/python3.10/site-packages/transformers_neuronx
COPY entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
