# /design-ops:library

Browse and discover utility commands organized by category.

## Trigger

```bash
/design-ops:library              # List all utility commands by category
/design-ops:library [category]   # Filter to specific category
```

## Parameters

| Category | Description |
|----------|-------------|
| `logistics` | Meeting prep, kickoffs, and project coordination |
| `content` | Content creation for social and marketing |
| `development` | Research, analysis, and ideation tools |
| `design` | Design quality, research, and variation tools |
| omitted | Show all categories |

---

## Behavior

### Step 1: Load Registry

1. **Read** `commands/library/_registry.yaml`
2. **Parse** command manifest
3. **Filter** by category if specified

### Step 2: Render Command List

Display commands grouped by category:

```markdown
## DESIGN-OPS Utility Library (14 commands)

Ad-hoc commands organized by purpose. Use any command directly.

📖 **Full documentation:** https://github.com/opensesh/DESIGN-OPS/tree/main/commands/library

---

### Logistics (3)
*Meeting prep, kickoffs, and project coordination*

| Command | Description |
|---------|-------------|
| `/design-ops:meeting-brief` | Create focused meeting agendas through guided questions |
| `/design-ops:meeting-recap` | Document meetings with summaries, decisions, and action items |
| `/design-ops:kickoff-prep` | Generate project kickoff materials (agenda, brief, questions) |

---

### Content (3)
*Content creation for social and marketing*

| Command | Description |
|---------|-------------|
| `/design-ops:social-post` | Create platform-optimized social content |
| `/design-ops:copy-variants` | Generate and A/B test copy variations |
| `/design-ops:content-brief` | Create content briefs for articles, blogs, case studies |

---

### Development (3)
*Research, analysis, and ideation tools*

| Command | Description |
|---------|-------------|
| `/design-ops:site-analysis` | Deep website analysis with structure mapping |
| `/design-ops:devils-advocate` | Challenge assumptions and stress-test your thinking |
| `/design-ops:research-summary` | Synthesize research into actionable insights |

---

### Design (5)
*Design quality, research, and variation tools*

| Command | Description |
|---------|-------------|
| `/design-ops:design-audit` | Automated design system compliance check |
| `/design-ops:a11y-audit` | Accessibility compliance check (WCAG A/AA/AAA) |
| `/design-ops:mood-board` | Curated design inspiration from web sources |
| `/design-ops:competitor-scan` | Competitive design analysis |
| `/design-ops:variation-sprint` | Generate design variations within brand constraints |

---

Run any command by name, or browse a specific category:
- `/design-ops:library logistics`
- `/design-ops:library content`
- `/design-ops:library development`
- `/design-ops:library design`
```

---

## Category Filter

When user specifies a category:

```bash
/design-ops:library logistics
```

Show only that category:

```markdown
## Logistics Commands

*Meeting prep, kickoffs, and project coordination*

| Command | Description |
|---------|-------------|
| `/design-ops:meeting-brief` | Create focused meeting agendas through guided questions |
| `/design-ops:meeting-recap` | Document meetings with summaries, decisions, and action items |
| `/design-ops:kickoff-prep` | Generate project kickoff materials (agenda, brief, questions) |

---

**Other categories:** content, development, design

Run `/design-ops:library` to see all categories.
```

---

## Unknown Category

If user specifies an unknown category:

```markdown
Unknown category: "{category}"

Available categories:
- **logistics** — Meeting prep, kickoffs, and project coordination
- **content** — Content creation for social and marketing
- **development** — Research, analysis, and ideation tools
- **design** — Design quality, research, and variation tools

Run `/design-ops:library` to see all commands.
```

---

## Registry Schema

The library reads from `commands/library/_registry.yaml`:

```yaml
version: "2.0"

categories:
  logistics: "Meeting prep, kickoffs, and project coordination"
  content: "Content creation for social and marketing"
  development: "Research, analysis, and ideation tools"
  design: "Design quality, research, and variation tools"

commands:
  - id: meeting-brief
    path: logistics/meeting-brief.md
    category: logistics
    description: "Create focused meeting agendas"
    trigger: "/design-ops:meeting-brief"
    tags: [meetings, planning, preparation]
  # ... more commands (14 total)
```

---

## Adding New Commands

To add a command to the library:

1. Create the command file in the appropriate category folder:
   ```
   commands/library/{category}/{command-name}.md
   ```

2. Add entry to `commands/library/_registry.yaml`:
   ```yaml
   - id: command-name
     path: {category}/command-name.md
     category: {category}
     description: "Brief description of what it does"
     trigger: "/design-ops:command-name"
     tags: [relevant, tags]
   ```

3. The command will appear in `/design-ops:library` output

---

## Why a Library?

**Discoverability** — Users can browse available utilities without memorizing all commands.

**Organization** — Related commands grouped logically by purpose.

**Scalability** — Easy to add new commands without cluttering the main help output.

**Separation** — Keeps utility commands distinct from the core dashboard and setup commands.

---

## Related Commands

- `/design-ops:help` — Full command reference (includes system commands and dashboard)
- `/design-ops:dashboard` — Core pillar × timeframe reporting

---

## Source Code

Browse and contribute to the library:
**https://github.com/opensesh/DESIGN-OPS/tree/main/commands/library**

---

*Version: 2.0*
