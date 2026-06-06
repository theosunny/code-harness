# code-harness

This is a drop-in `CLAUDE.md` for Claude Code. Copy it to `~/.claude/CLAUDE.md` (global) or your project root.

## Development Workflow

### Two Paths

**Fast path** (clear, well-scoped features): `/feature-dev <description>` — 7-phase automated workflow.

**Deliberate path** (architecture decisions, multi-system changes):
1. Clarify requirements through dialogue before writing any code
2. Produce a written spec/design document
3. Generate a step-by-step implementation plan
4. Write tests first, then implementation
5. Verify before claiming done — run type-check + critical path tests
6. Review code before merging

### Key Rules

- Bug encountered → diagnose root cause systematically before patching
- Receiving review feedback → evaluate technically before implementing
- 2+ independent tasks → work in parallel where possible
- Feature needs isolation → use git worktrees

## Coding Discipline (Karpathy Rules)

1. **Think before coding** — state assumptions explicitly, ask when uncertain, surface tradeoffs
2. **Simplicity first** — minimum code that solves the problem, nothing speculative
3. **Surgical changes** — touch only what the task requires, don't improve adjacent code
4. **Goal-driven execution** — define success criteria upfront, write verifiable tests first

## Harness Engineering

### Goal Tracking
Create a `todo.md` at the start of any multi-step task. Update after each step. Delete when done. This prevents goal drift in long sessions.

### Back-pressure
- Run a minimal verification set before claiming done (type-check + critical path tests only)
- If the same file has been edited 3+ times without resolution: stop, re-read `todo.md`, try a different approach
- On retry: append a failure summary, do not clear context

### Context Management
- Compact (`/compact`) or start a new session when switching to unrelated work
- Keep this file under 60 lines — use `@`-imports for larger content
- Don't pre-install tools speculatively; performance degrades above 15–30 tools

### Architecture Judgment
- Let AI handle: classification, drafting, summarization, unstructured text extraction
- Use deterministic code for: data fetching, routing, filtering, persistence
