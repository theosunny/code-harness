# code-harness

**[ä¸­æ–‡æ–‡æ¡£](./README.zh.md)**

> Your AI coding agent keeps drifting off-task, rewriting things you didn't ask for, or saying "done" without running a single test. code-harness fixes this at the configuration layer â€?not with prompts you have to repeat every session.

A drop-in configuration pack for Claude Code and Codex that enforces structured development workflow, session discipline, and cross-session memory. Works by shipping proven principles as `CLAUDE.md` / `AGENTS.md` files and auto-activating skills â€?no plugins, no setup scripts.

---

## The Problem

Long AI coding sessions fail in predictable ways:

- **Goal drift** â€?the agent forgets what it was doing halfway through a complex task
- **Scope creep** â€?asked to fix a bug, it rewrites unrelated code
- **False completion** â€?claims done without running type checks or tests
- **Loop waste** â€?edits the same file repeatedly with the same broken approach
- **Context bloat** â€?stale debugging back-and-forth fills the context, making everything slower
- **Memory loss** â€?corrects the same mistake every new session because nothing was recorded

These aren't model problems. They're discipline problems. code-harness enforces the discipline.

---

## How It Works

Drop a single file into your agent's config directory. That's the entire install.

The file contains:
- **Workflow routing** â€?fast path for clear tasks, deliberate path (spec â†?plan â†?TDD â†?verify â†?review) for complex ones
- **Karpathy coding rules** â€?think before coding, surgical changes only, simplicity first
- **Harness engineering** â€?`todo.md` goal tracking, loop detection (3 edits â†?stop and rethink), verification gate before claiming done
- **Memory guidance** â€?what's worth recording across sessions: corrections, error patterns, user preferences; what isn't (code structure, git history)
- **Context hygiene** â€?when to compact, when to start a new session, how to keep instruction files lean

The `skills/` directory contains two skills for agents that support auto-loading (Claude Code, Cursor, Codex):
- `workflow-guide` â€?activates when starting any feature or project
- `harness-engineering` â€?activates when managing context, hitting loops, or deciding what to remember

---

## Install

| Agent | Do this |
|-------|---------|
| **Claude Code** | Copy `CLAUDE.md` â†?`~/.claude/CLAUDE.md` |
| **Codex** | Copy `AGENTS.md` â†?your project root |
| **Cursor / other** | Copy `skills/` â†?your agent's skills directory |

No plugins required. No scripts. One file copy.

**Clone first (recommended â€?makes updates easy):**

```bash
git clone https://github.com/theosunny/code-harness ~/.claude/code-harness

# Claude Code
cp ~/.claude/code-harness/CLAUDE.md ~/.claude/CLAUDE.md

# Codex (run in your project root)
cp ~/.claude/code-harness/AGENTS.md ./AGENTS.md
```

**Windows (PowerShell):**

```powershell
git clone https://github.com/theosunny/code-harness "$env:USERPROFILE\.claude\code-harness"

# Claude Code
Copy-Item "$env:USERPROFILE\.claude\code-harness\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md"
```

---

## Behaviors Enforced

### Goal tracking
At the start of any multi-step task, the agent creates `todo.md` and updates it after each step. This re-injects the current goal into the end of the context window â€?where attention is strongest â€?preventing drift in long sessions.

### Loop detection
If the same file is edited 3+ times without resolving the issue: stop, re-read the goal, try a fundamentally different approach. No more spinning on the same broken fix.

### Verification gate
Before claiming a task is done, the agent must run a minimal verification set â€?type-check and critical-path tests. "Done" means verified, not just written.

### Memory guidance
The agent logs what's worth keeping across sessions:
- **Corrections** â€?when you say "don't do X", that gets recorded with the reason
- **Error patterns** â€?the same mistake twice means write it down (HermesAgent principle)
- **Preferences** â€?communication style, code style, what you consider complete

### Context hygiene
- No timestamps in system prompts (breaks KV-cache, 10Ã— cost)
- Instruction files stay lean; `/compact` when a phase is done
- New session on task switches â€?don't mix unrelated work

### Karpathy coding discipline
1. Think before coding â€?state assumptions, ask when uncertain
2. Simplicity first â€?minimum code that solves the problem
3. Surgical changes â€?touch only what the task requires
4. Goal-driven â€?define done upfront, write verifiable tests first

---

## Update

```bash
cd ~/.claude/code-harness && git pull
cp CLAUDE.md ~/.claude/CLAUDE.md   # apply latest
```

---

## Contributing

Real session failure reports make the best PRs. If the agent violated one of these principles in a way the current config didn't prevent, that's a bug worth fixing.

## License

MIT
