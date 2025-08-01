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

# Copy mcp-servers.json to Gemini config directory as settings.json
if [ -f "mcp-servers.json" ]; then
    cp mcp-servers.json "$GEMINI_CONFIG_DIR/settings.json"
    echo "✅ Copied mcp-servers.json to $GEMINI_CONFIG_DIR/settings.json"
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
echo "📝 Next steps:"
echo "1. Edit $GEMINI_CONFIG_DIR/settings.json and replace 'YOUR_GITHUB_PAT' with your actual GitHub Personal Access Token"
echo "2. Restart Gemini to load the GitHub MCP server"
echo ""
echo "🔑 To create a GitHub Personal Access Token:"
echo "   1. Go to GitHub Settings > Developer settings > Personal access tokens"
echo "   2. Generate a new token with appropriate permissions"
echo "   3. Replace 'YOUR_GITHUB_PAT' in the config file with your token"