# code-harness

**[English](./README.md)**

给 AI coding agent 的最小化 harness——完整开发生命周期工作流、会话纪律、记忆指导，三个 drop-in 文件搞定。

## 安装

| Agent | 操作 |
|-------|------|
| **Claude Code** | 复制 `CLAUDE.md` → `~/.claude/CLAUDE.md` |
| **Codex** | 复制 `AGENTS.md` → 项目根目录 |
| **其他 Agent** | 复制 `skills/` 到你的 agent skills 目录 |

完成，无需安装插件。

---

## 包含的内容

**`CLAUDE.md` / `AGENTS.md`** — 内容相同，文件名不同。放进去就生效。

**`skills/`** — 两个按需自动加载的 skill：

| Skill | 激活时机 |
|-------|----------|
| `workflow-guide` | 开始任何功能或项目时 |
| `harness-engineering` | 管理上下文、遇到循环、决定记住什么时 |

### 强制执行的行为

- **目标追踪** — 任务开始时创建 `todo.md`，每步更新，完成后删除
- **循环检测** — 同一文件改了 3 次以上仍未解决 → 停下来，换思路
- **验证门控** — 类型检查 + 关键路径测试通过后才能声明完成
- **记忆指导** — 跨会话该记录什么：错误模式、被纠正的做法、用户偏好
- **上下文卫生** — 何时 `/compact`，何时开新会话
- **Karpathy 纪律** — 动手前先想、简单优先、外科手术式修改、目标驱动

---

## 更新

```bash
cd ~/.claude/code-harness && git pull
# 如需同步最新的 CLAUDE.md：
cp CLAUDE.md ~/.claude/CLAUDE.md
```

---

## 参与贡献

欢迎 PR，基于真实会话失败的 skill 改进最有价值。

## 开源协议

MIT
