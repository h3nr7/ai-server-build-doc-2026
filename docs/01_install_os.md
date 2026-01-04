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

    a. For nvidia driver (may not be needed as it is included in the Ubuntu as a Linux distribution) follow [this](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) and for container toolkit required within docker (including amazon linux), follow this [link](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/ubuntu.html
    ).

