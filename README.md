# code-harness

**[中文文档](./README.zh.md)**

A minimal harness for AI coding agents — full development lifecycle workflow, session discipline, and memory guidance in three drop-in files.

## Install

| Agent | Do this |
|-------|---------|
| **Claude Code** | Copy `CLAUDE.md` → `~/.claude/CLAUDE.md` |
| **Codex** | Copy `AGENTS.md` → project root |
| **Any other agent** | Copy `skills/` to your agent's skills directory |

That's it. No plugins required.

---

## What's Inside

**`CLAUDE.md` / `AGENTS.md`** — identical content, different filenames. Drop in and it activates.

**`skills/`** — two skills that auto-load when relevant:

| Skill | Activates when |
|-------|---------------|
| `workflow-guide` | Starting any feature or project |
| `harness-engineering` | Managing context, hitting loops, deciding what to remember |

### Behaviors enforced

- **Goal tracking** — `todo.md` created at task start, updated each step, deleted on completion
- **Loop detection** — same file edited 3+ times without resolution → stop, change approach
- **Verification gate** — type-check + critical path tests before claiming done
- **Memory guidance** — what to record across sessions: error patterns, corrections, preferences
- **Context hygiene** — when to `/compact` vs start a new session
- **Karpathy discipline** — think before coding, simplicity first, surgical changes, goal-driven

---

## Update

```bash
cd ~/.claude/code-harness && git pull
# re-copy CLAUDE.md if you want the latest:
cp CLAUDE.md ~/.claude/CLAUDE.md
```

---

## Contributing

PRs welcome. Skill improvements from real session failures are most valuable.

## License

MIT
