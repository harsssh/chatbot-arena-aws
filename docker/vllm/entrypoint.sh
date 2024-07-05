#!/bin/bash -ex
: "${MODEL:?}"
: "${PORT:?}" 
: "${TENSOR_PARALLEL_SIZE:?}"

export NEURON_RT_VISIBLE_CORES=${NEURON_RT_VISIBLE_CORES:-None}

options="--model ${MODEL} \
    --tensor-parallel-size ${TENSOR_PARALLEL_SIZE} \
    --max-num-seqs ${MAX_NUM_SEQS:-8} \
    --max-model-len ${MAX_MODEL_LEN:-4096} \
    --block-size ${MAX_MODEL_LEN:-4096} \
    --port ${PORT} \
    --host 0.0.0.0 \
    --disable-log-stats"

if [ -n "${CHAT_TEMPLATE}" ]; then
    options="${options} --chat-template ${CHAT_TEMPLATE}"
fi

python3 -m vllm.entrypoints.openai.api_server ${options}
