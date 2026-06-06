# agent-rails

**[中文文档](./README.zh.md)**

> Guardrails for AI coding agents.

Three skills that keep your AI on track across the full development lifecycle — structured sessions, loop detection, context discipline, and verified completion.

Works with Claude Code and Codex out of the box. Drop `AGENTS.md` into any project for other agents.

---

## Install

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/agent-rails/agent-rails/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
iwr https://raw.githubusercontent.com/agent-rails/agent-rails/main/install.ps1 | iex
```

The script clones this repo into `~/.claude/agent-rails`, adds three `@`-imports to your `~/.claude/CLAUDE.md`, and copies skills to `~/.codex/skills/` if Codex is installed. That's it.

---

## What Gets Installed

| Skill | Activates when | What it does |
|-------|---------------|--------------|
| **workflow-guide** | Starting any feature or project | Routes to fast path (`/feature-dev`) or deliberate path; enforces Karpathy discipline |
| **harness-engineering** | Managing context, hitting loops, deciding when to compact | Goal tracking via `todo.md`, back-pressure mechanisms, loop detection |
| **tools-reference** | Looking up commands or plugins | Quick reference for installed skills and slash commands |

### What "guardrails" means in practice

- **Goal tracking** — agent creates `todo.md` at task start, updates after each step. Prevents goal drift in long sessions.
- **Loop detection** — same file edited 3+ times without resolution → stop, re-read goal, change approach
- **Verification gate** — must run type-check + critical path tests before claiming done
- **Context hygiene** — no timestamps in system prompts, CLAUDE.md under 60 lines, new session on task switches
- **Karpathy discipline** — think before coding, simplicity first, surgical changes, goal-driven execution

---

## Manual Install

If you prefer not to run the script:

**Claude Code** — clone and add to `~/.claude/CLAUDE.md`:
```bash
git clone https://github.com/agent-rails/agent-rails ~/.claude/agent-rails
```
```markdown
# add to ~/.claude/CLAUDE.md
@./agent-rails/skills/workflow-guide/SKILL.md
@./agent-rails/skills/harness-engineering/SKILL.md
@./agent-rails/skills/tools-reference/SKILL.md
```

**Codex** — copy skills to `~/.codex/skills/`:
```bash
cp -r ~/.claude/agent-rails/skills/workflow-guide ~/.codex/skills/
cp -r ~/.claude/agent-rails/skills/harness-engineering ~/.codex/skills/
cp -r ~/.claude/agent-rails/skills/tools-reference ~/.codex/skills/
```

**Other agents** — copy `AGENTS.md` to your project root. All principles are inlined, no discovery needed.

---

## Other Platforms

**Cursor** — copy to `~/.cursor/skills/` (macOS/Linux) or `%USERPROFILE%\.cursor\skills\` (Windows):
```bash
cp -r ~/.claude/agent-rails/skills/* ~/.cursor/skills/
```

**OpenCode** — add to `opencode.json`:
```json
{ "$schema": "https://opencode.ai/config.json", "plugin": ["agent-rails@git+https://github.com/agent-rails/agent-rails.git"] }
```

**Gemini CLI** — append `GEMINI.md` to your `~/.gemini/GEMINI.md`:
```bash
cat ~/.claude/agent-rails/GEMINI.md >> ~/.gemini/GEMINI.md
```

---

## Update

```bash
cd ~/.claude/agent-rails && git pull
# Re-copy Codex skills if needed:
cp -r skills/workflow-guide ~/.codex/skills/
cp -r skills/harness-engineering ~/.codex/skills/
cp -r skills/tools-reference ~/.codex/skills/
```

---

## Claude Code Plugin (optional)

If you prefer the plugin registry over `@`-imports:
```bash
claude plugin marketplace add agent-rails https://github.com/agent-rails/agent-rails
claude plugin install agent-rails
```

<details>
<summary>Companion plugins — unlock /feature-dev, /code-review, and other slash commands (Claude Code only)</summary>

```bash
claude plugin marketplace add superpowers-dev https://github.com/obra/superpowers
claude plugin install superpowers@superpowers-dev
claude plugin install feature-dev@claude-plugins-official
claude plugin install frontend-design@claude-plugins-official
claude plugin install code-review@claude-plugins-official
claude plugin install security-guidance@claude-plugins-official
claude plugin install commit-commands@claude-plugins-official
claude plugin install context7@claude-plugins-official
claude plugin install claude-md-management@claude-plugins-official
```

</details>

---

## Contributing

PRs welcome — new platform support, skill improvements from real session failures, stack-specific CLAUDE.md examples.

Keep skills under 500 lines. Token count matters.

---

## License

MIT
