FROM mcr.microsoft.com/devcontainers/python:3.11

SHELL ["/bin/bash", "--login", "-c"]

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR="/root/.nvm"
# Install Node.js using nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && . "$HOME/.nvm/nvm.sh" \
    && nvm install 22 \
    && nvm use 22

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Configure Poetry
RUN poetry config virtualenvs.create true \
    && poetry config virtualenvs.in-project true

# uv and uvx for MCP servers
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set working directory
WORKDIR /workspaces/ai-coding-demo

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]
