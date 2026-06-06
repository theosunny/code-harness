# code-harness

This is a drop-in `CLAUDE.md` for Claude Code. Copy to `~/.claude/CLAUDE.md` (global) or project root.

---

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
- Use `/compact` or start a new session when switching to unrelated work
- Keep this file under 60 lines — use `@`-imports for larger content
- Don't pre-install tools speculatively; performance degrades above 15–30 tools

### Architecture Judgment
- Let AI handle: classification, drafting, summarization, unstructured text extraction
- Use deterministic code for: data fetching, routing, filtering, persistence

## Memory

Use the built-in memory system at `~/.claude/projects/<project-hash>/memory/`.

**Write a memory when:**
- User corrects your approach — save immediately with the reason (`type: feedback`)
- Same mistake made twice — second occurrence is the trigger (`type: feedback`)
- Non-obvious approach confirmed by user — save as validated choice (`type: feedback`)
- Learn something about user role, preferences, or context (`type: user`)

**Don't write:**
- Code structure or file paths — read the current code
- Session activity — that's git history
- Anything already in CLAUDE.md

Each memory: one `.md` file with frontmatter (`name`, `description`, `type`), one-sentence rule, `Why:` line, `Apply when:` line. Update `MEMORY.md` index after each write.
