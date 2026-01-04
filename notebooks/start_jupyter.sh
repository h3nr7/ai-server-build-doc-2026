#!/bin/bash
# navigate to the root directory from notebooks/ if run from there, or use relative path
# But simpler: just use uv run jupyter notebook and assume user runs it from root or we set directory.
# User asked for "script here in notebook folder to start jupyter there".
# This usually implies starting the server with notebooks dir as root or just launching it.

# Let's handle running from root or inside notebooks folder
cd "$(dirname "$0")" || exit

# Run jupyter notebook, setting the notebook directory to the current directory (notebooks)
# We need to run uv from the project root.
# Assuming this script is in <project_root>/notebooks/ start_jupyter.sh

cd .. # now in project root
uv run jupyter notebook --notebook-dir=notebooks
