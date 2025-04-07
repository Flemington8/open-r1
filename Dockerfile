FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-devel

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install required system packages
RUN apt-get update && apt-get install -y \
    curl git git-lfs build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Copy your source code
COPY . .

# Activate venv, install pip upgrades and dependencies
RUN pip install --upgrade pip && \
    pip install vllm==0.7.2 && \
    pip install setuptools && \
    pip install flash-attn --no-build-isolation && \
    GIT_LFS_SKIP_SMUDGE=1 pip install -e ".[dev]"

