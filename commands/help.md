# /design-ops:help

Complete command reference for DESIGN-OPS.

## Trigger

User runs `/design-ops:help` to see all available commands and skills.

---

## Output

```markdown
# DESIGN-OPS — Command Reference

## System Commands

| Command | Description |
|---------|-------------|
| `/design-ops:setup` | Initial onboarding wizard — configure integrations and preferences |
| `/design-ops:configure` | Update specific settings without full setup |
| `/design-ops:status` | Quick overview of what's configured |
| `/design-ops:test` | Deep diagnostics when troubleshooting |
| `/design-ops:add-tool` | Connect a new MCP or API with guided setup |
| `/design-ops:help` | This command reference |
| `/design-ops:library` | Browse utility commands by category |

**Note:** Use `/design-ops:status` for a quick config check. Use `/design-ops:test` when something isn't working.

---

## Dashboard Command

The unified dashboard command generates reports across pillars and timeframes:

```bash
/design-ops:dashboard [pillar] [timeframe]
```

| Pillars | Timeframes |
|---------|------------|
| `ops` — Operations | `daily` (or `today`, `d`) |
| `design` — Design | `weekly` (or `week`, `w`) |
| `analytics` — Analytics | `quarterly` (or `quarter`, `q`) |
| omitted — All pillars | `ytd` (or `year`, `y`) |

**Examples:**
```bash
/design-ops:dashboard                    # All pillars, daily (default)
/design-ops:dashboard ops weekly         # Operations, weekly
/design-ops:dashboard design quarterly   # Design, quarterly
/design-ops:dashboard analytics ytd      # Analytics, year-to-date
/design-ops:dashboard weekly             # All pillars, weekly
```

---

## Legacy Aliases

These commands remain for backwards compatibility:

| Command | Maps To |
|---------|---------|
| `/design-ops:daily-brief` | `/design-ops:dashboard daily` |
| `/design-ops:weekly-recap` | `/design-ops:dashboard weekly` |
| `/design-ops:team-pulse` | `/design-ops:dashboard design daily --team` |

---

## Utility Library

Browse with `/design-ops:library` or `/design-ops:library [category]`.

**Quick access:**
- `/design-ops:library` — Browse all 14 utility commands
- `/design-ops:library design` — Show design commands only
- `/design-ops:library content` — Show content commands only
- `/design-ops:library development` — Show development commands only
- `/design-ops:library logistics` — Show logistics commands only

### Logistics (3)
*Meeting prep, kickoffs, and project coordination*

| Command | Description |
|---------|-------------|
| `/design-ops:meeting-brief` | Create focused meeting agendas |
| `/design-ops:meeting-recap` | Document meetings with action items |
| `/design-ops:kickoff-prep` | Generate project kickoff materials |

### Content (3)
*Content creation for social and marketing*

| Command | Description |
|---------|-------------|
| `/design-ops:social-post` | Create platform-optimized social content |
| `/design-ops:copy-variants` | Generate and A/B test copy variations |
| `/design-ops:content-brief` | Create content briefs for articles, blogs, case studies |

### Development (3)
*Research, analysis, and ideation tools*

| Command | Description |
|---------|-------------|
| `/design-ops:site-analysis` | Deep website analysis |
| `/design-ops:devils-advocate` | Challenge assumptions |
| `/design-ops:research-summary` | Synthesize research into actionable insights |

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

1. **First time?** Run `/design-ops:setup` to configure integrations
2. **Morning routine?** Run `/design-ops:dashboard` (or `/design-ops:daily-brief`)
3. **Weekly review?** Run `/design-ops:dashboard weekly`
4. **Check team activity?** Run `/design-ops:dashboard design`
5. **Explore utilities?** Run `/design-ops:library` to browse 14 utility commands
6. **Check config?** Run `/design-ops:status` for quick overview
7. **Something broken?** Run `/design-ops:test` for deep diagnostics

---

## Configuration

Config file: `~/.claude/design-ops-config.yaml`

View current config: `/design-ops:status`
Update config: `/design-ops:configure`

---

## Getting Help

- **Issues:** https://github.com/opensesh/DESIGN-OPS/issues
- **Docs:** See /references folder in plugin directory
- **Troubleshooting:** /references/troubleshooting.md
```

---

## Contextual Help

If user runs `/design-ops:help {topic}`:

**`/design-ops:help dashboard`**
```markdown
## Dashboard Command Help

### Usage
```bash
/design-ops:dashboard [pillar] [timeframe]
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
/design-ops:dashboard                    # All pillars, daily
/design-ops:dashboard ops                # Operations, daily
/design-ops:dashboard weekly             # All pillars, weekly
/design-ops:dashboard design quarterly   # Design, quarterly
```

### Configuration
Dashboard reads from `~/.claude/design-ops-config.yaml`:
- Which pillars are enabled
- Which tools are connected
- Which outcomes to include

Run `/design-ops:configure` to adjust.
```

**`/design-ops:help library`**
```markdown
## Library Command Help

### Usage
```bash
/design-ops:library              # List all 14 utility commands
/design-ops:library [category]   # Filter by category
```

### Categories
- `logistics` — Meeting prep, kickoffs, project coordination (3 commands)
- `content` — Content creation for social and marketing (3 commands)
- `development` — Research, analysis, ideation tools (3 commands)
- `design` — Design quality, research, variation tools (5 commands)

### Available Commands

**Logistics (3):**
- `/design-ops:meeting-brief` — Create meeting agendas
- `/design-ops:meeting-recap` — Document meetings
- `/design-ops:kickoff-prep` — Project kickoff materials

**Content (3):**
- `/design-ops:social-post` — Social media content
- `/design-ops:copy-variants` — A/B copy variations
- `/design-ops:content-brief` — Content briefs and outlines

**Development (3):**
- `/design-ops:site-analysis` — Website analysis
- `/design-ops:devils-advocate` — Challenge assumptions
- `/design-ops:research-summary` — Research synthesis

**Design (5):**
- `/design-ops:design-audit` — Design system compliance
- `/design-ops:a11y-audit` — Accessibility check (WCAG)
- `/design-ops:mood-board` — Design inspiration
- `/design-ops:competitor-scan` — Competitive analysis
- `/design-ops:variation-sprint` — Design variations

### Adding Commands
See `commands/library/_registry.yaml` for the registry format.
```

**`/design-ops:help figma`**
```markdown
## Figma Integration Help

### Setup
Run `/design-ops:setup` and select Figma integration, or run `/design-ops:configure` → Figma.

### Token Generation
1. Go to https://www.figma.com/developers/api#access-tokens
2. Generate token with "File content" scope
3. Paste in setup wizard

### Tracking
- Track entire projects (all files in project)
- Or track specific files by key

### Troubleshooting
- Token expired? Regenerate and update via `/design-ops:configure`
- Can't see projects? Check token has correct scope
- 403 errors? Token may have been revoked

See: /references/troubleshooting.md
```

**`/design-ops:help github`**
```markdown
## GitHub Integration Help

### Setup
GitHub uses MCP — no separate token needed.

If GitHub MCP isn't connected:
1. Go to claude.ai/mcps
2. Install GitHub MCP
3. Authorize with your account
4. Re-run `/design-ops:setup`

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

If user runs `/design-ops:help {unknown}`:

```markdown
I don't have specific help for "{topic}".

Try:
- `/design-ops:help dashboard` — Dashboard command usage
- `/design-ops:help library` — Utility command browser
- `/design-ops:help figma` — Figma integration
- `/design-ops:help github` — GitHub integration

Or search the documentation in /references/
```

---

*Version: 2.0*
