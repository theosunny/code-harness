# fast-harness

**[中文文档](./README.zh.md)**

> Stop prompting your AI. Configure it.

A plugin/skill pack that embeds **harness engineering principles** and a **full software development lifecycle** directly into your AI coding agent — so every session starts structured, stays on track, and finishes verified.

Works with Claude Code, Cursor, OpenCode, Codex, and Gemini CLI.

---

## Why fast-harness?

Most developers lose hours to the same AI pitfalls:

- The agent drifts off-goal halfway through a long session
- You ask it to fix a bug and it rewrites half the codebase
- It claims "done" without running a single check
- Context fills up with stale debugging noise, slowing everything down

fast-harness solves this at the **configuration layer**, not the prompt layer. Three auto-activating skills reshape how your agent thinks before it writes a single line of code.

---

## What's Included

| Skill | Activates when | What it does |
|-------|---------------|--------------|
| **workflow-guide** | Starting any feature, task, or project | Routes to fast path or deliberate path; enforces Karpathy discipline |
| **harness-engineering** | Managing context, hitting loops, deciding when to compact | Goal tracking, back-pressure, context hygiene, loop detection |
| **tools-reference** | Looking up which command or plugin to use | Quick reference for all installed skills and slash commands |

### Core Behaviors These Skills Enforce

**Goal tracking (todo.md pattern)**
At the start of any multi-step task, the agent creates `todo.md` and updates it after each step. This re-injects the current goal into the end of the context window — where attention is strongest — preventing drift in long sessions.

**Back-pressure mechanisms**
- Verification gate: agent must run type-check + critical path tests before claiming done
- Loop detection: if the same file is edited 3+ times without resolution → stop, re-read goal, change approach
- Failure evidence preservation: retries append failure summaries ("do not repeat this approach") rather than overwriting

**Context hygiene**
- CLAUDE.md total load stays under 60 lines (progressive `@` imports)
- No timestamps in system prompts (destroys KV-cache prefix — 10× cost difference)
- New session on task switches; don't mix unrelated work in one context

**Karpathy coding discipline**
1. Think before coding — state assumptions, surface tradeoffs, ask when uncertain
2. Simplicity first — minimum code that solves the problem, nothing speculative
3. Surgical changes — touch only what the task requires, don't improve adjacent code
4. Goal-driven execution — define "done" upfront, write verifiable tests first

---

## Two Development Paths

**Fast path** — for clear, well-scoped features:
```
/feature-dev <description>
```
7-phase automated workflow: explore → spec → plan → implement → test → review → commit.

**Deliberate path** — for architecture decisions, multi-system changes:
1. Requirements/idea → `superpowers:brainstorming` (dialogue → spec doc)
2. Design complete → `superpowers:writing-plans` (step-by-step implementation plan)
3. Implementation → `superpowers:test-driven-development` (tests first, then code)
4. Feature complete → `superpowers:verification-before-completion` (verify before claiming done)
5. Before merge → `superpowers:requesting-code-review` (review before merging)
6. Ship → `/commit` `/push`

---

## Philosophy

**Harness over prompting**
One-shot prompts are brittle. Configuration that runs every session is not. fast-harness is designed around this asymmetry: invest in the harness once, and every future session inherits the discipline.

**Don't reinvent wheels**
fast-harness orchestrates [superpowers](https://github.com/obra/superpowers) and official Claude Code plugins rather than duplicating them. The skills are thin coordination layers, not monolithic toolkits.

**Model-agnostic**
When the agent is stuck, it surfaces the signal to you — it doesn't decide which model to use. Model selection belongs to the developer, not the agent.

**Progressive disclosure**
Skills load on demand via the `Skill` tool. No context bloat from loading everything upfront.

---

## Supported Platforms

| Platform | Status | Install |
|----------|--------|---------|
| Claude Code | ✅ Native | [→ Install](#claude-code) |
| Cursor | ✅ Supported | [→ Install](#cursor) |
| OpenCode | ✅ Supported | [→ Install](#opencode) |
| Codex (OpenAI) | ✅ Supported | [→ Install](#codex-openai) |
| Gemini CLI | ✅ Supported | [→ Install](#gemini-cli) |
| Any agent | ✅ Via AGENTS.md | Copy `AGENTS.md` to your project root |

---

## Installation

### Claude Code

**Step 1 — Install the workflow engine and companion plugins:**

```bash
# Core workflow engine (superpowers skills platform)
claude plugin marketplace add superpowers-dev https://github.com/obra/superpowers
claude plugin install superpowers@superpowers-dev

# Full development lifecycle plugins
claude plugin install feature-dev@claude-plugins-official       # 7-phase feature workflow
claude plugin install frontend-design@claude-plugins-official   # High-quality UI generation
claude plugin install code-review@claude-plugins-official       # Multi-agent parallel review
claude plugin install security-guidance@claude-plugins-official # Real-time security scanning
claude plugin install commit-commands@claude-plugins-official   # Conventional commits
claude plugin install context7@claude-plugins-official          # Live framework docs
claude plugin install claude-md-management@claude-plugins-official
claude plugin install claude-code-setup@claude-plugins-official
```

**Step 2 — Install fast-harness:**

```bash
claude plugin marketplace add fast-harness https://github.com/fast-harness/fast-harness
claude plugin install fast-harness
```

**Step 3 — Set up your user-level CLAUDE.md:**

Create `~/.claude/CLAUDE.md` with progressive imports (keeps context load under 60 lines):

```markdown
# Global Configuration

@docs/workflow.md
@docs/harness.md
@docs/tools.md
```

See `examples/claude-md/` in this repo for the full file templates.

**Step 4 — Initialize each new project:**

```
/recommend-automations
```

Analyzes your project and suggests project-specific hooks, MCP servers, and additional plugins.

---

### Cursor

**Prerequisites:** Install superpowers for Cursor first — see [superpowers setup](https://github.com/obra/superpowers).

```bash
git clone https://github.com/fast-harness/fast-harness ~/.cursor/plugins/fast-harness
```

Add to your Cursor settings (`~/.cursor/settings.json` or project-level):

```json
{
  "plugins": ["~/.cursor/plugins/fast-harness"]
}
```

---

### OpenCode

Add to `opencode.json` (global `~/.config/opencode/opencode.json` or project-level):

```json
{
  "plugin": ["fast-harness@git+https://github.com/fast-harness/fast-harness.git"]
}
```

Restart OpenCode. Skills auto-register and activate based on task context.

---

### Codex (OpenAI)

**macOS / Linux:**

```bash
# Clone the repo
git clone https://github.com/fast-harness/fast-harness ~/.codex/fast-harness

# Link skills for auto-discovery
mkdir -p ~/.agents/skills
ln -s ~/.codex/fast-harness/skills ~/.agents/skills/fast-harness
```

**Windows (PowerShell):**

```powershell
git clone https://github.com/fast-harness/fast-harness "$env:USERPROFILE\.codex\fast-harness"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\fast-harness" "$env:USERPROFILE\.codex\fast-harness\skills"
```

Restart Codex. Skills are discovered automatically.

**Update:**

```bash
cd ~/.codex/fast-harness && git pull
```

---

### Gemini CLI

**Option A — Append to existing GEMINI.md:**

```bash
cat GEMINI.md >> ~/.gemini/GEMINI.md
```

**Option B — Clone and reference directly:**

```bash
git clone https://github.com/fast-harness/fast-harness ~/.config/fast-harness
```

Then add to your `~/.gemini/GEMINI.md`:

```
@~/.config/fast-harness/skills/workflow-guide/SKILL.md
@~/.config/fast-harness/skills/harness-engineering/SKILL.md
@~/.config/fast-harness/skills/tools-reference/SKILL.md
```

---

### Any Agent (AGENTS.md)

Copy `AGENTS.md` to your project root. This file contains all three skill principles inlined — no plugin discovery needed, works with any agent that reads `AGENTS.md` at session start.

```bash
cp AGENTS.md /path/to/your/project/AGENTS.md
```

---

## Updating

```bash
# Claude Code
claude plugin update fast-harness

# All other platforms — pull the repo
cd ~/.codex/fast-harness && git pull   # adjust path for your platform
```

---

## How It Works

fast-harness works through the **skill system** in Claude Code (and equivalents on other platforms). At session start, the `using-superpowers` skill is injected, which teaches the agent to invoke relevant skills before responding to any task. The three fast-harness skills are then loaded on demand — not all at once.

This means:
- Zero context overhead when skills aren't needed
- Full guidance loaded exactly when relevant
- Skills compose with superpowers and official plugins rather than replacing them

The `harness-engineering` skill in particular implements **back-pressure** — mechanisms that resist the natural tendency of long AI sessions to drift, loop, or hallucinate completion. This is the core insight: AI sessions need the same kind of engineering discipline as software systems.

---

## Contributing

PRs welcome. Key areas:
- New platform support (Windsurf, Amp, Continue, etc.)
- Skill improvements based on real session failures
- Example CLAUDE.md / AGENTS.md configurations for specific tech stacks

Please keep skills concise — token efficiency matters (see harness-engineering principle: >15 tools degrades performance, >30 is noticeably worse).

---

## License

MIT — use freely, attribution appreciated.
