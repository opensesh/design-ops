# /do:configure

Update specific settings without running full setup. Pillar-based configuration with re-evaluation options.

## Trigger

User runs `/do:configure` to modify existing configuration.

Can also target specific pillars:
- `/do:configure operations`
- `/do:configure design`
- `/do:configure analytics`
- `/do:configure team`

---

## Pre-Flight Check

1. **Check for config** at `~/.claude/do-config.yaml`
   - If not found: "No config found. Run `/do:setup` first to get started."
   - Exit early

2. **Check version**
   - If v1.x: "Found v1 config. Run `/do:setup` to migrate to v2 first."
   - If v2.x: Continue

3. **Load current config** and validate structure

---

## Main Menu

```markdown
## Configure DESIGN-OPS

**Current status:**
- Operations: 2 tools (Notion, Google Workspace)
- Design: 2 tools (GitHub, Figma)
- Analytics: 2 tools (GA4, Dub.co), 1 skipped

What would you like to configure?
```

Options:
- `Operations pillar` — Modify operations tools and outcomes
- `Design pillar` — Modify design tools and outcomes
- `Analytics pillar` — Modify analytics tools and outcomes
- `Team members` — Add/edit/remove team mappings
- `Display preferences` — Time windows, output options
- `Add new tool` — Trigger `/do:add-tool`
- `Re-evaluate all tools` — Re-run tool evaluation
- `View full config` — Show complete YAML

---

## Pillar Configuration

### Operations Pillar

```markdown
## Operations Pillar Configuration

**Connected tools:**
┌──────────────────┬───────────┬─────────────────────────────┐
│ Tool             │ Status    │ Tracking                    │
├──────────────────┼───────────┼─────────────────────────────┤
│ Notion           │ Connected │ 3 databases                 │
│ Google Workspace │ Connected │ Calendar, Gmail             │
│ Slack            │ Skipped   │ —                           │
└──────────────────┴───────────┴─────────────────────────────┘

**Current outcomes:**
- Daily: calendar_events, tasks_due, unread_emails
- Weekly: week_overview, tasks_completed

What would you like to do?
```

Options:
- `Modify Notion settings`
- `Modify Google Workspace settings`
- `Add Slack` (if skipped)
- `Add another tool`
- `Change daily outcomes`
- `Change weekly outcomes`
- `Disable this pillar`
- `Back to main menu`

---

### Tool Settings (Example: Notion)

```markdown
## Notion Configuration

**Connection:** MCP (notion)
**Status:** Connected

**Tracked databases:**
1. Tasks (database_id: abc123)
2. Projects (database_id: def456)
3. Notes (database_id: ghi789)

**Capabilities:**
- Daily: recent_pages, task_counts
- Weekly: page_activity, task_completion

What would you like to do?
```

Options:
- `Add database to track`
- `Remove database`
- `Test connection`
- `Remove Notion entirely`
- `Back`

---

### Design Pillar

```markdown
## Design Pillar Configuration

**Connected tools:**
┌────────┬───────────┬─────────────────────────────┐
│ Tool   │ Status    │ Tracking                    │
├────────┼───────────┼─────────────────────────────┤
│ GitHub │ Connected │ 2 repos                     │
│ Figma  │ Connected │ 1 project, API token valid  │
└────────┴───────────┴─────────────────────────────┘

**Current outcomes:**
- Daily: recent_commits, open_prs, design_updates
- Weekly: team_contributions, design_versions

What would you like to do?
```

Options:
- `Modify GitHub settings`
- `Modify Figma settings`
- `Add another tool`
- `Change daily outcomes`
- `Change weekly outcomes`
- `Disable this pillar`
- `Back to main menu`

---

### GitHub Settings

```markdown
## GitHub Configuration

**Connection:** MCP (github)
**Status:** Connected

**Tracked repositories:**
1. opensesh/webapp
2. opensesh/design-system

What would you like to do?
```

Options:
- `Add repository`
- `Remove repository`
- `Test connection`
- `Back`

**Add repository flow:**
```markdown
Enter repository in owner/repo format:

Repository: [input]
```

Validate repo exists via MCP, then update config.

---

### Figma Settings

```markdown
## Figma Configuration

**Connection:** API (direct)
**Token:** ****abc1 (valid, expires: never)
**User:** jordan.smith

**Tracked projects:**
1. Design System (id: 123456789)

**Tracked files:**
(none)

What would you like to do?
```

Options:
- `Update API token`
- `Add project to track`
- `Add specific file to track`
- `Remove project`
- `Test connection`
- `Back`

---

### Analytics Pillar

```markdown
## Analytics Pillar Configuration

**Connected tools:**
┌──────────────────┬───────────┬─────────────────────────────┐
│ Tool             │ Status    │ Details                     │
├──────────────────┼───────────┼─────────────────────────────┤
│ Google Analytics │ Connected │ GA4 property                │
│ Dub.co           │ Connected │ 15 links tracked            │
│ Substack         │ Skipped   │ No wrapper created          │
└──────────────────┴───────────┴─────────────────────────────┘

**Current outcomes:**
- Daily: pageviews, link_clicks
- Weekly: traffic_trends, top_links

What would you like to do?
```

Options:
- `Modify Google Analytics settings`
- `Modify Dub.co settings`
- `Set up Substack` (if skipped)
- `Add another tool`
- `Change daily outcomes`
- `Change weekly outcomes`
- `Disable this pillar`
- `Back to main menu`

---

## Outcome Configuration

```markdown
## Configure Daily Outcomes (Operations)

Available outcomes based on connected tools:

**From Google Workspace:**
☑ calendar_events — Today's meetings
☐ unread_emails — Unread email count

**From Notion:**
☑ tasks_due — Tasks due today
☐ recent_pages — Recently edited pages

**From Slack (not connected):**
☐ unread_messages — Requires Slack setup

[Save changes]
```

---

## Team Configuration

```markdown
## Team Configuration

**Current members:**
┌─────────────┬───────────────┬──────────────┐
│ Name        │ Figma         │ GitHub       │
├─────────────┼───────────────┼──────────────┤
│ Jordan      │ jordan.smith  │ jordansmith  │
│ Taylor Lee  │ taylor.lee    │ taylorl      │
└─────────────┴───────────────┴──────────────┘

What would you like to do?
```

Options:
- `Add team member`
- `Edit member`
- `Remove member`
- `Back to main menu`

**Add member flow:**
```markdown
Adding new team member:

Display name: [input]
Figma handle (optional): [input]
GitHub username (optional): [input]
Notion name (optional): [input]
Slack handle (optional): [input]
```

---

## Display Preferences

```markdown
## Display Preferences

**Current settings:**
- Activity window: 24 hours
- Show PRs: Yes
- Show commits: Yes
- Show Figma versions: Yes

What would you like to change?
```

Options for each setting.

---

## Re-Evaluation

```markdown
## Re-evaluate Tools

This will check all your configured tools again to:
- Verify connections are still working
- Update capability matrices
- Find newly available MCPs

Proceed with re-evaluation?
```

If yes, run tool-evaluator for each configured tool and update config.

---

## Writing Changes

Before any write:

1. **Show diff** of proposed changes:
```markdown
## Proposed Changes

```diff
 pillars:
   design:
     tools:
       - id: github
         tracked_repos:
           - owner: "opensesh"
             repo: "webapp"
+          - owner: "opensesh"
+            repo: "marketing-site"
```

Proceed with these changes?
```

2. **Backup** current config:
```bash
cp ~/.claude/do-config.yaml ~/.claude/do-config.yaml.bak
```

3. **Write** updated config

4. **Confirm:**
```markdown
Configuration updated!

**Changed:**
- Added GitHub repository: opensesh/marketing-site

Run `/do:test` to verify, or `/do:status` to review.
```

---

## Error Handling

**If config is malformed:**
```markdown
Your config file has syntax errors and couldn't be parsed.

Options:
- Restore from backup (if available)
- Start fresh with /do:setup
- Show raw file for manual fix
```

**If API validation fails:**
```markdown
Couldn't verify {item}. This might be:
- Invalid ID/token
- Network issue
- Permission problem

Save anyway? (It may not work until fixed)
```

---

## Quick Configure

For common operations, support inline commands:

```
/do:configure add-repo opensesh/new-repo
/do:configure add-figma-project 123456789 "New Project"
/do:configure update-token figma
```

---

*Version: 2.0*
