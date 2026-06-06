# fast-harness

**[English](./README.md)**

> 别再靠 prompt 驯服 AI，用配置来约束它。

一个插件/skill 包，将 **harness engineering 原则**和**完整的软件开发生命周期**直接嵌入你的 AI 编程助手——让每次会话从一开始就有结构、中途不跑偏、结尾经过验证才算完成。

*"Harness" 在这里是行为约束系统的意思，类似马具，而不是测试框架（test harness）。*

支持 Claude Code、Cursor、OpenCode、Codex、Gemini CLI。

---

## 为什么需要 fast-harness？

大多数开发者都在同样的 AI 坑里浪费时间：

- 长对话到一半，AI 忘了原来要做什么
- 让它修一个 bug，结果改了半个代码库
- 它说"完成了"，其实一个测试都没跑
- 上下文被大量过期调试记录填满，越来越慢

fast-harness 在**配置层**解决这些问题，而不是靠临时 prompt。三个自动激活的 skill 在 AI 写第一行代码之前就重塑了它的思维方式。

---

## 包含的内容

| Skill | 激活时机 | 作用 |
|-------|----------|------|
| **workflow-guide** | 开始任何功能、任务或项目时 | 快速通道或完整通道路由；强制执行 Karpathy 纪律 |
| **harness-engineering** | 管理上下文、遇到循环、决定何时压缩时 | 目标追踪、反压机制、上下文卫生、循环检测 |
| **tools-reference** | 查询该用哪个命令或插件时 | 所有已安装 skill 和斜杠命令的快速参考 |

### 这些 skill 强制执行的核心行为

**目标追踪（todo.md 模式）**
任何多步骤任务开始时，AI 创建 `todo.md` 并在每步完成后更新。这把当前目标重新注入到上下文末尾（注意力最强的地方），防止长对话中目标漂移。

**反压机制（Back-pressure）**
- 验证门控：声明完成前必须运行类型检查 + 关键路径测试
- 循环检测：同一文件改了 3 次以上仍未解决 → 停下来，重读目标，换一种思路
- 保留失败证据：重试时追加失败摘要（"不要重复这个方法"），而不是覆盖

**上下文卫生**
- CLAUDE.md 总加载量保持在 60 行以内（渐进式 `@` 导入）
- 系统提示里不要出现时间戳（破坏 KV-cache 前缀，成本差 10 倍）
- 任务切换时开新会话，不要混入无关任务

**Karpathy 编码纪律**
1. 动手前先想——明确假设，有疑问就问，不要静默选择一种解法
2. 简单优先——最少的代码解决问题，不写没被要求的功能
3. 外科手术式修改——只改任务要求的地方，不顺手重构周边代码
4. 目标驱动执行——先定义"完成"的标准，写验证测试，再写实现

---

## 两条开发通道

**快速通道** — 适合需求清晰、范围明确的功能：
```
/feature-dev <描述>
```
7 阶段自动化工作流：探索 → 设计 → 计划 → 实现 → 测试 → review → 提交。

**完整通道** — 适合涉及架构决策、多系统变更的任务：
1. 需求/想法 → `superpowers:brainstorming`（对话澄清 → 生成设计文档）
2. 设计完成 → `superpowers:writing-plans`（生成分步实现计划）
3. 开始实现 → `superpowers:test-driven-development`（先写测试再写代码）
4. 功能完成 → `superpowers:verification-before-completion`（验证后再声明完成）
5. 提交前 → `superpowers:requesting-code-review`（审查后再合并）
6. 发布 → `/commit` `/push`

---

## 设计理念

**配置优于提示（Harness over prompting）**
一次性 prompt 很脆弱。每次会话都运行的配置不会。fast-harness 围绕这个不对称性设计：一次投入搭好 harness，之后每次会话都继承这套纪律。

**不重复造轮子**
fast-harness 编排 [superpowers](https://github.com/obra/superpowers) 和官方 Claude Code 插件，而不是重复它们。skill 是薄薄的协调层，不是庞大的工具箱。

**模型无关（Model-agnostic）**
当 AI 卡住时，它向你发出信号——而不是自己决定换哪个模型。模型选择是开发者的决定，不是 AI 的。

**渐进式加载**
skill 按需加载，不会预先污染上下文。

---

## 支持的平台

| 平台 | 状态 | 安装方式 |
|------|------|---------|
| Claude Code | ✅ 原生支持 | [→ 安装](#claude-code) |
| Cursor | ✅ 支持 | [→ 安装](#cursor) |
| OpenCode | ✅ 支持 | [→ 安装](#opencode) |
| Codex (OpenAI) | ✅ 支持 | [→ 安装](#codex-openai) |
| Gemini CLI | ✅ 支持 | [→ 安装](#gemini-cli) |
| 任意 Agent | ✅ 通过 AGENTS.md | 复制 `AGENTS.md` 到项目根目录 |

---

## 安装说明

### Claude Code

> 本节中的 skill、斜杠命令（`/feature-dev`、`/commit` 等）和记忆系统均为 **Claude Code 专属功能**，在其他平台上请使用对应平台的安装方式。

**第一步 — 安装工作流引擎和配套插件：**

```bash
# 核心工作流引擎（superpowers skills 平台）
claude plugin marketplace add superpowers-dev https://github.com/obra/superpowers
claude plugin install superpowers@superpowers-dev

# 完整开发生命周期插件
claude plugin install feature-dev@claude-plugins-official       # 7 阶段功能开发工作流
claude plugin install frontend-design@claude-plugins-official   # 高质量 UI 生成
claude plugin install code-review@claude-plugins-official       # 多 agent 并行 review
claude plugin install security-guidance@claude-plugins-official # 实时安全扫描
claude plugin install commit-commands@claude-plugins-official   # 规范化 commit
claude plugin install context7@claude-plugins-official          # 实时框架文档
claude plugin install claude-md-management@claude-plugins-official
claude plugin install claude-code-setup@claude-plugins-official
```

**第二步 — 安装 fast-harness：**

```bash
claude plugin marketplace add fast-harness https://github.com/fast-harness/fast-harness
claude plugin install fast-harness
```

**第三步 — 配置用户级 CLAUDE.md：**

创建 `~/.claude/CLAUDE.md`（macOS/Linux）或 `%USERPROFILE%\.claude\CLAUDE.md`（Windows）：

```markdown
# Global Configuration

@docs/workflow.md
@docs/harness.md
@docs/tools.md
```

完整的文件模板见本仓库 `examples/claude-md/` 目录。

**第四步 — 初始化每个新项目：**

在项目中运行：
```
/recommend-automations
```

它会分析你的项目并推荐缺失的 hook、MCP server 和额外插件。

---

### Cursor

Cursor 使用 skills 目录机制，不是插件注册表。`~/.cursor/skills/` 中的 skill 对所有项目可用；`.cursor/skills/`（项目根目录）中的 skill 只在该项目内生效。

**macOS / Linux：**

```bash
mkdir -p ~/.cursor/skills
git clone https://github.com/fast-harness/fast-harness /tmp/fast-harness
cp -r /tmp/fast-harness/skills/workflow-guide ~/.cursor/skills/
cp -r /tmp/fast-harness/skills/harness-engineering ~/.cursor/skills/
cp -r /tmp/fast-harness/skills/tools-reference ~/.cursor/skills/
rm -rf /tmp/fast-harness
```

**Windows（PowerShell）：**

```powershell
$skillsDir = "$env:USERPROFILE\.cursor\skills"
New-Item -ItemType Directory -Force -Path $skillsDir
$tmp = "$env:TEMP\fast-harness"
git clone https://github.com/fast-harness/fast-harness $tmp
Copy-Item "$tmp\skills\workflow-guide" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\harness-engineering" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\tools-reference" -Destination $skillsDir -Recurse -Force
Remove-Item $tmp -Recurse -Force
```

重启 Cursor，skill 自动发现，无需修改 settings.json。

**更新：**

重新运行上述安装命令即可（使用 `-Force` / 覆盖模式，可安全重复执行）。

---

### OpenCode

在 `opencode.json` 中添加 plugin 字段。文件位置：
- macOS/Linux：`~/.config/opencode/opencode.json`
- Windows：`%USERPROFILE%\.config\opencode\opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "plugin": ["fast-harness@git+https://github.com/fast-harness/fast-harness.git"]
}
```

重启 OpenCode，skill 自动注册，根据任务上下文自动激活。

> 如果你的 OpenCode 版本尚不支持 `plugin` 字段，请使用下方的 AGENTS.md 方式作为替代。

---

### Codex (OpenAI)

Codex 自动发现 `~/.codex/skills/` 目录中的 skill。

**macOS / Linux：**

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/fast-harness/fast-harness /tmp/fast-harness
cp -r /tmp/fast-harness/skills/workflow-guide ~/.codex/skills/
cp -r /tmp/fast-harness/skills/harness-engineering ~/.codex/skills/
cp -r /tmp/fast-harness/skills/tools-reference ~/.codex/skills/
rm -rf /tmp/fast-harness
```

**Windows（PowerShell）：**

```powershell
$skillsDir = "$env:USERPROFILE\.codex\skills"
New-Item -ItemType Directory -Force -Path $skillsDir
$tmp = "$env:TEMP\fast-harness"
git clone https://github.com/fast-harness/fast-harness $tmp
Copy-Item "$tmp\skills\workflow-guide" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\harness-engineering" -Destination $skillsDir -Recurse -Force
Copy-Item "$tmp\skills\tools-reference" -Destination $skillsDir -Recurse -Force
Remove-Item $tmp -Recurse -Force
```

重启 Codex，skill 自动发现。

**更新：**

重新运行上述安装命令即可（可安全重复执行）。

---

### Gemini CLI

**macOS / Linux — 方式一（追加到已有 GEMINI.md）：**

```bash
git clone https://github.com/fast-harness/fast-harness /tmp/fast-harness
cat /tmp/fast-harness/GEMINI.md >> ~/.gemini/GEMINI.md
rm -rf /tmp/fast-harness
```

**macOS / Linux — 方式二（克隆后通过 `@` 引用）：**

```bash
git clone https://github.com/fast-harness/fast-harness ~/.config/fast-harness
```

在 `~/.gemini/GEMINI.md` 中添加：

```
@~/.config/fast-harness/skills/workflow-guide/SKILL.md
@~/.config/fast-harness/skills/harness-engineering/SKILL.md
@~/.config/fast-harness/skills/tools-reference/SKILL.md
```

**Windows（PowerShell）— 方式二：**

```powershell
$dir = "$env:USERPROFILE\.config\fast-harness"
git clone https://github.com/fast-harness/fast-harness $dir
# 在 %USERPROFILE%\.gemini\GEMINI.md 中添加（使用完整路径）：
# @C:\Users\<你的用户名>\.config\fast-harness\skills\workflow-guide\SKILL.md
# @C:\Users\<你的用户名>\.config\fast-harness\skills\harness-engineering\SKILL.md
# @C:\Users\<你的用户名>\.config\fast-harness\skills\tools-reference\SKILL.md
```

> 注意：Gemini CLI 的 `@` 导入中 `~` 在 macOS/Linux 解析为 `$HOME`。Windows 上请使用完整绝对路径。

---

### 任意 Agent（AGENTS.md）

复制 `AGENTS.md` 到项目根目录。这个文件把三个 skill 的核心原则全部内联——无需插件发现机制，适用于任何在会话开始时读取 `AGENTS.md` 的 agent。

```bash
cp AGENTS.md /path/to/your/project/AGENTS.md
```

---

## 更新

```bash
# Claude Code
claude plugin update fast-harness

# Cursor / Codex — 重新运行安装命令（可安全重复执行）

# Gemini CLI 方式二
cd ~/.config/fast-harness && git pull
```

---

## 工作原理

fast-harness 通过各平台的 **skill 系统**工作。会话开始时，skill 被发现并扫描其描述字段。当任务匹配某个 skill 的触发条件时，完整的 skill 内容按需加载。

`harness-engineering` skill 实现了**反压（back-pressure）**——抵抗长对话中 AI 自然产生的漂移、循环、或虚报完成倾向的机制。`workflow-guide` skill 确保 AI 在接触任何代码之前先选择正确的流程路径。

所有 skill 都是纯 markdown 文件——可读、可 fork、无需构建步骤即可改进。

---

## 参与贡献

欢迎 PR。重点方向：
- 新平台支持（Windsurf、Amp、Continue 等）
- 基于真实会话失败的 skill 改进
- 针对特定技术栈的 CLAUDE.md / AGENTS.md 配置示例

请保持 skill 简洁——超过 500 行的 skill 加载更慢，且会挤占上下文空间。

---

## 开源协议

MIT — 自由使用，欢迎 star。
