# Company Skills

A plugin that gives Claude Code a "mini team of agents" for your daily, weekly, and as-needed workflows. Works for any company — tech, CPG, services, creative, you name it.

## Quick Start

**Option 1: Clone and install (recommended)**
```bash
# Clone to your Claude skills directory
git clone https://github.com/opensesh/company-skills.git ~/.claude/skills/company-skills

# Start Claude Code and run the onboarding
/install-skills
```

**Option 2: If you already have it cloned**
```bash
# Just run the onboarding command
/install-skills
```

The onboarding interview takes about 2 minutes and sets up your personalized config.

---

## What You Get

### Commands (User-Invoked Workflows)

| Category | Command | What It Does |
|----------|---------|--------------|
| **Daily** | `/daily-brief` | Morning overview of calendar, tasks, and priorities |
| **Daily** | `/weekly-recap` | End-of-week reflection and next-week planning |
| **Meetings** | `/meeting-brief` | Create focused agendas through guided questions |
| **Meetings** | `/meeting-recap` | Document meetings with action items and owners |
| **Thinking** | `/devils-advocate` | Challenge assumptions, red-team your thinking |
| **Thinking** | `/pre-mortem` | "Imagine this failed—why?" analysis |
| **Content** | `/social-post` | Guided content for LinkedIn, Instagram, Substack |
| **Content** | `/case-study` | Generate case study drafts from project data |
| **Research** | `/site-analysis` | Analyze websites for architecture, design, SEO |

### Skills (Auto-Activating Expertise)

| Category | Skill | When It Activates |
|----------|-------|-------------------|
| **Brand** | `brand-voice` | When writing content that needs brand tone |
| **Design** | `design-feedback` | When reviewing visual designs |
| **Design** | `frontend-design` | When building UI components |
| **Development** | `verification-before-completion` | Before claiming work is done |
| **Development** | `systematic-debugging` | When diagnosing issues |

---

## Repository Structure

```
company-skills/
├── installer/                     # Onboarding system
│   ├── install-skills.md          # Main /install-skills command
│   ├── interview-flow.md          # Question orchestration
│   └── mcp-setup/                 # MCP education & guides
│       ├── mcp-education.md       # "What is MCP?" explained simply
│       ├── recommended-mcps.md    # Curated starter list
│       └── add-mcp-guide.md       # How to add any MCP
├── commands/
│   ├── daily/                     # Daily productivity
│   ├── thinking/                  # Critical thinking tools
│   ├── meetings/                  # Meeting workflows
│   ├── content/                   # Content creation
│   ├── creative/                  # Creative research
│   └── maintenance/               # Help & config commands
├── skills/                        # Auto-activating expertise
│   ├── brand/
│   ├── design/
│   ├── development/
│   └── operations/
└── templates/                     # Templates for new skills
```

---

## After Installation

Your personalized config is stored at `~/.claude/skills-config.yaml`. It contains:

- **Tools you use** — Calendar, Notion, Slack, etc.
- **Connected MCPs** — What's integrated and what it can do
- **Workflow preferences** — Daily, weekly, or as-needed cadence

### Maintenance Commands

| Command | What It Does |
|---------|--------------|
| `/skills-help` | See all available commands and skills |
| `/add-tool` | Connect a new MCP with guided setup |
| `/customize` | Update your preferences |

---

## How Commands Adapt

Commands gracefully adapt based on what's connected:

**With Calendar + Notion connected:**
```
/daily-brief → Full automated brief with meetings and tasks
```

**With only Calendar:**
```
/daily-brief → Shows meetings, asks about tasks
```

**With nothing connected:**
```
/daily-brief → "Tell me what's on your plate and I'll help prioritize."
```

No hard failures. Commands work at any integration level.

---

## MCP Integration

MCPs (Model Context Protocol servers) let Claude connect to your tools. Common ones:

| MCP | What It Enables |
|-----|-----------------|
| Google Calendar | Auto-fetch events for daily briefs |
| Notion | Tasks, docs, project management |
| GitHub | Code search, PR reviews |
| Firecrawl | Deep website analysis |
| Gmail | Email summaries and drafts |

See [`installer/mcp-setup/`](installer/mcp-setup/) for setup guides.

---

## Creating New Skills

Use the template at [`templates/skill-template.md`](templates/skill-template.md) or see the [skill-creator](skills/operations/skill-creator.md) guide.

### Skill Anatomy

```markdown
# Skill Name

Brief description of what this skill does.

## Purpose

Why this skill exists.

## When to Activate

- Trigger condition 1
- Trigger condition 2

## Instructions

Detailed instructions for Claude to follow...

## Examples

Show input/output examples...
```

---

## Contributing

1. Fork and clone the repo
2. Add your skill/command to the appropriate folder
3. Test with Claude Code
4. Submit a PR with usage examples

---

## License

MIT License — See [LICENSE](LICENSE) for details.
