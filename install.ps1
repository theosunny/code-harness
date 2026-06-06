# agent-rails installer — Claude Code + Codex
# Usage: iwr https://raw.githubusercontent.com/agent-rails/agent-rails/main/install.ps1 | iex

$ErrorActionPreference = "Stop"
$repo = "https://github.com/agent-rails/agent-rails"
$claudeDir = "$env:USERPROFILE\.claude"
$installDir = "$claudeDir\agent-rails"

Write-Host "Installing agent-rails..."

# Clone or update
if (Test-Path "$installDir\.git") {
    Write-Host "Updating existing install..."
    git -C $installDir pull
} else {
    git clone $repo $installDir
}

# Claude Code: add @-imports to CLAUDE.md
$claudeMd = "$claudeDir\CLAUDE.md"
$alreadyConfigured = (Test-Path $claudeMd) -and ((Get-Content $claudeMd -Raw) -match "agent-rails")
if ($alreadyConfigured) {
    Write-Host "CLAUDE.md already configured, skipping."
} else {
    New-Item -ItemType Directory -Force -Path $claudeDir | Out-Null
    $imports = @"

# agent-rails
@./agent-rails/skills/workflow-guide/SKILL.md
@./agent-rails/skills/harness-engineering/SKILL.md
@./agent-rails/skills/tools-reference/SKILL.md
"@
    Add-Content -Path $claudeMd -Value $imports
    Write-Host "Added to $claudeMd"
}

# Codex: copy skills to ~/.codex/skills/
if (Test-Path "$env:USERPROFILE\.codex") {
    $codexSkills = "$env:USERPROFILE\.codex\skills"
    New-Item -ItemType Directory -Force -Path $codexSkills | Out-Null
    Copy-Item "$installDir\skills\workflow-guide"     -Destination $codexSkills -Recurse -Force
    Copy-Item "$installDir\skills\harness-engineering" -Destination $codexSkills -Recurse -Force
    Copy-Item "$installDir\skills\tools-reference"    -Destination $codexSkills -Recurse -Force
    Write-Host "Installed Codex skills to $codexSkills"
}

Write-Host ""
Write-Host "Done. Restart your agent to activate."
