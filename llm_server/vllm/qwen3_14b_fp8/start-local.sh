#!/bin/bash
# to be run as: export ENV_FILE=.env.qwen3_14b_fp8 && bash ./start-local.sh


# Check if ENV_FILE is set
if [ -z "$ENV_FILE" ]; then
  echo "Error: ENV_FILE is not set. Please specify the environment file." >&2
  ENV_FILE=".env.qwen3_14b_fp8"
fi

# Check if the specified file exists and is a regular file
if [ ! -f "$ENV_FILE" ]; then
  echo "Error: ENV_FILE '$ENV_FILE' does not exist or is not a regular file." >&2
  exit 1
fi


unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs -d '\n')
elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs -0)
fi

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate py312

# Log in to Hugging Face if token is provided
if [ -z "$HF_TOKEN" ]; then
  echo "HF_TOKEN is not set. Skipping login."
  exit 0
else
  echo "Logging in to Hugging Face..."
  hf auth login --token $HF_TOKEN --add-to-git-credential &
  echo "Logged in to Hugging Face successfully."
fi

# Start vLLM server
# --disable-log-stats: Turns off vLLM’s periodic logging of statistics to reduce overhead
# --enable-prefix-caching: Caches the KV state of repeated prompt prefixes
echo "Starting vLLM server..."
SAFETENSORS_FAST_GPU=1 CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES NCCL_DEBUG=INFO vllm serve \
  $MODEL_NAME \
  --host $HOST --port $PORT \
  --dtype $D_TYPE \
  --tensor-parallel-size $NUM_GPU \
  --gpu-memory-utilization $MEM_UTILIZATION \
  --max-model-len $MAX_MODEL_LEN \
  --max-num-seqs $MAX_NUM_SEQS \
  --block-size $BLOCK_SIZE \
  --swap-space $SWAP_SPACE \
  --trust-remote-code \
  --disable-log-stats \
  --enable-chunked-prefill \
  --enable-auto-tool-choice \
  --tool-call-parser hermes \
  --enable-prefix-caching &

VLLM_PID=$!

echo "Starting Open WebUI docker container..."
# Remove existing container if it exists
docker rm -f open-webui 2>/dev/null || true

docker run -d \
  --network host \
  --name open-webui \
  -v open-webui:/app/backend/data \
  -e OPENAI_API_BASE_URL=http://localhost:$PORT/v1 \
  -e PORT=$WEB_PORT \
  --restart always \
  ghcr.io/open-webui/open-webui:main

echo "Both services started. vLLM PID: $VLLM_PID"
echo "Press Ctrl+C to stop vLLM server"
wait $VLLM_PID