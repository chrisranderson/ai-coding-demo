# Dev Container Setup

This guide is for users who want to use the pre-configured dev container environment with Docker.

## Prerequisites

- VS Code with the Dev Containers extension
- Docker Desktop
- Git

## Setup Instructions

### 1. Clone the Repository
```bash
TODO: replace me
git clone git@tanuki-data.pnnl.gov:shared/ai/ai-coding-demo.git
cd ai-coding-demo
```

### 2. Open in VS Code Dev Container
1. Open the repository in VS Code
2. When prompted, select "Reopen in Container"
3. Wait for the dev container to build and start

The dev container will automatically:
- Install Python 3.11
- Install Node.js 22 via nvm
- Install Poetry for Python dependency management
- Install uv/uvx for MCP server management
- Install Claude Code CLI globally
- Install Aider CLI
- Configure VS Code extensions and settings
- Install all project dependencies via `poetry install`

### 3. Verify Setup
Once the container is running, you should be able to:
```bash
# Check Python version
python --version  # Should show Python 3.11.x

# Check Poetry
poetry --version

# Check Node.js
node --version  # Should show v22.x.x

# Check Claude Code
claude --version

# Check Aider
aider --version
```

## What's Included

The dev container provides:
- **Python 3.11** with Poetry for dependency management
- **Node.js 22** for JavaScript tooling
- **Build tools** (build-essential, curl)
- **AI Tools**: Claude Code CLI, Aider CLI
- **VS Code Extensions**: Python, Pylint, Black formatter, isort, JSON support, Claude Dev
- **Pre-configured settings** for Python development

## Port Forwarding

The dev container automatically forwards port 8000 for the Django development server.

## Customization

The dev container configuration is defined in:
- `.devcontainer/devcontainer.json` - Main configuration
- `.devcontainer/Dockerfile` - Container image definition
- `.devcontainer/postStartCommand.sh` - Post-start setup script

You can modify these files to customize the development environment for your needs.
