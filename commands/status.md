# /do:status

Show current configuration status organized by pillars, integration health, and available commands.

## Trigger

User runs `/do:status` to see what's configured and working.

---

## Workflow

### Step 1: Load Configuration

1. **Read** `~/.claude/do-config.yaml`
2. **If not found:**
   ```markdown
   ## DESIGN-OPS — Not Configured

   No configuration found at ~/.claude/do-config.yaml

   Run `/do:setup` to get started, or see `/do:help` for available commands.
   ```
   Exit early.

3. **Check version**
   - If v1.x: "Found legacy v1 config. Run `/do:setup` to migrate to v2."
   - If v2.x: Continue

4. **Parse** config and note any issues

---

### Step 2: Check Integration Health

For each pillar, check connected tools:

**For MCP connections:**
- Try a basic query to verify MCP is responding
- Success → "Connected"
- Timeout → "Not responding"

**For API connections:**
- Validate token if stored
- Success → "Connected as {handle}"
- Failure → "Token invalid or expired"

---

### Step 3: Render Status

```markdown
## DESIGN-OPS — Status

**Config version:** 2.0
**Last updated:** April 14, 2025

---

### Operations Pillar

| Tool             | Status      | Details                    |
|------------------|-------------|----------------------------|
| Notion           | Connected   | MCP, 3 databases tracked   |
| Google Workspace | Connected   | MCP, calendar + email      |
| Slack            | Not configured | —                       |

**Daily outcomes:** calendar_events, tasks_due, unread_emails
**Weekly outcomes:** week_overview, tasks_completed

---

### Design Pillar

| Tool   | Status      | Details                    |
|--------|-------------|----------------------------|
| GitHub | Connected   | MCP, 2 repos tracked       |
| Figma  | Connected   | API, 1 project tracked     |

**Daily outcomes:** recent_commits, open_prs, design_updates
**Weekly outcomes:** team_contributions, design_versions

---

### Analytics Pillar

| Tool             | Status      | Details                    |
|------------------|-------------|----------------------------|
| Google Analytics | Connected   | MCP, GA4 property          |
| Dub.co           | Connected   | MCP, 15 links tracked      |
| Substack         | Skipped     | No wrapper created         |

**Daily outcomes:** pageviews, link_clicks
**Weekly outcomes:** traffic_trends, top_links

---

### Team

| Name        | Figma        | GitHub       |
|-------------|--------------|--------------|
| Jordan      | jordan.smith | jordansmith  |
| Taylor Lee  | taylor.lee   | taylorl      |

---

### Enabled Commands

Based on your connected tools:
- `/do:daily-brief` — Operations + Design + Analytics
- `/do:weekly-recap` — Operations + Design + Analytics
- `/do:team-pulse` — Design (GitHub + Figma)
- `/do:analytics` — Analytics

---

### Config Location

`~/.claude/do-config.yaml`

---

### Quick Actions

- `/do:configure` — Update settings
- `/do:test` — Run diagnostics
- `/do:add-tool` — Connect new tools
- `/do:help` — Command reference
```

---

## Pillar Status Indicators

| Status | Display | Meaning |
|--------|---------|---------|
| All tools connected | Pillar: Active | Fully operational |
| Some tools connected | Pillar: Partial | Some features limited |
| No tools connected | Pillar: Inactive | Pillar disabled |
| Tools with issues | Pillar: Issues | Needs attention |

---

## Tool Status Indicators

| Status | Display | Meaning |
|--------|---------|---------|
| Working | Connected | Fully operational |
| Connected but limited | Connected (limited) | Some features unavailable |
| Token/auth issue | Error | Needs reauthorization |
| Not responding | Not responding | MCP/API timeout |
| Not configured | Not configured | Never set up |
| Skipped | Skipped | User chose to skip |

---

## Minimal Status (No Config)

If config doesn't exist:

```markdown
## DESIGN-OPS — Not Set Up

The plugin is installed but not configured.

**What you can still use:**
- `/do:help` — See all commands
- `/do:setup` — Configure integrations

**Auto-activating skills** (work without config):
- brand-guidelines
- frontend-design
- design-system-quality
- verification-before-completion
```

---

## Compact Status

For quick checks, show condensed view:

```markdown
## DESIGN-OPS Status

**Operations:** ✓ Notion, Google Workspace | ⚠ Slack (not configured)
**Design:** ✓ GitHub, Figma
**Analytics:** ✓ GA4, Dub.co | ○ Substack (skipped)

All systems operational. Run `/do:test` for detailed diagnostics.
```

---

## Troubleshooting Hints

If issues detected, append:

```markdown
---

### Issues Detected

**Figma token expired:**
Your Figma token is no longer valid.
Fix: `/do:configure` → Design → Figma → Update token

**GitHub repo not found:**
Repository `opensesh/old-repo` no longer exists.
Fix: `/do:configure` → Design → GitHub → Remove repo

**Substack not connected:**
You skipped Substack during setup. To add it:
Run: `/do:add-tool substack`
```

---

## Status by Pillar Command

User can check specific pillar:

```
/do:status operations
/do:status design
/do:status analytics
```

Shows detailed status for just that pillar:

```markdown
## Operations Pillar — Detailed Status

### Notion (MCP)
- Status: Connected
- MCP name: notion
- Databases tracked: 3
  - Tasks (database_id: abc123)
  - Projects (database_id: def456)
  - Notes (database_id: ghi789)
- Capabilities:
  - Daily: recent_pages, task_counts
  - Weekly: page_activity, task_completion

### Google Workspace (MCP)
- Status: Connected
- Components:
  - Calendar: Active
  - Gmail: Active
  - Drive: Not configured
- Capabilities:
  - Daily: todays_events, unread_emails
  - Weekly: event_count, email_volume

### Slack
- Status: Not configured
- MCP available but not installed
- To add: `/do:add-tool slack`
```

---

*Version: 2.0*
