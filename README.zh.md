# agent-rails

**[English](./README.md)**

> 给 AI coding agent 加护轨。

三个 skill，让你的 AI 在整个开发生命周期中保持正轨——有结构的会话、循环检测、上下文纪律、经过验证才算完成。

开箱即用支持 Claude Code 和 Codex。其他 agent 把 `AGENTS.md` 放到项目根目录即可。

---

## 安装

**macOS / Linux：**
```bash
curl -fsSL https://raw.githubusercontent.com/agent-rails/agent-rails/main/install.sh | bash
```

**Windows（PowerShell）：**
```powershell
iwr https://raw.githubusercontent.com/agent-rails/agent-rails/main/install.ps1 | iex
```

脚本会把本仓库克隆到 `~/.claude/agent-rails`，向 `~/.claude/CLAUDE.md` 添加三行 `@` 导入，如果检测到 Codex 则同时复制 skill 到 `~/.codex/skills/`。完成。

---

## 安装了什么

| Skill | 激活时机 | 作用 |
|-------|----------|------|
| **workflow-guide** | 开始任何功能或项目时 | 快速通道（`/feature-dev`）或完整通道路由；强制 Karpathy 纪律 |
| **harness-engineering** | 管理上下文、遇到循环、决定何时压缩时 | `todo.md` 目标追踪、反压机制、循环检测 |
| **tools-reference** | 查询命令或插件时 | 已安装 skill 和斜杠命令的快速参考 |

### "护轨"的实际含义

- **目标追踪** — 任务开始时创建 `todo.md`，每步完成后更新。防止长对话中目标漂移。
- **循环检测** — 同一文件改了 3 次以上仍未解决 → 停下来，重读目标，换思路
- **验证门控** — 声明完成前必须运行类型检查 + 关键路径测试
- **上下文卫生** — 系统提示不包含时间戳，CLAUDE.md 保持 60 行以内，任务切换时开新会话
- **Karpathy 纪律** — 动手前先想、简单优先、外科手术式修改、目标驱动执行

---

## 手动安装

不想跑脚本的话：

**Claude Code** — 克隆并添加到 `~/.claude/CLAUDE.md`：
```bash
git clone https://github.com/agent-rails/agent-rails ~/.claude/agent-rails
```
```markdown
# 添加到 ~/.claude/CLAUDE.md
@./agent-rails/skills/workflow-guide/SKILL.md
@./agent-rails/skills/harness-engineering/SKILL.md
@./agent-rails/skills/tools-reference/SKILL.md
```

**Codex** — 复制 skill 到 `~/.codex/skills/`：
```bash
cp -r ~/.claude/agent-rails/skills/workflow-guide ~/.codex/skills/
cp -r ~/.claude/agent-rails/skills/harness-engineering ~/.codex/skills/
cp -r ~/.claude/agent-rails/skills/tools-reference ~/.codex/skills/
```

**其他 agent** — 复制 `AGENTS.md` 到项目根目录。所有原则已内联，无需插件发现机制。

---

## 其他平台

**Cursor** — 复制到 `~/.cursor/skills/`（macOS/Linux）或 `%USERPROFILE%\.cursor\skills\`（Windows）：
```bash
cp -r ~/.claude/agent-rails/skills/* ~/.cursor/skills/
```

**OpenCode** — 添加到 `opencode.json`：
```json
{ "$schema": "https://opencode.ai/config.json", "plugin": ["agent-rails@git+https://github.com/agent-rails/agent-rails.git"] }
```

**Gemini CLI** — 追加 `GEMINI.md` 到 `~/.gemini/GEMINI.md`：
```bash
cat ~/.claude/agent-rails/GEMINI.md >> ~/.gemini/GEMINI.md
```

---

## 更新

```bash
cd ~/.claude/agent-rails && git pull
# 如需同步 Codex skills：
cp -r skills/workflow-guide ~/.codex/skills/
cp -r skills/harness-engineering ~/.codex/skills/
cp -r skills/tools-reference ~/.codex/skills/
```

---

## Claude Code 插件方式（可选）

如果偏好插件注册表而不是手动 `@` 导入：
```bash
claude plugin marketplace add agent-rails https://github.com/agent-rails/agent-rails
claude plugin install agent-rails
```

<details>
<summary>配套插件 — 解锁 /feature-dev、/code-review 等斜杠命令（仅 Claude Code）</summary>

```bash
claude plugin marketplace add superpowers-dev https://github.com/obra/superpowers
claude plugin install superpowers@superpowers-dev
claude plugin install feature-dev@claude-plugins-official
claude plugin install frontend-design@claude-plugins-official
claude plugin install code-review@claude-plugins-official
claude plugin install security-guidance@claude-plugins-official
claude plugin install commit-commands@claude-plugins-official
claude plugin install context7@claude-plugins-official
claude plugin install claude-md-management@claude-plugins-official
```

</details>

---

## 参与贡献

欢迎 PR——新平台支持、基于真实失败案例的 skill 改进、特定技术栈的 CLAUDE.md 示例。

请保持 skill 在 500 行以内，token 数量很重要。

---

## 开源协议

MIT
