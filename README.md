# fast-harness

**[中文文档](./README.zh.md)**

> Stop prompting your AI. Configure it.

A plugin/skill pack that embeds **harness engineering principles** and a **full software development lifecycle** directly into your AI coding agent — so every session starts structured, stays on track, and finishes verified.

*"Harness" here means a behavioral constraint system, not a test harness — think horse harness, not test runner.*

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
Skills load on demand. No context bloat from loading everything upfront.

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

> The skills, slash commands (`/feature-dev`, `/commit`, etc.), and memory system in this section are **Claude Code-specific**. Other platforms use different mechanisms — see their sections below.

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

Create `~/.claude/CLAUDE.md` (macOS/Linux) or `%USERPROFILE%\.claude\CLAUDE.md` (Windows):

```markdown
# Global Configuration

@docs/workflow.md
@docs/harness.md
@docs/tools.md
```

See `examples/claude-md/` in this repo for the full file templates.

**Step 4 — Initialize each new project:**

In any project, run:
```
/recommend-automations
```

Analyzes your project and suggests project-specific hooks, MCP servers, and additional plugins.

---

### Cursor

Cursor uses a skills directory, not a plugin registry. Skills placed in `~/.cursor/skills/` are available across all your projects; skills in `.cursor/skills/` (project root) are project-scoped.

**macOS / Linux:**

```bash
mkdir -p ~/.cursor/skills
git clone https://github.com/fast-harness/fast-harness /tmp/fast-harness
cp -r /tmp/fast-harness/skills/workflow-guide ~/.cursor/skills/
cp -r /tmp/fast-harness/skills/harness-engineering ~/.cursor/skills/
cp -r /tmp/fast-harness/skills/tools-reference ~/.cursor/skills/
```

**Windows (PowerShell):**

```powershell
$skillsDir = "$env:USERPROFILE\.cursor\skills"
New-Item -ItemType Directory -Force -Path $skillsDir
$tmp = "$env:TEMP\fast-harness"
git clone https://github.com/fast-harness/fast-harness $tmp
Copy-Item "$tmp\skills\workflow-guide" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\harness-engineering" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\tools-reference" -Destination $skillsDir -Recurse -Force
Remove-Item $tmp -Recurse -Force
```

Skills are auto-discovered by Cursor on next launch. No settings.json changes needed.

**Keep skills up to date:**

```bash
# macOS / Linux
cd /tmp && git clone https://github.com/fast-harness/fast-harness fh-update
cp -r fh-update/skills/workflow-guide ~/.cursor/skills/
cp -r fh-update/skills/harness-engineering ~/.cursor/skills/
cp -r fh-update/skills/tools-reference ~/.cursor/skills/
rm -rf fh-update
```

---

### OpenCode

Add to `opencode.json`. On **macOS/Linux** this is `~/.config/opencode/opencode.json`; on **Windows** it is `%USERPROFILE%\.config\opencode\opencode.json` or `%APPDATA%\OpenCode\opencode.json`.

```json
{
  "$schema": "https://opencode.ai/config.json",
  "plugin": ["fast-harness@git+https://github.com/fast-harness/fast-harness.git"]
}
```

Restart OpenCode. Skills auto-register and activate based on task context.

> If your OpenCode version doesn't support the `plugin` field yet, use the AGENTS.md fallback below.

---

### Codex (OpenAI)

Codex auto-discovers skills placed in `~/.codex/skills/`.

**macOS / Linux:**

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/fast-harness/fast-harness /tmp/fast-harness
cp -r /tmp/fast-harness/skills/workflow-guide ~/.codex/skills/
cp -r /tmp/fast-harness/skills/harness-engineering ~/.codex/skills/
cp -r /tmp/fast-harness/skills/tools-reference ~/.codex/skills/
rm -rf /tmp/fast-harness
```

**Windows (PowerShell):**

```powershell
$skillsDir = "$env:USERPROFILE\.codex\skills"
New-Item -ItemType Directory -Force -Path $skillsDir
$tmp = "$env:TEMP\fast-harness"
git clone https://github.com/fast-harness/fast-harness $tmp
Copy-Item "$tmp\skills\workflow-guide" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\harness-engineering" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\tools-reference" -Destination $skillsDir -Recurse -Force
Remove-Item $tmp -Recurse -Force
```

Restart Codex. Skills are discovered automatically.

**Update:**

Re-run the install commands above (they use `-Force` / overwrite, safe to repeat).

---

### Gemini CLI

**macOS / Linux — Option A (append to existing GEMINI.md):**

```bash
git clone https://github.com/fast-harness/fast-harness /tmp/fast-harness
cat /tmp/fast-harness/GEMINI.md >> ~/.gemini/GEMINI.md
rm -rf /tmp/fast-harness
```

**macOS / Linux — Option B (clone and reference via `@` imports):**

```bash
git clone https://github.com/fast-harness/fast-harness ~/.config/fast-harness
```

Add to `~/.gemini/GEMINI.md`:

```
@~/.config/fast-harness/skills/workflow-guide/SKILL.md
@~/.config/fast-harness/skills/harness-engineering/SKILL.md
@~/.config/fast-harness/skills/tools-reference/SKILL.md
```

**Windows (PowerShell) — Option B:**

```powershell
$dir = "$env:USERPROFILE\.config\fast-harness"
git clone https://github.com/fast-harness/fast-harness $dir
# Add these lines to %USERPROFILE%\.gemini\GEMINI.md:
# @$dir\skills\workflow-guide\SKILL.md
# @$dir\skills\harness-engineering\SKILL.md
# @$dir\skills\tools-reference\SKILL.md
```

> Note: `~` in Gemini CLI `@` imports resolves to `$HOME` on macOS/Linux. On Windows use the full path.

---

### Any Agent (AGENTS.md)

Copy `AGENTS.md` to your project root. All three skill principles are inlined — no plugin discovery needed. Works with any agent that reads `AGENTS.md` at session start (Codex, Gemini, custom agents).

```bash
cp AGENTS.md /path/to/your/project/AGENTS.md
```

---

## Updating

```bash
# Claude Code
claude plugin update fast-harness

# Cursor / Codex — re-run the install commands (safe to repeat, uses overwrite)

# Gemini CLI Option B
cd ~/.config/fast-harness && git pull
```

---

## How It Works

fast-harness works through the **skill system** in each platform. At session start, skills are discovered and their descriptions are scanned. When a task matches a skill's trigger conditions, the full skill content loads on demand.

The `harness-engineering` skill implements **back-pressure** — mechanisms that resist the natural tendency of long AI sessions to drift, loop, or hallucinate completion. The `workflow-guide` skill ensures the agent picks the right process path before touching any code.

The skills are plain markdown files — readable, forkable, and improvable without any build step.

---

## Contributing

PRs welcome. Key areas:
- New platform support (Windsurf, Amp, Continue, etc.)
- Skill improvements based on real session failures
- Example CLAUDE.md / AGENTS.md configurations for specific stacks

Please keep skills concise — token efficiency matters (skills above 500 lines load slower and crowd out context).

---

## License

MIT — use freely, attribution appreciated.
