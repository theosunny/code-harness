# code-harness

**[English](./README.md)**

> 你的 AI 编程助手一直在跑偏、改你没让它改的东西、或者没跑一个测试就说"完成"。code-harness 在配置层解决这个问题——不靠每次会话都要重复的 prompt。

一个适用于 Claude Code 和 Codex 的 drop-in 配置包，强制执行结构化开发工作流、会话纪律和跨会话记忆。通过将经过验证的原则打包成 `CLAUDE.md` / `AGENTS.md` 文件和自动激活的 skill 来实现——无需插件，无需安装脚本。

---

## 问题所在

长时间的 AI 编程会话以可预测的方式失败：

- **目标漂移** — 处理复杂任务到一半，agent 忘了它在做什么
- **范围蔓延** — 让它修一个 bug，却改了不相关的代码
- **虚报完成** — 没跑类型检查或测试就说"完成"
- **循环浪费** — 用同一种错误方法反复修改同一个文件
- **上下文膨胀** — 过期的调试记录填满上下文，让一切变慢
- **记忆丢失** — 每次新会话都在纠正同一个错误，因为什么都没记录

这些不是模型问题，是纪律问题。code-harness 强制执行这套纪律。

---

## 工作原理

把一个文件放到你的 agent 配置目录里。这就是全部安装步骤。

这个文件包含：
- **工作流路径** — 清晰任务走快速通道，复杂任务走完整通道（需求 → 计划 → TDD → 验证 → review）
- **Karpathy 编码规则** — 动手前先想、只做外科手术式修改、简单优先
- **Harness 工程** — `todo.md` 目标追踪、循环检测（改了 3 次 → 停下换思路）、声明完成前的验证门控
- **记忆指导** — 跨会话值得记录的内容：纠正、错误模式、用户偏好；不值得记的：代码结构、git 历史
- **上下文卫生** — 何时压缩，何时开新会话，如何保持指令文件轻量

`skills/` 目录包含两个适用于支持自动加载的 agent（Claude Code、Cursor、Codex）的 skill：
- `workflow-guide` — 开始任何功能或项目时激活
- `harness-engineering` — 管理上下文、遇到循环、决定记什么时激活

---

## 安装

| Agent | 操作 |
|-------|------|
| **Claude Code** | 复制 `CLAUDE.md` 到 `~/.claude/CLAUDE.md` |
| **Codex** | 复制 `AGENTS.md` 到项目根目录 |
| **Cursor / 其他** | 复制 `skills/` 到 agent 的 skills 目录 |

无需插件，无需脚本，复制一个文件即可。

**推荐先 clone（方便后续更新）：**

```bash
git clone https://github.com/theosunny/code-harness ~/.claude/code-harness

# Claude Code
cp ~/.claude/code-harness/CLAUDE.md ~/.claude/CLAUDE.md

# Codex（在项目根目录运行）
cp ~/.claude/code-harness/AGENTS.md ./AGENTS.md
```

**Windows（PowerShell）：**

```powershell
git clone https://github.com/theosunny/code-harness "$env:USERPROFILE\.claude\code-harness"

# Claude Code
Copy-Item "$env:USERPROFILE\.claude\code-harness\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md"
```

---

## 强制执行的行为

### 目标追踪
任何多步骤任务开始时，agent 创建 `todo.md` 并在每步完成后更新。这把当前目标重新注入到上下文末尾（注意力最强的地方），防止长对话中的目标漂移。

### 循环检测
同一文件被修改 3 次以上仍未解决：停下来，重新读目标，尝试本质上不同的方法。不再在同一个错误修法上空转。

### 验证门控
声明任务完成前，agent 必须运行最小验证集——类型检查和关键路径测试。"完成"意味着经过验证，而不只是写完了。

### 记忆指导
agent 记录跨会话值得保留的内容：
- **纠正** — 你说"不要做 X"时，附带原因一起记录
- **错误模式** — 同一个错误犯两次就写下来（HermesAgent 原则）
- **偏好** — 沟通风格、代码风格、你认为什么叫完成

### 上下文卫生
- 系统提示里不包含时间戳（破坏 KV-cache，10 倍成本差距）
- 指令文件保持轻量；一个阶段完成后 `/compact`
- 任务切换时开新会话，不混入无关工作

### Karpathy 编码纪律
1. 动手前先想——明确假设，有疑问就问
2. 简单优先——最少的代码解决问题
3. 外科手术式修改——只改任务要求的地方
4. 目标驱动——先定义"完成"标准，先写可验证的测试

---

## 更新

```bash
cd ~/.claude/code-harness && git pull
cp CLAUDE.md ~/.claude/CLAUDE.md   # 应用最新版本
```

---

## 参与贡献

真实会话失败报告是最有价值的 PR。如果 agent 违反了某条原则而当前配置没能阻止，那就是一个值得修复的 bug。

## 开源协议

MIT
