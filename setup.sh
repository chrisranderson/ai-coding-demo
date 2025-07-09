#!/bin/bash

# EMSL 2025 Summer School: AI Coding Demo Setup Script (Unix/Linux/macOS)
# This script sets up the development environment for the AI coding demo

set -e  # Exit on any error

echo "🚀 Setting up AI Coding Demo environment..."

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check Python version
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed. Please install Python 3.11+ and try again."
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
REQUIRED_VERSION="3.11"
if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "❌ Python 3.11+ is required. Current version: $PYTHON_VERSION"
    exit 1
fi
echo "✅ Python $PYTHON_VERSION found"

# Check Git
if ! command -v git &> /dev/null; then
    echo "❌ Git is required but not installed."
    exit 1
fi
echo "✅ Git found"

# Install Poetry if not present
if ! command -v poetry &> /dev/null; then
    echo "📦 Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
    export PATH="$HOME/.local/bin:$PATH"
    
    # Add to shell profile for future sessions
    if [ -f ~/.bashrc ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    fi
    if [ -f ~/.zshrc ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    fi
    
    echo "✅ Poetry installed"
else
    echo "✅ Poetry found"
fi

# Install Python dependencies
echo "📦 Installing Python dependencies..."
poetry install --all-extras --all-groups

# Check if Node.js is available for optional dependencies
if command -v npm &> /dev/null; then
    echo "📦 Installing optional Node.js dependencies..."
    
    # Claude Code CLI
    echo "  Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
    
    echo "✅ Node.js dependencies installed"
else
    echo "⚠️  Node.js not found. Skipping optional Node.js dependencies."
    echo "   Install Node.js 22+ if you want to use Claude Code."
fi

# Install uv for MCP server management (if curl is available)
if command -v curl &> /dev/null; then
    echo "📦 Installing uv for MCP server management..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "✅ uv installed"
else
    echo "⚠️  curl not found. Skipping uv installation."
fi

# Setup database
echo "🗄️  Setting up database..."
poetry run python manage.py migrate

# Create .env file if it doesn't exist
if [ ! -f .env ] && [ -f .env.example ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    chmod 600 .env
    echo "✅ .env file created. Please update it with your API keys."
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Activate the virtual environment: poetry shell"
echo "2. Start the development server: python manage.py runserver"
echo "3. Visit http://localhost:8000"
echo ""
echo "Optional:"
echo "- Update .env file with your API keys"
echo "- Create a superuser: python manage.py createsuperuser"
echo "- Install Aider: python -m pip install aider-install && aider-install"
echo ""
echo "For AI tool configuration, see the README.md file."
