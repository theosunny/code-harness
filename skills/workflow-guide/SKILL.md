---
name: workflow-guide
description: Use when starting any development task, feature, or project — covers the full lifecycle from requirements to release, with fast-path and deliberate-path options and Karpathy coding discipline rules.
version: 1.0.0
---

# Development Workflow Guide

## Two Paths

**Fast path** (clear, well-scoped features):
Explore codebase → clarify requirements → implement → verify (type-check + tests) → ship.

**Deliberate path** (architecture decisions, multi-system changes):
1. **Requirements** — clarify through dialogue, produce a written spec before any code
2. **Plan** — break into ordered steps, identify dependencies, estimate risks
3. **Implementation** — write tests first, then code (TDD)
4. **Verify** — type-check + critical path tests pass before claiming done
5. **Review** — get a second read before merging
6. **Ship** — commit with clear message, push

## Key Rules

- Bug encountered → diagnose root cause first, never guess-and-patch
- Receiving review feedback → evaluate technically before implementing
- 2+ independent tasks → work in parallel
- Feature needs isolation → use git worktrees

## Coding Discipline (Karpathy Rules)

1. **Think before coding** — state assumptions explicitly, ask when uncertain, surface tradeoffs
2. **Simplicity first** — minimum code that solves the problem, nothing speculative
3. **Surgical changes** — touch only what the task requires, don't improve adjacent code
4. **Goal-driven execution** — define success criteria upfront, write verifiable tests first
