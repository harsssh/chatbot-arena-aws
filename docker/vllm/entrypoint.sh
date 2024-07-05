#!/bin/bash -ex
: "${MODEL:?}"
: "${PORT:?}"
: "${CORES:?}"

export NEURON_RT_VISIBLE_CORES="$CORES"

if [ -z "${TENSOR_PARALLEL_SIZE}" ]; then
    TENSOR_PARALLEL_SIZE=$(echo "${CORES}" | awk -F- '{print $2 - $1 + 1}')
fi

options=(
    --model "${MODEL}"
    --tensor-parallel-size "${TENSOR_PARALLEL_SIZE}"
    --max-num-seqs "${MAX_NUM_SEQS:-8}"
    --max-model-len "${MAX_MODEL_LEN:-4096}"
    --block-size "${MAX_MODEL_LEN:-4096}"
    --port "${PORT}"
    --host 0.0.0.0
    --disable-log-stats
)

if [ -n "${CHAT_TEMPLATE}" ]; then
    options+=(--chat-template "${CHAT_TEMPLATE}")
fi

python3 -m vllm.entrypoints.openai.api_server "${options[@]}"
