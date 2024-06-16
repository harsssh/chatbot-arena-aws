#!/bin/bash -ex
: ${MODEL:?Need to set MODEL env var}
: ${PORT:?Need to set PORT env var} 
: ${CORES:?Need to set CORES env var}
: ${TENSOR_PARALLEL:?Need to set TENSOR_PARALLEL env var}

vLLM_MAX_LEN=4096 # should be set to the number of input+output tokens that will be used when benchmarking
vLLM_CONT_BATCH_SIZE=8 # continuous batching size for transformers-neuronx

export NEURON_RT_VISIBLE_CORES=${CORES} # Neuron cores on which the model needs to be deployed
export OMP_NUM_THREADS=24

options="--model ${MODEL} \
    --tensor-parallel-size ${TENSOR_PARALLEL} \
    --max-num-seqs ${vLLM_CONT_BATCH_SIZE} \
    --max-model-len ${vLLM_MAX_LEN} \
    --block-size ${vLLM_MAX_LEN} \
    --port ${PORT} \
    --host 0.0.0.0 \
    --disable-log-stats"

if [ -n "${TEMPLATE_PATH}" ]; then
    options="${options} --chat-template ${TEMPLATE_PATH}"
fi

python3 -m vllm.entrypoints.openai.api_server ${options}
