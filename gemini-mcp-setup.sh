#!/bin/bash

# Gemini MCP Setup Script
echo "🚀 Setting up Gemini MCP with GitHub server..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Create MCP config directory
MCP_CONFIG_DIR="$HOME/.config/gemini-mcp"
mkdir -p "$MCP_CONFIG_DIR"

# Copy mcp-servers.json to config directory
if [ -f "mcp-servers.json" ]; then
    cp mcp-servers.json "$MCP_CONFIG_DIR/"
    echo "✅ Copied mcp-servers.json to $MCP_CONFIG_DIR"
else
    echo "❌ mcp-servers.json not found in current directory"
    exit 1
fi

# Pull GitHub MCP server Docker image
echo "📦 Pulling GitHub MCP server Docker image..."
docker pull ghcr.io/github/github-mcp-server

# Set permissions
chmod +x "$MCP_CONFIG_DIR/mcp-servers.json"

echo "✅ Gemini MCP setup completed!"
echo "📁 Config file location: $MCP_CONFIG_DIR/mcp-servers.json"
echo ""
echo "📝 Next steps:"
echo "1. Edit $MCP_CONFIG_DIR/mcp-servers.json and replace 'YOUR_GITHUB_PAT' with your actual GitHub Personal Access Token"
echo "2. Restart Gemini to load the GitHub MCP server"
echo ""
echo "🔑 To create a GitHub Personal Access Token:"
echo "   1. Go to GitHub Settings > Developer settings > Personal access tokens"
echo "   2. Generate a new token with appropriate permissions"
echo "   3. Replace 'YOUR_GITHUB_PAT' in the config file with your token"