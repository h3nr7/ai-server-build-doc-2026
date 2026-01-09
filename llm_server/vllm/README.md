# VLLM Instructions

## Run via docker

- Add env variables to .env file
- Use the Start / Stop Scripts located in this folder

## Run via local installation

Install vllm locally

- Activate a mamba or uv environment
- Install vllm for a particular version, 13.1 in this case
    ```
    pip install vllm --extra-index-url https://download.pytorch.org/whl/cu131
    ```

## Run vllm

### Single GPU
```bash
vllm serve Qwen/Qwen3-0.6B-Chat --host 0.0.0.0 --port 8001
```

### Dual GPU (Tensor Parallel)
```bash
vllm serve Qwen/Qwen3-0.6B-Chat --host 0.0.0.0 --port 8001 --tensor-parallel-size 2
```

You can also specify which GPUs to use:
```bash
CUDA_VISIBLE_DEVICES=0,1 vllm serve Qwen/Qwen3-0.6B-Chat --host 0.0.0.0 --port 8001 --tensor-parallel-size 2
```

## Parallelism and Scaling

To choose a distributed inference strategy for a single-model replica, use the following guidelines:

* Single GPU (no distributed inference): if the model fits on a single GPU, distributed inference is probably unnecessary. Run inference on that GPU.

* Single-node multi-GPU using tensor parallel inference: if the model is too large for a single GPU but fits on a single node with multiple GPUs, use tensor parallelism. For example, set tensor_parallel_size=4 when using a node with 4 GPUs.

* Multi-node multi-GPU using tensor parallel and pipeline parallel inference: if the model is too large for a single node, combine tensor parallelism with pipeline parallelism. Set tensor_parallel_size to the number of GPUs per node and pipeline_parallel_size to the number of nodes. For example, set tensor_parallel_size=8 and pipeline_parallel_size=2 when using 2 nodes with 8 GPUs per node.


For details visit here for [more info](https://docs.vllm.ai/en/stable/serving/parallelism_scaling/).