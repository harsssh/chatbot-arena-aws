docker run --device=/dev/neuron0 10ca0d4f4286 python3 -m vllm.entrypoints.api_server --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 --max-num-seqs 8 --max-model-len 128 --block-size 128 --device neuron --tensor-parallel-size 1
