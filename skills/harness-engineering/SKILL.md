---
name: harness-engineering
description: Use when managing context length, deciding whether to compact or start a new session, experiencing goal drift in long conversations, hitting repeated loops, or deciding whether to upgrade the model.
version: 1.0.0
---

# Harness Engineering Principles

## Goal Tracking: todo.md Pattern

Create a `todo.md` at the start of any multi-step task. Update it after each step. This re-injects the current goal into the end of the context window (where attention is strongest), preventing goal drift in long conversations. Delete it when the task is complete.

## Back-pressure Mechanisms

- **Verification gate** — before claiming done, run a minimal verification set (type-check + critical path tests), not the full suite
- **Loop detection** — if the same file has been edited 3+ times without resolution, stop, re-read `todo.md`, try a different approach
- **Preserve failure evidence** — on retry, append a failure summary and "do not repeat this approach" rather than clearing context

## Context Management: When to Compact / New Session

**Trigger `/compact` when:**
- A complete phase is done (feature built, bug fixed) and you're starting the next subtask
- Context contains large volumes of resolved debugging back-and-forth no longer needed
- Claude starts repeating things already established

**Start a new session when:**
- Switching to a different project or unrelated task
- 3+ consecutive loop failures after changing approach
- The current session has accumulated unrelated work and context is polluted

**Don't compact when:**
- Actively debugging — failure evidence is still needed
- `todo.md` still has incomplete steps

## Model Upgrade Signals

- Same problem attempted 2+ times by Sonnet without progress → upgrade to Opus
- Complex architecture decisions or multi-file reasoning required → Opus for planning, Sonnet for execution

## Context Hygiene

- Keep total CLAUDE.md loaded content under 60 lines (progressive `@` imports help)
- Start a new session on task switches — don't mix unrelated work in one context
- Don't pre-install tools speculatively: performance degrades above 15 tools, noticeably above 30

## Tool Selection

Prefer CLI over MCP. If a CLI tool has strong training data coverage, it's faster and more reliable than an equivalent MCP server. Only add MCP when CLI isn't sufficient.

## Architecture Judgment

- Let AI handle: classification, drafting, summarization, unstructured text extraction
- Use deterministic code for: data fetching, routing, filtering, persistence
