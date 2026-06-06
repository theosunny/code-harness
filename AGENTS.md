## Development Workflow

### Two Paths

**Fast path** — clear scope, touches ≤3 files, no new dependencies:
Explore codebase → clarify any blockers → implement → verify (type-check + tests) → ship.

**Deliberate path** — architecture decisions, new dependencies, or changes touching 4+ files:
1. Clarify requirements through dialogue before writing any code
2. Produce a written spec/design document
3. Generate a step-by-step implementation plan
4. Write tests first, then implementation
5. Verify before claiming done — type-check + critical path tests pass
6. Review code before merging

When in doubt, ask the user which path to take.

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
For any task with 3+ steps: create `todo.md` after requirements are confirmed, update after each step, delete when done. Don't create it before the task is clear.

### Back-pressure
- Run a minimal verification set before claiming done (type-check + critical path tests only)
- If the same file has been edited 3+ times without resolution: stop, re-read `todo.md`, try a different approach
- On retry: append a failure summary, do not clear context

### Context Management
- Compact or start a new session when switching to unrelated work
- Keep instruction files under 60 lines — use progressive imports for larger content
- Don't pre-install tools speculatively; performance degrades above 15-30 tools

### Architecture Judgment
- Let AI handle: classification, drafting, summarization, unstructured text extraction
- Use deterministic code for: data fetching, routing, filtering, persistence

## Memory

No built-in memory system. Maintain a `## Memory` section at the bottom of this `AGENTS.md` file as persistent state across sessions.

**Append when:**
- User corrects your approach — add to `### Corrections` with the reason
- Same mistake made twice — add to `### Error patterns`
- Non-obvious approach confirmed by user — add to `### Validated approaches`
- **Don't append** when the session just started and nothing has happened yet

**Format:**
```
## Memory

### Corrections
- [YYYY-MM-DD] Don't do X. Reason: Y.

### Error patterns
- [YYYY-MM-DD] Mistake: X. Correct approach: Y.

### Preferences
- [add your own preferences here]
```

At session start: read the Memory section before doing anything else.
