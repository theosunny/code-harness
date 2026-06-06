# Installing fast-harness for OpenCode

## Install

Add to your `opencode.json` (global `~/.config/opencode/opencode.json` or project-level):

```json
{
  "plugin": ["fast-harness@git+https://github.com/fast-harness/fast-harness.git"]
}
```

Restart OpenCode. Skills auto-register.

## Usage

Skills activate automatically based on task context:
- **workflow-guide** — when starting features or projects
- **harness-engineering** — when managing context or hitting loops
- **tools-reference** — when looking up commands or plugins

## Tool Mapping

When skills reference Claude Code tools, use OpenCode equivalents:
- `Skill` tool → OpenCode's native `skill` tool
- `TodoWrite` → `todowrite`
- File operations → your native tools
