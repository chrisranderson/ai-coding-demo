@echo off
REM EMSL 2025 Summer School: AI Coding Demo Setup Script (Windows)
REM This script sets up the development environment for the AI coding demo

echo Setting up AI Coding Demo environment...

REM Check prerequisites
echo Checking prerequisites...

REM Check Python version
python --version >nul 2>&1
if errorlevel 1 (
    echo Python is required but not installed. Please install Python 3.11+ and try again.
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Python %PYTHON_VERSION% found

REM Check Git
git --version >nul 2>&1
if errorlevel 1 (
    echo Git is required but not installed.
    pause
    exit /b 1
)
echo Git found

REM Check if Poetry is installed
poetry --version >nul 2>&1
if errorlevel 1 (
    echo Installing Poetry...
    curl -sSL https://install.python-poetry.org | python -
    
    REM Add Poetry to PATH for current session
    set "PATH=%APPDATA%\Python\Scripts;%PATH%"
    
    echo Poetry installed
    echo You may need to restart your command prompt for Poetry to be available in new sessions.
) else (
    echo Poetry found
)

REM Install Python dependencies
echo Installing Python dependencies...
poetry lock
poetry install --all-extras --all-groups
if errorlevel 1 (
    echo Failed to install Python dependencies
    pause
    exit /b 1
)

REM Check if Node.js is available for optional dependencies
npm --version >nul 2>&1
if not errorlevel 1 (
    echo Installing optional Node.js dependencies...
    
    REM Claude Code CLI
    echo   Installing Claude Code CLI...
    npm install -g @anthropic-ai/claude-code
    
    echo Node.js dependencies installed
) else (
    echo Node.js not found. Skipping optional Node.js dependencies.
    echo    Install Node.js 22+ if you want to use Claude Code.
)

REM Install uv for MCP server management (Windows)
echo Installing uv for MCP server management...
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
if not errorlevel 1 (
    echo uv installed
) else (
    echo Failed to install uv. You may need to install it manually.
)

REM Setup database
echo Setting up database...
poetry run python manage.py migrate
if errorlevel 1 (
    echo Failed to setup database
    pause
    exit /b 1
)

REM Create .env file if it doesn't exist
if not exist .env (
    if exist .env.example (
        echo Creating .env file from template...
        copy .env.example .env
        echo .env file created. Please update it with your API keys.
    )
)

echo.
echo Setup complete! You can continue following the README.
echo.
pause
