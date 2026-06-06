---
name: workflow-guide
description: Use when starting any development task, feature, or project — covers the full lifecycle from requirements to release, with fast-path and deliberate-path options and Karpathy coding discipline rules.
version: 1.0.0
---

# Development Workflow Guide

## Two Paths

**Fast path** (clear, well-scoped features): `/feature-dev <description>` → 7-phase automated workflow

**Deliberate path** (architecture decisions, multi-system changes):
1. **Requirements** → `superpowers:brainstorming` — clarify through dialogue, produce a spec doc
2. **Design done** → `superpowers:writing-plans` — generate a step-by-step implementation plan
3. **Implementation** → `superpowers:test-driven-development` — write tests first, then code
4. **Feature complete** → `superpowers:verification-before-completion` — verify before claiming done
5. **Before merge** → `superpowers:requesting-code-review` — review before merging
6. **Ship** → `/commit` `/push`

## Key Rules

- Bug encountered → `superpowers:systematic-debugging` first, never guess-and-patch
- Receiving review feedback → `superpowers:receiving-code-review`, never blindly implement
- 2+ independent tasks → `superpowers:dispatching-parallel-agents`
- Feature needs isolation → `superpowers:using-git-worktrees`

## Coding Discipline (Karpathy Rules)

1. **Think before coding** — state assumptions explicitly, ask when uncertain, surface tradeoffs
2. **Simplicity first** — minimum code that solves the problem, nothing speculative
3. **Surgical changes** — touch only what the task requires, don't improve adjacent code
4. **Goal-driven execution** — define success criteria upfront, write verifiable tests first
