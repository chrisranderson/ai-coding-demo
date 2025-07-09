# EMSL 2025 Summer School: From Artificial Intelligence and Machine Learning to Agent-Based Science

**July 7-11, 2025** | Chris Anderson, SWE, PNNL


## AI Agents for Software Development Workshop

An interactive demonstration of cutting-edge AI coding tools including GitHub Copilot, Claude Code, Cline, and Aider, showcasing Model Context Protocol (MCP) servers and modern AI-assisted development workflows.


## Prerequisites

- [**Python 3.11+**](https://www.python.org/downloads/)
- [**Node.js 22+**](https://nodejs.org/en/download) *(for Claude Code and MCP servers)*
- [**VS Code**](https://code.visualstudio.com/download) *(for Cline/Github Copilot, optional for other tools)*
- [**Git**](https://git-scm.com/downloads)

---

## Quick Start

> **Note:** If you have Docker installed, you can use our pre-configured dev container for a faster setup. See [**DEVCONTAINER_SETUP.md**](./DEVCONTAINER_SETUP.md)

**Windows users:** WSL is required for Claude Code (but Claude Code itself is optional)

If you run into trouble, you can interrupt the script, debug, and run the script again.

### 1. Clone Repository
```bash
git clone https://github.com/chrisranderson/ai-coding-demo.git
cd ai-coding-demo
```

### 2. Run Setup Script

Choose the appropriate setup script for your operating system:

**Unix/Linux/macOS:**
```bash
chmod +x setup.sh
./setup.sh
```

**Windows:**
Run this from the repo root:
```cmd
.\setup.bat
```

The setup scripts will automatically:
- Check prerequisites (Python 3.11+, Git)
- Install Poetry (Python dependency manager)
- Install project dependencies
- Install optional Node.js dependencies (Claude Code CLI, uv)
- Setup the database
- Create `.env` file from template

### 3. Start Development Server
```bash
# Activate the virtual environment
poetry shell

# Launch Django development server
python manage.py runserver
```

You can then see a sample web app at [localhost:8000](http://localhost:8000).

---

## AI Tool Configuration

> **Note:** Each AI tool is optional - choose the ones you'd like to experiment with during the workshop. Your instructor will provide all necessary API keys and configuration details.

### GitHub Copilot

*Note: a free trial is required; we won't focus on Copilot for this workshop.*

1. Install the GitHub Copilot extension in VS Code
2. Follow the authentication prompts provided by your instructor

### Claude Code  
> **Windows users:** WSL required

1. Install via npm *(done in setup above)* or visit the [Claude Code docs](https://docs.anthropic.com/en/docs/claude-code/overview#basic-usage)
2. Setup environment:
   ```bash
   cp .env.example .env && chmod 600 .env
   ```
3. Your instructor will provide the `.env` configuration
4. Launch Claude Code:
   ```bash
   source .env && claude
   ```

### Cline
- In VS Code -> left bar -> extensions -> Install the **Cline** VS Code extension
- Click on the little robot face on the left-hand side (or press `ctrl/cmd + '`)
- At the bottom in the middle of the Cline side panel, you'll see something like `openrouter:anthropic/claude-sonnet-4`. Click on that to configure Cline.
- Settings:
   - API Provider: OpenAI Compatible
   - Your instructor will provide:
      - Base URL
      - API Key  
      - Model ID
- **Windows users**:
   - Press `ctrl+shift+P`
   - Search for "Terminal: Select Default Profile" and pick Powershell
- To add MCP servers, see "Manage MCP Servers" (one of the icons on the bottom of the side panel)


### Aider
1. Install Aider: [Aider docs](https://aider.chat/docs/install.html#get-started-quickly-with-aider-install)
2. Start in architect mode:
   ```bash
   source .env && aider --architect
   ```

---

## Getting Started

### Start the Development Server
```bash
# Activate the virtual environment (if not already activated)

# Windows: Invoke-Expression (poetry env activate)
eval $(poetry env activate)
poetry install
# Launch Django development server
python manage.py runserver
```

**Ready!** Visit [`http://localhost:8000`](http://localhost:8000)

### Optional Setup Steps
After running the setup script, you may want to:

```bash
# Create a superuser for Django admin
python manage.py createsuperuser

# Install Aider (optional AI coding tool)
python -m pip install aider-install
aider-install
```

### Try These AI Commands
Open any configured AI tool and experiment with these prompts:

#### Basic Exploration
```
start the dev server
introduce me to this repo  
list the most important thing to improve ux in this app, give me a plan, don't implement anything yet
```

#### MCP Server Integration
```
Add a map of electric vehicles in washington state below the todo list
```

#### Self-Improvement
```
Add an MCP server that searches the Django 5.2 docs
```

---

## Project Structure

### AI-Specific Components
This repository showcases modern AI development patterns:

| Component | Description |
|-----------|-------------|
| **[`.github/copilot-instructions.md`](./.github/copilot-instructions.md)** | Copilot instructions applied to each agent request |
| **[`.vscode/mcp.json`](./.vscode/mcp.json)** | MCP server configurations for AI tools |
| **[`mcp/example_server/`](./mcp/example_server/)** | Custom MCP server implementation examples |
| **[`.mcp.json`](./.mcp.json)** | Claude Code MCP server configurations |

### Application Components
- **Django Todo App** - Simple todo list application for demonstration
- **Electric Vehicle Data** - Sample dataset for MCP server demonstrations

---

## Extending the Demo

### Adding MCP Servers
Explore the [MCP servers repository](https://github.com/modelcontextprotocol/servers) for additional servers to integrate. Check the [VS Code MCP documentation](https://code.visualstudio.com/docs/copilot/chat/mcp-servers) for configuration details.

### Custom MCP Development
Refer to the example server in `mcp/example_server/` for guidance on creating custom MCP servers tailored to your specific use cases.

---

## Troubleshooting

<details>
<summary><strong>Setup Script Issues</strong></summary>

- **Unix/Linux/macOS:** Make sure the script is executable: `chmod +x setup.sh`
- **Windows:** Run as Administrator if you encounter permission issues
- If the setup script fails, try running the individual commands manually (see script contents for reference)
</details>

<details>
<summary><strong>Python Environment Issues</strong></summary>

- Verify Python version: `python --version` *(should be 3.11+)*
- Poetry not found? Restart terminal or add to PATH
- Always use `poetry shell` before running Django commands
</details>

<details>
<summary><strong>Node.js Dependencies</strong></summary>

- Check Node.js version: `node --version` *(should be 22+)*
- Claude Code installation failing? Try `npx @anthropic-ai/claude-code`
</details>

<details>
<summary><strong>Django Issues</strong></summary>

- Database errors? Run `python manage.py migrate`
- Port 8000 busy? Check for other running applications
</details>

<details>
<summary><strong>AI Tool Configuration</strong></summary>

- Ensure `.env` file contains instructor-provided values
- **Windows users:** Use WSL for Claude Code compatibility  
- Verify MCP servers in `.vscode/mcp.json` or `.mcp.json`
</details>