FROM node:22-slim

# 1. Install system dependencies as root
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 2. Install Claude Code globally as root (This fixes the EACCES error)
RUN npm install -g @anthropic-ai/claude-code

# 3. Setup directories and permissions
# We create the folder and give ownership to the 'node' user before switching
RUN mkdir -p /home/node/.claude/plugins && chown -R node:node /home/node

# 4. Set the working directory
WORKDIR /app

# 5. NOW switch to the non-root user (Required for --dangerously-skip-permissions)
USER node

# 6. Force git to use HTTPS for the node user (Fixes plugin install errors)
RUN git config --global url."https://github.com/".insteadOf git@github.com:

# Set entrypoint to Claude
ENTRYPOINT ["claude"]
