# fast-harness

[English](./README.md)

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

## 支持的平台

| 平台 | 安装方式 |
|------|---------|
| Claude Code | [→ Claude Code](#claude-code) |
| Cursor | [→ Cursor](#cursor) |
| OpenCode | [→ OpenCode](#opencode) |
| Codex (OpenAI) | [→ Codex](#codex-openai) |
| Gemini CLI | [→ Gemini CLI](#gemini-cli) |
| 任意 Agent | 复制 `AGENTS.md` 到项目根目录 |

---

## Claude Code

### 安装前置依赖

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

### 安装

```bash
claude plugin marketplace add fast-harness https://github.com/fast-harness/fast-harness
claude plugin install fast-harness
```

---

## Cursor

### 前置依赖

先安装 superpowers for Cursor，参考 [superpowers Cursor 安装说明](https://github.com/obra/superpowers)。

### 安装

```bash
git clone https://github.com/fast-harness/fast-harness ~/.cursor/plugins/fast-harness
```

在 Cursor 设置中添加：
```json
{
  "plugins": ["~/.cursor/plugins/fast-harness"]
}
```

---

## OpenCode

在 `opencode.json`（全局 `~/.config/opencode/opencode.json` 或项目级）中添加：

```json
{
  "plugin": ["fast-harness@git+https://github.com/fast-harness/fast-harness.git"]
}
```

重启 OpenCode，skill 自动注册。

---

## Codex (OpenAI)

```bash
# 1. 克隆仓库
git clone https://github.com/fast-harness/fast-harness ~/.codex/fast-harness

# 2. 链接 skills 目录供自动发现
mkdir -p ~/.agents/skills
ln -s ~/.codex/fast-harness/skills ~/.agents/skills/fast-harness
```

**Windows (PowerShell)：**
```powershell
git clone https://github.com/fast-harness/fast-harness "$env:USERPROFILE\.codex\fast-harness"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\fast-harness" "$env:USERPROFILE\.codex\fast-harness\skills"
```

重启 Codex，skill 自动发现。

---

## Gemini CLI

将 `GEMINI.md` 内容追加到你的 `GEMINI.md`：

```bash
cat GEMINI.md >> ~/.gemini/GEMINI.md
```

或克隆后直接引用：
```bash
git clone https://github.com/fast-harness/fast-harness ~/.config/fast-harness
# 在 GEMINI.md 中添加：
# @~/.config/fast-harness/skills/workflow-guide/SKILL.md
# @~/.config/fast-harness/skills/harness-engineering/SKILL.md
# @~/.config/fast-harness/skills/tools-reference/SKILL.md
```

---

## 项目级初始化

每个新项目创建一个最简配置文件（CLAUDE.md 或对应平台的文件），然后运行：

```
/recommend-automations
```

它会分析你的项目并推荐缺失的 plugin/hook/MCP。每次会话结束后运行 `/update-claude-md` 保持项目记忆更新。

## 开源协议

MIT
