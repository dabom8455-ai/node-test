#!/bin/bash
set -euo pipefail

# Only needed in Claude Code cloud sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# agent-browser CLI backs .claude/skills/agent-browser. It is a global install,
# so skip it when the binary is already present.
if ! command -v agent-browser >/dev/null 2>&1; then
  npm install -g agent-browser
fi

# Cloud images ship Chromium in /opt/pw-browsers, which agent-browser detects.
# Download Chrome for Testing only when it is missing.
if [ ! -d /opt/pw-browsers ]; then
  agent-browser install
fi
