# Load environment variables
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
  export $(grep -v '^#' .env | xargs -d '\n')
elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
  export $(grep -v '^#' .env | xargs -0)
fi

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate py312

echo "Starting vLLM server..."
SAFETENSORS_FAST_GPU=1 CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES vllm serve \
  $MODEL_NAME \
  --host $HOST --port $PORT \
  --tensor-parallel-size $NUM_GPU \
  --gpu-memory-utilization $MEM_UTILIZATION \
  --max-model-len $MAX_MODEL_LEN \
  --max-num-seqs $MAX_NUM_SEQS &
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