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

# Claude Code: add @-imports to CLAUDE.md
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
if grep -q "agent-rails" "$CLAUDE_MD" 2>/dev/null; then
  echo "CLAUDE.md already configured, skipping."
else
  mkdir -p "$CLAUDE_DIR"
  cat >> "$CLAUDE_MD" << 'EOF'

# agent-rails
@./agent-rails/skills/workflow-guide/SKILL.md
@./agent-rails/skills/harness-engineering/SKILL.md
@./agent-rails/skills/tools-reference/SKILL.md
EOF
  echo "Added to $CLAUDE_MD"
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
