# /do:help

Complete command reference for DESIGN-OPS.

## Trigger

User runs `/do:help` to see all available commands and skills.

---

## Output

```markdown
# DESIGN-OPS — Command Reference

## System Commands

| Command | Description |
|---------|-------------|
| `/do:setup` | Initial onboarding wizard — configure integrations and preferences |
| `/do:configure` | Update specific settings without full setup |
| `/do:status` | Show current config status and integration health |
| `/do:test` | Run diagnostics to verify everything works |
| `/do:add-tool` | Connect a new MCP or API with guided setup |
| `/do:help` | This command reference |
| `/do:library` | Browse utility commands by category |

---

## Dashboard Command

The unified dashboard command generates reports across pillars and timeframes:

```bash
/do:dashboard [pillar] [timeframe]
```

| Pillars | Timeframes |
|---------|------------|
| `ops` — Operations | `daily` (or `today`, `d`) |
| `design` — Design | `weekly` (or `week`, `w`) |
| `analytics` — Analytics | `quarterly` (or `quarter`, `q`) |
| omitted — All pillars | `ytd` (or `year`, `y`) |

**Examples:**
```bash
/do:dashboard                    # All pillars, daily (default)
/do:dashboard ops weekly         # Operations, weekly
/do:dashboard design quarterly   # Design, quarterly
/do:dashboard analytics ytd      # Analytics, year-to-date
/do:dashboard weekly             # All pillars, weekly
```

---

## Legacy Aliases

These commands remain for backwards compatibility:

| Command | Maps To |
|---------|---------|
| `/do:daily-brief` | `/do:dashboard daily` |
| `/do:weekly-recap` | `/do:dashboard weekly` |
| `/do:team-pulse` | `/do:dashboard design daily --team` |

---

## Utility Library

Browse with `/do:library` or `/do:library [category]`.

### Logistics
*Meeting prep, kickoffs, and project coordination*

| Command | Description |
|---------|-------------|
| `/do:meeting-brief` | Create focused meeting agendas |
| `/do:meeting-recap` | Document meetings with action items |
| `/do:kickoff-prep` | Generate project kickoff materials |

### Content
*Content creation for social and marketing*

| Command | Description |
|---------|-------------|
| `/do:social-post` | Create platform-optimized social content |

### Development
*Research, analysis, and ideation tools*

| Command | Description |
|---------|-------------|
| `/do:site-analysis` | Deep website analysis |
| `/do:devils-advocate` | Challenge assumptions |

---

## Auto-Activating Skills

These activate automatically based on context — no command needed:

| Skill | Triggers On |
|-------|-------------|
| `brand-guidelines` | Mentions of brand, colors (Aperol, Charcoal, Vanilla), brand voice |
| `frontend-design` | UI work, component creation, design implementation |
| `design-system-quality` | Design system reviews, token validation |
| `brand-voice` | Content writing, copywriting, messaging |
| `design-feedback` | Design critique, visual review |
| `accessibility-audit` | Accessibility checks, a11y reviews |
| `systematic-debugging` | Debugging, error investigation |
| `verification-before-completion` | Task completion, claiming "done" |

---

## Quick Start

1. **First time?** Run `/do:setup` to configure integrations
2. **Morning routine?** Run `/do:dashboard` (or `/do:daily-brief`)
3. **Weekly review?** Run `/do:dashboard weekly`
4. **Check team activity?** Run `/do:dashboard design`
5. **Something broken?** Run `/do:test`
6. **Find a utility?** Run `/do:library`

---

## Configuration

Config file: `~/.claude/do-config.yaml`

View current config: `/do:status`
Update config: `/do:configure`

---

## Getting Help

- **Issues:** https://github.com/opensesh/DESIGN-OPS/issues
- **Docs:** See /references folder in plugin directory
- **Troubleshooting:** /references/troubleshooting.md
```

---

## Contextual Help

If user runs `/do:help {topic}`:

**`/do:help dashboard`**
```markdown
## Dashboard Command Help

### Usage
```bash
/do:dashboard [pillar] [timeframe]
```

### Pillars
- `ops` / `operations` — Calendar, tasks, communication
- `design` — Code repos, design files, team activity
- `analytics` — Web traffic, links, subscribers
- omitted — All enabled pillars combined

### Timeframes
- `daily` / `today` / `d` — Today's activity
- `weekly` / `week` / `w` — This week's summary
- `quarterly` / `quarter` / `q` — Quarter-to-date
- `ytd` / `year` / `y` — Year-to-date

### Examples
```bash
/do:dashboard                    # All pillars, daily
/do:dashboard ops                # Operations, daily
/do:dashboard weekly             # All pillars, weekly
/do:dashboard design quarterly   # Design, quarterly
```

### Configuration
Dashboard reads from `~/.claude/do-config.yaml`:
- Which pillars are enabled
- Which tools are connected
- Which outcomes to include

Run `/do:configure` to adjust.
```

**`/do:help library`**
```markdown
## Library Command Help

### Usage
```bash
/do:library              # List all utility commands
/do:library [category]   # Filter by category
```

### Categories
- `logistics` — Meeting prep, kickoffs, project coordination
- `content` — Content creation for social and marketing
- `development` — Research, analysis, ideation tools

### Available Commands

**Logistics:**
- `/do:meeting-brief` — Create meeting agendas
- `/do:meeting-recap` — Document meetings
- `/do:kickoff-prep` — Project kickoff materials

**Content:**
- `/do:social-post` — Social media content

**Development:**
- `/do:site-analysis` — Website analysis
- `/do:devils-advocate` — Challenge assumptions

### Adding Commands
See `commands/library/_registry.yaml` for the registry format.
```

**`/do:help figma`**
```markdown
## Figma Integration Help

### Setup
Run `/do:setup` and select Figma integration, or run `/do:configure` → Figma.

### Token Generation
1. Go to https://www.figma.com/developers/api#access-tokens
2. Generate token with "File content" scope
3. Paste in setup wizard

### Tracking
- Track entire projects (all files in project)
- Or track specific files by key

### Troubleshooting
- Token expired? Regenerate and update via `/do:configure`
- Can't see projects? Check token has correct scope
- 403 errors? Token may have been revoked

See: /references/troubleshooting.md
```

**`/do:help github`**
```markdown
## GitHub Integration Help

### Setup
GitHub uses MCP — no separate token needed.

If GitHub MCP isn't connected:
1. Go to claude.ai/mcps
2. Install GitHub MCP
3. Authorize with your account
4. Re-run `/do:setup`

### Tracking
Add repos in owner/repo format (e.g., opensesh/webapp)

### Features
- Recent commits
- Open PRs
- Issue tracking

See: /references/mcp-setup/add-mcp-guide.md
```

---

## Command Not Found

If user runs `/do:help {unknown}`:

```markdown
I don't have specific help for "{topic}".

Try:
- `/do:help dashboard` — Dashboard command usage
- `/do:help library` — Utility command browser
- `/do:help figma` — Figma integration
- `/do:help github` — GitHub integration

Or search the documentation in /references/
```

---

*Version: 2.0*
