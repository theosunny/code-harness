---
name: tools-reference
description: Use when looking up which tool, plugin, or slash command to use for a specific development task — covers installed plugins, superpowers skills, slash commands, and MCP tools.
version: 1.0.0
---

# Tools Reference

## Required Dependencies

Install these before using fast-harness:

```bash
# Core workflow engine (required)
claude plugin marketplace add superpowers-dev https://github.com/obra/superpowers
claude plugin install superpowers@superpowers-dev

# Feature development lifecycle
claude plugin install feature-dev@claude-plugins-official
claude plugin install frontend-design@claude-plugins-official

# Code quality
claude plugin install code-review@claude-plugins-official
claude plugin install security-guidance@claude-plugins-official

# Git workflow
claude plugin install commit-commands@claude-plugins-official

# Live documentation lookup
claude plugin install context7@claude-plugins-official

# Project memory maintenance
claude plugin install claude-md-management@claude-plugins-official

# Missing plugin/hook detection
claude plugin install claude-code-setup@claude-plugins-official

# Optional: browser automation + E2E testing (enable per web project)
# claude plugin install playwright@claude-plugins-official
```

## Superpowers Skills (auto-triggered)

| Skill | When it fires |
|-------|---------------|
| `brainstorming` | Before any new feature or requirement |
| `writing-plans` | After design, to generate implementation plan |
| `test-driven-development` | Before implementing any feature or bugfix |
| `systematic-debugging` | On any bug or test failure |
| `verification-before-completion` | Before claiming a task is done |
| `requesting-code-review` | After completing significant work |
| `receiving-code-review` | When review feedback arrives |
| `using-git-worktrees` | Before isolated feature development |
| `dispatching-parallel-agents` | When 2+ independent tasks exist |
| `finishing-a-development-branch` | When implementation is complete, ready to merge |

## Slash Commands

| Command | Purpose |
|---------|---------|
| `/feature-dev <desc>` | 7-phase guided feature development |
| `/frontend-design` | Generate production-quality UI |
| `/code-review` | Multi-agent parallel PR review |
| `/commit` | Structured git commit |
| `/push` | Push to remote |
| `/update-claude-md` | Capture session learnings into project CLAUDE.md |
| `/claude-md-improver` | Audit and improve CLAUDE.md quality |
| `/recommend-automations` | Analyze project and suggest missing plugins/hooks/MCP |

## MCP Tools (always available when installed)

| Tool | Purpose |
|------|---------|
| **context7** | Fetch up-to-date docs for any library or SDK |
| **playwright** | Browser automation + E2E testing (enable per-project) |

## Always-on Protection

**security-guidance** — scans for injection, XSS, hardcoded secrets, and 25+ vulnerability classes on every file write. No invocation needed.
