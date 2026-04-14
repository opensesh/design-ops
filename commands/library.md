# /dcs:library

Browse and discover utility commands organized by category.

## Trigger

```bash
/dcs:library              # List all utility commands by category
/dcs:library [category]   # Filter to specific category
```

## Parameters

| Category | Description |
|----------|-------------|
| `logistics` | Meeting prep, kickoffs, and project coordination |
| `content` | Content creation for social and marketing |
| `development` | Research, analysis, and ideation tools |
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
## DESIGN-OPS Utility Library

Ad-hoc commands organized by purpose. Use any command directly.

---

### Logistics
*Meeting prep, kickoffs, and project coordination*

| Command | Description |
|---------|-------------|
| `/dcs:meeting-brief` | Create focused meeting agendas through guided questions |
| `/dcs:meeting-recap` | Document meetings with summaries, decisions, and action items |
| `/dcs:kickoff-prep` | Generate project kickoff materials (agenda, brief, questions) |

---

### Content
*Content creation for social and marketing*

| Command | Description |
|---------|-------------|
| `/dcs:social-post` | Create platform-optimized social content (LinkedIn, Instagram, Substack) |

---

### Development
*Research, analysis, and ideation tools*

| Command | Description |
|---------|-------------|
| `/dcs:site-analysis` | Deep website analysis with structure mapping and component detection |
| `/dcs:devils-advocate` | Challenge assumptions and stress-test your thinking |

---

Run any command by name, or browse a specific category:
- `/dcs:library logistics`
- `/dcs:library content`
- `/dcs:library development`
```

---

## Category Filter

When user specifies a category:

```bash
/dcs:library logistics
```

Show only that category:

```markdown
## Logistics Commands

*Meeting prep, kickoffs, and project coordination*

| Command | Description |
|---------|-------------|
| `/dcs:meeting-brief` | Create focused meeting agendas through guided questions |
| `/dcs:meeting-recap` | Document meetings with summaries, decisions, and action items |
| `/dcs:kickoff-prep` | Generate project kickoff materials (agenda, brief, questions) |

---

**Other categories:** content, development

Run `/dcs:library` to see all categories.
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

Run `/dcs:library` to see all commands.
```

---

## Registry Schema

The library reads from `commands/library/_registry.yaml`:

```yaml
version: "1.0"

categories:
  logistics: "Meeting prep, kickoffs, and project coordination"
  content: "Content creation for social and marketing"
  development: "Research, analysis, and ideation tools"

commands:
  - id: meeting-brief
    path: logistics/meeting-brief.md
    category: logistics
    description: "Create focused meeting agendas"
    trigger: "/dcs:meeting-brief"
    tags: [meetings, planning, preparation]
  # ... more commands
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
     trigger: "/dcs:command-name"
     tags: [relevant, tags]
   ```

3. The command will appear in `/dcs:library` output

---

## Why a Library?

**Discoverability** — Users can browse available utilities without memorizing all commands.

**Organization** — Related commands grouped logically by purpose.

**Scalability** — Easy to add new commands without cluttering the main help output.

**Separation** — Keeps utility commands distinct from the core dashboard and setup commands.

---

## Related Commands

- `/dcs:help` — Full command reference (includes system commands and dashboard)
- `/dcs:dashboard` — Core pillar × timeframe reporting

---

*Version: 1.0*
