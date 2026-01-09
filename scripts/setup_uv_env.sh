#!/bin/bash
set -e

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "uv not found. Installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    source $HOME/.cargo/env
else
    echo "uv is already installed."
fi

# Initialize uv project if pyproject.toml doesn't exist
if [ ! -f pyproject.toml ]; then
    echo "Initializing uv project..."
    uv init
fi

# Install dependencies
echo "Installing dependencies..."
uv add jupyter numpy torch

echo "Setup complete!"
