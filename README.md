# fast-harness

**English** | [中文](#中文)

A Claude Code plugin that embeds harness engineering principles and a full development lifecycle workflow into three auto-activating skills. Built on [superpowers](https://github.com/obra/superpowers) and official Claude Code plugins — no reinvention.

## What's Included

| Skill | Activates when |
|-------|---------------|
| **workflow-guide** | Starting any feature, task, or project |
| **harness-engineering** | Managing context, hitting loops, deciding when to compact or upgrade model |
| **tools-reference** | Looking up which command or plugin to use |

## Philosophy

- **Harness over prompting** — configuration shapes agent behavior more reliably than one-shot instructions
- **Progressive disclosure** — skills load on demand, not all at once (no context bloat)
- **Don't reinvent wheels** — orchestrates superpowers + official plugins rather than duplicating them
- **Karpathy discipline** — think before coding, simplicity first, surgical changes, goal-driven execution

## Prerequisites

```bash
# 1. Core workflow engine
claude plugin marketplace add superpowers-dev https://github.com/obra/superpowers
claude plugin install superpowers@superpowers-dev

# 2. Companion plugins
claude plugin install feature-dev@claude-plugins-official
claude plugin install frontend-design@claude-plugins-official
claude plugin install code-review@claude-plugins-official
claude plugin install security-guidance@claude-plugins-official
claude plugin install commit-commands@claude-plugins-official
claude plugin install context7@claude-plugins-official
claude plugin install claude-md-management@claude-plugins-official
claude plugin install claude-code-setup@claude-plugins-official
```

## Install

```bash
claude plugin marketplace add fast-harness https://github.com/fast-harness/fast-harness
claude plugin install fast-harness
```

## Project-level Setup

For each new project, create a minimal `CLAUDE.md` then run:

```
/recommend-automations
```

This analyzes your project and suggests project-specific hooks, MCP servers, and additional plugins. Run `/update-claude-md` after each session to keep project memory current.

## License

MIT

---

# 中文

一个 Claude Code 插件，将 harness engineering 原则和完整的开发生命周期工作流内嵌为三个自动激活的 skill。基于 [superpowers](https://github.com/obra/superpowers) 和官方 Claude Code 插件构建，不重复造轮子。

## 包含的内容

| Skill | 激活时机 |
|-------|----------|
| **workflow-guide** | 开始任何功能、任务或项目时 |
| **harness-engineering** | 管理上下文、遇到循环、决定何时压缩或升级模型时 |
| **tools-reference** | 查询该用哪个命令或插件时 |

## 设计理念

- **配置优于提示** — harness 配置比一次性 prompt 更可靠地塑造 AI 行为
- **渐进式加载** — skill 按需加载，不会污染上下文
- **不重复造轮子** — 编排 superpowers 和官方插件，而非重复它们
- **Karpathy 编码纪律** — 动手前先想、简单优先、外科手术式修改、目标驱动执行

## 安装前置依赖

```bash
# 1. 核心工作流引擎
claude plugin marketplace add superpowers-dev https://github.com/obra/superpowers
claude plugin install superpowers@superpowers-dev

# 2. 配套插件
claude plugin install feature-dev@claude-plugins-official
claude plugin install frontend-design@claude-plugins-official
claude plugin install code-review@claude-plugins-official
claude plugin install security-guidance@claude-plugins-official
claude plugin install commit-commands@claude-plugins-official
claude plugin install context7@claude-plugins-official
claude plugin install claude-md-management@claude-plugins-official
claude plugin install claude-code-setup@claude-plugins-official
```

## 安装

```bash
claude plugin marketplace add fast-harness https://github.com/fast-harness/fast-harness
claude plugin install fast-harness
```

## 项目级初始化

每个新项目创建一个最简 `CLAUDE.md`，然后运行：

```
/recommend-automations
```

它会分析你的项目并推荐缺失的 plugin/hook/MCP。每次会话结束后运行 `/update-claude-md` 保持项目记忆更新。

## 开源协议

MIT
