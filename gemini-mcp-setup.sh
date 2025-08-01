#!/bin/bash

# Gemini MCP Setup Script
echo "🚀 Setting up Gemini MCP with GitHub server..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Create Gemini config directory
GEMINI_CONFIG_DIR="$HOME/.gemini"
mkdir -p "$GEMINI_CONFIG_DIR"

# Check if .env file exists, if not create from example
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "📝 Created .env file from .env.example"
        echo "⚠️  Please edit .env file and add your GitHub Personal Access Token"
    else
        echo "❌ .env.example not found in current directory"
        exit 1
    fi
fi

# Load environment variables from .env file
if [ -f ".env" ]; then
    export $(cat .env | grep -v '^#' | xargs)
    echo "✅ Loaded environment variables from .env"
fi

# Update mcp-servers.json with environment variables and copy to Gemini config
if [ -f "mcp-servers.json" ]; then
    # Replace placeholder with actual token from environment
    sed "s/YOUR_GITHUB_PAT/${GITHUB_PERSONAL_ACCESS_TOKEN}/g" mcp-servers.json > "$GEMINI_CONFIG_DIR/settings.json"
    echo "✅ Updated and copied configuration to $GEMINI_CONFIG_DIR/settings.json"
else
    echo "❌ mcp-servers.json not found in current directory"
    exit 1
fi

# Pull GitHub MCP server Docker image
echo "📦 Pulling GitHub MCP server Docker image..."
docker pull ghcr.io/github/github-mcp-server

# Set permissions
chmod +x "$GEMINI_CONFIG_DIR/settings.json"

echo "✅ Gemini MCP setup completed!"
echo "📁 Config file location: $GEMINI_CONFIG_DIR/settings.json"
echo ""
if [ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ] || [ "$GITHUB_PERSONAL_ACCESS_TOKEN" = "your_github_personal_access_token_here" ]; then
    echo "⚠️  IMPORTANT: You need to configure your GitHub Personal Access Token!"
    echo ""
    echo "📝 Next steps:"
    echo "1. Edit .env file and add your GitHub Personal Access Token"
    echo "2. Run this script again to update the configuration"
    echo "3. Restart Gemini to load the GitHub MCP server"
    echo ""
    echo "🔑 To create a GitHub Personal Access Token:"
    echo "   1. Go to GitHub Settings > Developer settings > Personal access tokens"
    echo "   2. Generate a new token with these scopes: repo, read:org, user:email"
    echo "   3. Copy the token and paste it in the .env file"
else
    echo "✅ GitHub Personal Access Token configured successfully!"
    echo ""
    echo "📝 Next steps:"
    echo "1. Restart Gemini to load the GitHub MCP server"
    echo "2. Your GitHub MCP server is ready to use!"
fi