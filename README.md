```
██████╗ ███████╗███████╗██╗ ██████╗ ███╗   ██╗     ██████╗ ██████╗ ███████╗
██╔══██╗██╔════╝██╔════╝██║██╔════╝ ████╗  ██║    ██╔═══██╗██╔══██╗██╔════╝
██║  ██║█████╗  ███████╗██║██║  ███╗██╔██╗ ██║    ██║   ██║██████╔╝███████╗
██║  ██║██╔══╝  ╚════██║██║██║   ██║██║╚██╗██║    ██║   ██║██╔═══╝ ╚════██║
██████╔╝███████╗███████║██║╚██████╔╝██║ ╚████║    ╚██████╔╝██║     ███████║
╚═════╝ ╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚═╝     ╚══════╝
```

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Version](https://img.shields.io/badge/version-v2.0.0-blue)]()
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Plugin-blueviolet.svg)]()

**A Claude Code plugin for design companies and entrepreneurs.**

> Connect your tools. Get daily briefs. Track your team.

---

## What It Does

DESIGN-OPS connects your existing tools and gives you automated insights across three pillars:

| Pillar | What You Get |
|--------|--------------|
| **Operations** | Calendar events, tasks due, email summaries |
| **Design** | Figma activity, GitHub commits, PR reviews |
| **Analytics** | Page views, link clicks, traffic trends |

---

## Quick Start

### Installation

```bash
# Clone the plugin
git clone https://github.com/opensesh/DESIGN-OPS.git ~/DESIGN-OPS

# Add to Claude Code
claude plugin add ~/DESIGN-OPS

# Run setup wizard
/dcs:setup
```

*Works in Claude Code CLI, desktop app, or IDE extensions.*

### Your First Brief

```bash
/dcs:setup          # Connect your tools (~5 min)
/dcs:daily-brief    # Get your morning overview
/dcs:team-pulse     # See team activity
```

**Prerequisites:** [Claude Code](https://claude.ai/code), Git

---

## Commands

All commands use the `/dcs:` prefix (Design Company Skills).

### Setup & Management

| Command | Purpose |
|---------|---------|
| `/dcs:setup` | Interactive onboarding wizard |
| `/dcs:configure` | Update settings by pillar |
| `/dcs:status` | Show current config and health |
| `/dcs:test` | Run diagnostics |
| `/dcs:add-tool` | Connect new MCP or API |

### Daily Operations

| Command | Purpose |
|---------|---------|
| `/dcs:daily-brief` | Morning overview — calendar, tasks, activity |
| `/dcs:meeting-brief` | Create focused meeting agendas |
| `/dcs:meeting-recap` | Document meetings with action items |

### Weekly Operations

| Command | Purpose |
|---------|---------|
| `/dcs:weekly-recap` | End-of-week summary and planning |
| `/dcs:team-pulse` | Team activity dashboard (Figma + GitHub) |

### Creative & Analysis

| Command | Purpose |
|---------|---------|
| `/dcs:devils-advocate` | Challenge assumptions, red-team thinking |
| `/dcs:social-post` | Create social media content |
| `/dcs:site-analysis` | Analyze any website |

---

## Auto-Activating Skills

Skills activate automatically based on context — no command needed.

| Skill | Triggers On |
|-------|-------------|
| `brand-guidelines` | Brand colors, voice, identity work |
| `frontend-design` | UI components, layouts |
| `design-system-quality` | Code reviews, design compliance |
| `tool-evaluator` | MCP/API capability assessment |

---

## Three-Pillar Configuration

DESIGN-OPS uses a pillar-based config stored at `~/.claude/dcs-config.yaml`:

```yaml
pillars:
  operations:
    tools: [notion, google_workspace, slack]
    outcomes:
      daily: [calendar_events, tasks_due]
      weekly: [week_overview, tasks_completed]

  design:
    tools: [github, figma]
    outcomes:
      daily: [recent_commits, open_prs, design_updates]
      weekly: [team_contributions, design_versions]

  analytics:
    tools: [google_analytics, dubco]
    outcomes:
      daily: [pageviews, link_clicks]
      weekly: [traffic_trends, top_links]
```

Run `/dcs:setup` for guided configuration.

---

## Integrations

### Supported Tools

| Tool | Connection | Pillar |
|------|------------|--------|
| Notion | MCP | Operations |
| Google Workspace | MCP | Operations |
| Slack | MCP | Operations |
| GitHub | MCP | Design |
| Figma | API | Design |
| Google Analytics | MCP | Analytics |
| Dub.co | MCP | Analytics |

### Adding Custom Tools

For tools without native MCP support, DESIGN-OPS guides you through API wrapper creation:

```bash
/dcs:add-tool substack    # Guided setup for any tool
```

---

## Documentation

| Document | Description |
|----------|-------------|
| [Config Schema](references/config-schema.md) | Complete configuration reference |
| [Tool Registry](references/tool-registry.md) | Known tools and connection types |
| [Troubleshooting](references/troubleshooting.md) | Common issues and fixes |

---

## FAQ

**Can I use this without all three pillars?**
Yes. Enable only what you need. The plugin adapts to your connected tools.

**Having issues?**
Run `/dcs:test` to diagnose. Still stuck? [hello@opensession.co](mailto:hello@opensession.co)

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

[Apache 2.0](LICENSE)

---

*Built with Claude Code by [Open Session](https://opensession.co)*
