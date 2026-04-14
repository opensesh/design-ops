# Company Skills

A Claude Code plugin that gives you a "mini team of agents" for daily, weekly, and as-needed workflows.

**Works in:**
- **Claude Desktop** (Code tab)
- **Claude Code CLI** (terminal)

Works for any company — tech, CPG, services, creative, you name it.

---

## Installation

Choose your preferred method:

### Option A: Claude Desktop (Recommended for beginners)

1. **Download the plugin:** [Download ZIP](https://github.com/opensesh/company-skills/archive/refs/heads/main.zip)
2. **Extract the ZIP** to a folder you'll remember (e.g., `Documents/company-skills`)
3. **Open Claude Desktop** and click the **Code** tab
4. Click the **+** button next to the prompt box
5. Select **Plugins** → **Add plugin**
6. Navigate to your extracted folder and select it
7. Run `/install-skills` to personalize your setup

### Option B: Terminal (For developers)

**macOS / Linux:**
```bash
git clone https://github.com/opensesh/company-skills.git ~/company-skills
claude plugin add ~/company-skills
```

**Windows:**
```powershell
git clone https://github.com/opensesh/company-skills.git %USERPROFILE%\company-skills
claude plugin add %USERPROFILE%\company-skills
```

Then run `/install-skills` to personalize your setup.

---

## Verify Installation

After installation, verify it worked:

**In Claude Desktop (Code tab):**
1. Type `/skills-help` in the prompt box
2. You should see a list of available commands

**In Terminal:**
```bash
claude
> /skills-help
```

**Expected output:** A list of commands including `/daily-brief`, `/meeting-brief`, `/devils-advocate`, etc.

**Something wrong?** See [Troubleshooting](references/troubleshooting.md) for common issues.

---

## Where to Use Company Skills

Company Skills runs in the **Code tab** of Claude Desktop (or Claude Code CLI).

**Why Code tab?**
- Access to your local files and config
- Can read/write the skills-config.yaml
- Can run shell commands for MCP setup

The Cowork tab is great for knowledge work, but Company Skills needs the Code tab's capabilities.

---

## What You Get

### Commands (User-Invoked)

| Command | What It Does |
|---------|--------------|
| `/daily-brief` | Morning overview of calendar, tasks, and priorities |
| `/weekly-recap` | End-of-week reflection and next-week planning |
| `/meeting-brief` | Create focused agendas through guided questions |
| `/meeting-recap` | Document meetings with action items and owners |
| `/devils-advocate` | Challenge assumptions, red-team your thinking |
| `/social-post` | Guided content for LinkedIn, Instagram, Substack |
| `/site-analysis` | Analyze websites for architecture, design, SEO |
| `/kickoff-prep` | Generate project kickoff materials |

### Maintenance Commands

| Command | What It Does |
|---------|--------------|
| `/skills-help` | See all available commands and skills |
| `/add-tool` | Connect a new MCP with guided setup |
| `/customize` | Update your preferences |

### Skills (Auto-Activating)

Skills activate automatically when relevant:

| Skill | When It Activates |
|-------|-------------------|
| `brand-voice` | Writing content that needs brand tone |
| `design-feedback` | Reviewing visual designs |
| `frontend-design` | Building UI components |
| `verification-before-completion` | Before claiming work is done |
| `systematic-debugging` | Diagnosing issues |
| `component-system` | Working with UI component libraries |

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

## Connecting Your Tools (Optional)

Company Skills works out of the box — just tell Claude what's on your plate.

To unlock automation, connect your tools:

| Tool | What It Enables | How to Connect |
|------|-----------------|----------------|
| Google Calendar | Auto-fetch meetings for daily briefs | Click **+** → **Connectors** → Google Calendar |
| Notion | Pull tasks and docs | Click **+** → **Connectors** → Notion |
| Gmail | Email summaries | Click **+** → **Connectors** → Gmail |
| GitHub | Code search, PR reviews | Click **+** → **Connectors** → GitHub |

Or run `/add-tool` for guided setup.

See [`references/mcp-setup/`](references/mcp-setup/) for detailed setup guides.

---

## After Installation

Your personalized config is stored at `~/.claude/skills-config.yaml`. It contains:

- **Tools you use** — Calendar, Notion, Slack, etc.
- **Connected MCPs** — What's integrated and what it enables
- **Workflow preferences** — Which commands you want active

---

## Repository Structure

```
company-skills/
├── .claude-plugin/
│   └── plugin.json           # Plugin manifest
├── commands/                  # Slash commands (flat)
│   ├── install-skills.md     # Onboarding command
│   ├── daily-brief.md
│   ├── weekly-recap.md
│   ├── meeting-brief.md
│   ├── meeting-recap.md
│   ├── devils-advocate.md
│   ├── social-post.md
│   ├── site-analysis.md
│   ├── kickoff-prep.md
│   ├── skills-help.md
│   ├── add-tool.md
│   └── customize.md
├── skills/                    # Auto-activating expertise (flat)
│   ├── brand-voice.md
│   ├── frontend-design.md
│   ├── design-feedback.md
│   ├── component-system.md
│   └── ...
├── references/                # Supporting documentation
│   ├── troubleshooting.md
│   ├── interview-flow.md
│   └── mcp-setup/
└── templates/                 # Templates for new skills
```

---

## Creating New Skills

Use the template at [`templates/skill-template.md`](templates/skill-template.md) or see the [skill-creator](skills/skill-creator.md) guide.

---

## Contributing

1. Fork and clone the repo
2. Add your skill/command to the appropriate folder
3. Test with Claude Code
4. Submit a PR with usage examples

---

## License

MIT License — See [LICENSE](LICENSE) for details.
