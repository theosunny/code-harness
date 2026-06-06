---
name: harness-engineering
description: Use when managing context length, deciding whether to compact or start a new session, experiencing goal drift in long conversations, hitting repeated loops, or deciding what to remember across sessions.
version: 1.0.0
---

# Harness Engineering Principles

## Goal Tracking: todo.md Pattern

Create a `todo.md` at the start of any multi-step task. Update it after each step. This re-injects the current goal into the end of the context window (where attention is strongest), preventing goal drift in long conversations. Delete it when the task is complete.

## Back-pressure Mechanisms

- **Verification gate** — before claiming done, run a minimal verification set (type-check + critical path tests), not the full suite
- **Loop detection** — if the same file has been edited 3+ times without resolution, stop, re-read `todo.md`, try a different approach
- **Preserve failure evidence** — on retry, append a failure summary and "do not repeat this approach" rather than clearing context

## Memory: How to Remember Across Sessions

### Claude Code

Claude Code has a built-in file-based memory system. Use it actively.

**Storage location:** `~/.claude/projects/<project-hash>/memory/`  
Each memory is a separate `.md` file. `MEMORY.md` is the index — one line per entry.

**File format:**
```markdown
---
name: short-kebab-slug
description: one-line summary used to decide relevance in future sessions
type: feedback | user | project | reference
---

[The rule or fact — one clear sentence]

Why: [the reason or incident that surfaced it]
Apply when: [the context where this matters]
```

**MEMORY.md index format:**
```markdown
# Memory Index

- [Title](filename.md) — one-line hook under 150 chars
```

**When to write a memory:**
- User corrects your approach → write immediately as `type: feedback`
- Same mistake made twice → second occurrence is the signal; write `type: feedback` with the error pattern
- User confirms a non-obvious choice worked → write as `type: feedback` (validated approach)
- You learn something about the user's role, preferences, or context → write as `type: user`
- Project-specific decisions, constraints, deadlines → write as `type: project`

**When NOT to write:**
- Code patterns or file structure — read the current code instead
- What happened in this session — that's git history
- Anything already documented in CLAUDE.md or project docs

**Reading memories:** At session start, read `MEMORY.md` index first. Load individual files only when relevant to the current task. Don't bulk-load everything.

### Codex / Other Agents

No built-in memory system. Use `AGENTS.md` in the project root as persistent state.

Append a `## Memory` section to the project's `AGENTS.md`:

```markdown
## Memory

### Corrections
- [date] Don't mock the database in tests — use real integration tests. Reason: mocks masked a broken migration.

### Error patterns
- [date] Checked if path exists before reading — should use try/catch instead (ENOENT is not always an error).

### Preferences
- Respond in Chinese; code and comments in English.
```

This is manual but durable — it survives session resets and is visible in the repo.

## Context Management: When to Compact / New Session

**Trigger `/compact` when:**
- A complete phase is done and you're starting the next subtask
- Context contains large volumes of resolved debugging no longer needed
- You're repeating things already established

**Start a new session when:**
- Switching to a different project or unrelated task
- 3+ consecutive loop failures after changing approach

**Don't compact when:**
- Actively debugging — failure evidence is still needed
- `todo.md` still has incomplete steps

## When the Current Model Isn't Enough

If the same problem has been attempted multiple times without progress — **tell the user**. Describe what's stuck and why. The decision of which model to use belongs to the user, not the agent.

## Context Hygiene

- Keep total loaded instruction content lean — use progressive `@` imports
- No timestamps in system prompts (destroys KV-cache prefix — 10× cost difference)
- Don't pre-install tools speculatively: performance degrades above 15 tools, noticeably above 30

## Tool Selection

Prefer CLI over MCP. If a CLI tool has strong training coverage, it's faster and more reliable than an equivalent MCP server. Only add MCP when CLI isn't sufficient.

## Architecture Judgment

- Let AI handle: classification, drafting, summarization, unstructured text extraction
- Use deterministic code for: data fetching, routing, filtering, persistence
