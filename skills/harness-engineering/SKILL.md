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

## Memory: What to Remember Across Sessions

Not everything belongs in memory. The signal worth keeping is what was *surprising* or *non-obvious* — corrections, validated choices, recurring patterns.

**Save when:**
- User corrects your approach ("don't do X", "stop doing Y") — this is the most important category
- A non-obvious approach worked and the user confirmed it ("yes, exactly like that")
- The same mistake happens twice — the second occurrence is a signal to write it down
- User states an explicit preference that affects future work

**Don't save:**
- Code patterns, file structure, architecture — read the current code instead
- What you did in this session — that's git history
- Anything already in CLAUDE.md or the project docs

**Memory format** (save to `~/.claude/memory/` or equivalent):

```markdown
---
type: feedback | user | project | reference
---

[The rule or fact — one clear sentence]

Why: [the reason the user gave, or the incident that surfaced it]
Apply when: [the specific context where this matters]
```

**Three memory types that matter most:**

1. **Feedback** — corrections and validated choices. "Don't mock the database in tests — real integration tests only." Save the why so you can judge edge cases later.

2. **Error patterns** — if you made the same mistake twice, write down what the mistake was and the correct approach. This is the HermesAgent insight: agents that log their own failure patterns stop repeating them.

3. **User preferences** — communication style, code style, what they consider done vs not done.

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
