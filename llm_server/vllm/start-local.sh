unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then

  export $(grep -v '^#' .env | xargs -d '\n')

elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then

  export $(grep -v '^#' .env | xargs -0)

fi

CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES vllm serve $MODEL_NAME --host 0.0.0.0 --port $PORT --tensor-parallel-size $NUM_GPU