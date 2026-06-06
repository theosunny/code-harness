# Installing fast-harness for Codex

## Install

```bash
# 1. Clone the repo
git clone https://github.com/fast-harness/fast-harness ~/.codex/fast-harness

# 2. Link skills for auto-discovery
mkdir -p ~/.agents/skills
ln -s ~/.codex/fast-harness/skills ~/.agents/skills/fast-harness
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/fast-harness/fast-harness "$env:USERPROFILE\.codex\fast-harness"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\fast-harness" "$env:USERPROFILE\.codex\fast-harness\skills"
```

Restart Codex. Skills are discovered automatically.

## Update

```bash
cd ~/.codex/fast-harness && git pull
```

## Uninstall

```bash
rm ~/.agents/skills/fast-harness
rm -rf ~/.codex/fast-harness
```

## Usage

Skills activate automatically. The `AGENTS.md` file at the repo root contains an inline version of the key principles if you prefer to copy it to your project.
