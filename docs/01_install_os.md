# Install OS

## Ubuntu 22.04

1. Follow [official installation guide](https://documentation.ubuntu.com/desktop/en/latest/tutorial/install-ubuntu-desktop/) to create a USB installation media.  Need at least 8GB USB drive.

2. Install Ubuntu 22.04 to the hard drive.  

3. Install miniforge for conda and mamba from [official installation guide](https://github.com/conda-forge/miniforge?tab=readme-ov-file#unix-like-platforms-macos-linux--wsl).

4. Create different environments with mamba for different python versions and and specific project needs. 
    ```bash
    mamba create -n py312 python=3.12
    mamba create -n py311 python=3.11
    ```

5. Install uv from [official installation guide](https://docs.astral.sh/uv/getting-started/installation/).  Alternatively you can install via conda:
    ```bash
    mamba config --add channels conda-forge
    mamba config --set channel_priority strict
    mamba install uv
    ```
    Otherwise, you can install uv via pip once you activated conda
    ```bash
    mamba activate myenv
    pip install uv
    ```

6. It is also essential to install CUDA for GPU support.  Follow [official installation guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/).

    Some tip on requirements to successfully install CUDA:

    a. gcc is verified to be installed:
    ```bash
    gcc --version
    ```

    b. For Ubuntu, follow this [guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#prepare-ubuntu).

    c. For Ubuntu drivers, follow this [guide](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/ubuntu.html).

7.  Docker is also essential for running different versions of Python and different projects.

    a. Installing Docker desktop for Ubuntu.  Follow [this](https://docs.docker.com/desktop/setup/install/linux/ubuntu/).

    b. For nvidia driver (may not be needed as it is included in the Ubuntu as a Linux distribution) follow [this](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) 
    
    c. For container toolkit required within docker (including amazon linux), follow this [link](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/ubuntu.html
    ).

8. Here are some commands to start and stop docker via commandline:
    ```bash
    systemctl --user start docker-desktop
    systemctl --user stop docker-desktop
    ```

    Enable Docker to start on sign in
    ```bash
    systemctl --user enable docker-desktop
    ```

    TO check docker version
    ```bash
    docker --version
    ```

## vLLM

Note: As of now, vLLM’s binaries are compiled with CUDA 12.1 and public PyTorch release versions by default.

1. Activate conda environment

    ```bash
    conda create -n vllm python=3.9 -y
    conda activate vllm
    ```

2. Install vLLM

    ```bash
    pip install vllm
    ```

Once installed here is a [quickstart](https://docs.vllm.ai/en/v0.5.0.post1/getting_started/quickstart.html) guide

vLLM provides an HTTP server that implements OpenAI Completions and Chat API, most importantly via [Docker](https://docs.vllm.ai/en/v0.5.0.post1/serving/deploying_with_docker.html). [More info](https://docs.vllm.ai/en/v0.5.0.post1/serving/openai_compatible_server.html)

[Here](https://docs.vllm.ai/en/v0.5.0.post1/serving/env_vars.html) are some Environment variables that can be set to configure the server.

Detailed installation guide [here](https://docs.vllm.ai/en/v0.5.0.post1/getting_started/installation.html)

## Llama cpp

Install and run natively [instruction](https://github.com/ggml-org/llama.cpp/blob/master/docs/install.md).  To run an OpenAI API http server, follow [here](https://github.com/ggml-org/llama.cpp/blob/master/tools/server/README.md).

Installation via [Docker](https://github.com/ggml-org/llama.cpp/blob/master/docs/docker.md)