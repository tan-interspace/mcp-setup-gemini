# Gemini MCP Setup with GitHub Server

This repository contains configuration files and setup scripts for integrating the GitHub MCP (Model Context Protocol) server with Google Gemini.

## Overview

The setup includes:
- **GitHub MCP Server**: Docker-based GitHub integration for Gemini
- **Automated Setup Script**: Bash script for easy installation and configuration
- **Clean Configuration**: Streamlined setup with only the GitHub MCP server

## Files

- `mcp-servers.json` - MCP server configuration file
- `gemini-mcp-setup.sh` - Automated setup script
- `.env.example` - Environment variables template
- `README.md` - This documentation

## Prerequisites

- **Docker**: Required to run the GitHub MCP server
- **GitHub Personal Access Token**: For GitHub API authentication

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/tan-interspace/mcp-setup-gemini.git
   cd mcp-setup-gemini
   ```

2. **Configure environment variables**:
   ```bash
   cp .env.example .env
   # Edit .env file and add your GitHub Personal Access Token
   ```

3. **Run the setup script**:
   ```bash
   chmod +x gemini-mcp-setup.sh
   ./gemini-mcp-setup.sh
   ```

4. **Restart Gemini** to load the new MCP server

## Environment Variables Setup

### GitHub Personal Access Token

1. Go to [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
2. Generate a new token with appropriate permissions:
   - `repo` - Full control of private repositories
   - `read:org` - Read org and team membership
   - `user:email` - Access user email addresses
3. Copy the token and add it to your `.env` file:
   ```bash
   GITHUB_PERSONAL_ACCESS_TOKEN=your_actual_token_here
   ```

### Optional Configuration

For GitHub Enterprise users, you can also configure:
```bash
# GitHub Enterprise Server URL
GITHUB_ENTERPRISE_URL=https://your-github-enterprise.com

# Custom GitHub API URL
GITHUB_API_URL=https://api.your-github-enterprise.com
```

## Configuration Details

The MCP server configuration uses Docker to run the official GitHub MCP server:

```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_GITHUB_PAT"
      }
    }
  }
}
```

## Features

- **Docker-based**: No need to install Node.js or npm dependencies
- **Official GitHub MCP Server**: Uses the official GitHub container image
- **Secure**: Token-based authentication with GitHub API
- **Clean Setup**: Only includes the GitHub MCP server configuration

## Troubleshooting

- **Docker not found**: Make sure Docker is installed and running
- **Permission denied**: Ensure the setup script has execute permissions
- **GitHub API errors**: Verify your Personal Access Token has the correct permissions

## License

This project is open source and available under the [MIT License](LICENSE).
