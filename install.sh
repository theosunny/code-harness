#!/bin/bash
# agent-rails installer — Claude Code + Codex
set -e

REPO="https://github.com/agent-rails/agent-rails"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
INSTALL_DIR="$CLAUDE_DIR/agent-rails"

echo "Installing agent-rails..."

# Clone or update
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Updating existing install..."
  git -C "$INSTALL_DIR" pull
else
  git clone "$REPO" "$INSTALL_DIR"
fi

# Claude Code: copy CLAUDE.md (merge if already exists)
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
mkdir -p "$CLAUDE_DIR"
if grep -q "agent-rails" "$CLAUDE_MD" 2>/dev/null; then
  echo "CLAUDE.md already configured, skipping."
elif [ -f "$CLAUDE_MD" ]; then
  echo "" >> "$CLAUDE_MD"
  cat "$INSTALL_DIR/CLAUDE.md" >> "$CLAUDE_MD"
  echo "Merged into existing $CLAUDE_MD"
else
  cp "$INSTALL_DIR/CLAUDE.md" "$CLAUDE_MD"
  echo "Installed $CLAUDE_MD"
fi

# Codex: copy skills to ~/.codex/skills/
if [ -d "$HOME/.codex" ]; then
  CODEX_SKILLS="$HOME/.codex/skills"
  mkdir -p "$CODEX_SKILLS"
  cp -r "$INSTALL_DIR/skills/workflow-guide" "$CODEX_SKILLS/"
  cp -r "$INSTALL_DIR/skills/harness-engineering" "$CODEX_SKILLS/"
  cp -r "$INSTALL_DIR/skills/tools-reference" "$CODEX_SKILLS/"
  echo "Installed Codex skills to $CODEX_SKILLS"
fi

echo ""
echo "Done. Restart your agent to activate."
