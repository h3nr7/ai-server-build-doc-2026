# Prerequisites

This document outlines the initial setup for the AI Server Build 2026 project.

- Linux OS
- `curl` (for installing `uv`)

## Installation

1.  **Clone the repository** (if you haven't already):
    ```bash
    git clone <repository_url>
    cd ai-server-build-doc-2026
    ```

2.  **Run the setup script**:
    The included script will check for `uv`, install it if missing, initialize the project, and install the required Python packages (`jupyter`, `numpy`, `torch`).

    ```bash
    chmod +x scripts/setup_env.sh
    ./scripts/setup_env.sh
    ```

3.  **Activate the environment**:
    `uv` manages the virtual environment for you. You can run commands using `uv run`.

    Example:
    ```bash
    uv run jupyter notebook
    ```
