```
██████╗ ███████╗███████╗██╗ ██████╗ ███╗   ██╗     ██████╗ ██████╗ ███████╗
██╔══██╗██╔════╝██╔════╝██║██╔════╝ ████╗  ██║    ██╔═══██╗██╔══██╗██╔════╝
██║  ██║█████╗  ███████╗██║██║  ███╗██╔██╗ ██║    ██║   ██║██████╔╝███████╗
██║  ██║██╔══╝  ╚════██║██║██║   ██║██║╚██╗██║    ██║   ██║██╔═══╝ ╚════██║
██████╔╝███████╗███████║██║╚██████╔╝██║ ╚████║    ╚██████╔╝██║     ███████║
╚═════╝ ╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚═╝     ╚══════╝
```

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Version](https://img.shields.io/badge/version-v2.1.0-blue)]()
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
/do:setup
```

*Works in Claude Code CLI, desktop app, or IDE extensions.*

### Your First Dashboard

```bash
/do:setup              # Connect your tools (~5 min)
/do:dashboard          # Get your daily overview
/do:dashboard weekly   # Weekly summary
/do:library            # Browse utility commands
```

**Prerequisites:** [Claude Code](https://claude.ai/code), Git

---

## Commands

All commands use the `/do:` prefix (DESIGN-OPS).

### System Commands

| Command | Purpose |
|---------|---------|
| `/do:setup` | Interactive onboarding wizard |
| `/do:configure` | Update settings by pillar |
| `/do:status` | Show current config and health |
| `/do:test` | Run diagnostics |
| `/do:add-tool` | Connect new MCP or API |
| `/do:help` | Command reference |
| `/do:library` | Browse utility commands |

### Dashboard Command

The unified dashboard generates reports across pillars and timeframes:

```bash
/do:dashboard [pillar] [timeframe]
```

| Pillars | Timeframes |
|---------|------------|
| `ops` — Operations | `daily` / `today` / `d` |
| `design` — Design | `weekly` / `week` / `w` |
| `analytics` — Analytics | `quarterly` / `quarter` / `q` |
| omitted — All pillars | `ytd` / `year` / `y` |

**Examples:**
```bash
/do:dashboard                    # All pillars, daily (default)
/do:dashboard ops weekly         # Operations, weekly
/do:dashboard design quarterly   # Design, quarterly
/do:dashboard analytics ytd      # Analytics, year-to-date
```

### Legacy Aliases

| Command | Maps To |
|---------|---------|
| `/do:daily-brief` | `/do:dashboard daily` |
| `/do:weekly-recap` | `/do:dashboard weekly` |
| `/do:team-pulse` | `/do:dashboard design daily` |

### Utility Library

Browse with `/do:library`. Organized by category:

**Logistics** — Meeting prep, kickoffs, project coordination
| Command | Purpose |
|---------|---------|
| `/do:meeting-brief` | Create focused meeting agendas |
| `/do:meeting-recap` | Document meetings with action items |
| `/do:kickoff-prep` | Generate project kickoff materials |

**Content** — Content creation for social and marketing
| Command | Purpose |
|---------|---------|
| `/do:social-post` | Create platform-optimized social content |

**Development** — Research, analysis, and ideation tools
| Command | Purpose |
|---------|---------|
| `/do:site-analysis` | Deep website analysis |
| `/do:devils-advocate` | Challenge assumptions |

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

DESIGN-OPS uses a pillar-based config stored at `~/.claude/do-config.yaml`:

```yaml
pillars:
  operations:
    tools: [notion, google_workspace, slack]
    outcomes:
      daily: [calendar_events, tasks_due]
      weekly: [week_overview, tasks_completed]
      quarterly: [quarter_goals, budget_status]
      ytd: [annual_goals, revenue_tracking]

  design:
    tools: [github, figma]
    outcomes:
      daily: [recent_commits, open_prs, design_updates]
      weekly: [team_contributions, design_versions]
      quarterly: [shipped_projects, design_velocity]
      ytd: [projects_shipped, design_maturity]

  analytics:
    tools: [google_analytics, dubco]
    outcomes:
      daily: [pageviews, link_clicks]
      weekly: [traffic_trends, top_links]
      quarterly: [quarter_trends, campaign_performance]
      ytd: [annual_traffic, yoy_comparison]
```

Run `/do:setup` for guided configuration.

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
/do:add-tool substack    # Guided setup for any tool
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
Run `/do:test` to diagnose. Still stuck? [hello@opensession.co](mailto:hello@opensession.co)

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

[Apache 2.0](LICENSE)

---

*Built with Claude Code by [Open Session](https://opensession.co)*
