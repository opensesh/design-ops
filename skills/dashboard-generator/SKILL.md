# Dashboard HTML Generator

Generate static HTML dashboards from DESIGN-OPS data.

## Purpose

This skill provides instructions for generating polished, responsive HTML dashboards that work in any browser without build tools. It uses Tailwind CSS (CDN), Chart.js for visualizations, and Lucide Icons — all loaded from CDNs for zero-dependency output.

## When to Activate

Use this skill when:
- User runs `/design-ops:dashboard-html`
- User asks for a "visual dashboard" or "browser dashboard"
- User wants to "export dashboard to HTML"
- User mentions viewing dashboard on mobile or sharing with team

## Instructions

### Core Workflow

```
1. Parse Arguments    → Determine pillar and timeframe
2. Load Config        → Read ~/.claude/design-ops-config.yaml
3. Fetch Data         → Call MCP tools for each connected service
4. Select Components  → Use mapping.yaml rules
5. Assemble Template  → Populate base.html with content
6. Output & Present   → Write file and open in browser
```

### Phase 1: Parse Arguments

```
/design-ops:dashboard-html              → all pillars, daily
/design-ops:dashboard-html ops          → operations, daily
/design-ops:dashboard-html weekly       → all pillars, weekly
/design-ops:dashboard-html ops weekly   → operations, weekly
```

**Detection rules:**
- No args → all pillars, daily (defaults)
- One arg → detect if pillar or timeframe
- Two args → pillar first, timeframe second

### Phase 2: Load Configuration

1. Read `~/.claude/design-ops-config.yaml`
2. Filter to requested pillar(s)
3. Get outcomes for requested timeframe
4. Check for custom brand at `~/.claude/design-ops/brand.css`

### Phase 3: Fetch MCP Data

For each enabled pillar and connected tool:

**Operations:**
- `notion` → Query tasks, pages
- `google_workspace` → Calendar events, emails
- `linear` → Issues, projects

**Design:**
- `github` → Commits, PRs, repos
- `figma` → File activity, versions

**Analytics:**
- `dubco` → Link clicks, top links
- `google_analytics` → Sessions, pageviews
- `vercel` → Deployments

Handle errors gracefully — store error state for empty-state component.

### Phase 4: Component Selection

Use `templates/dashboard-html/mapping.yaml` rules:

| Data Type | Component |
|-----------|-----------|
| Single number | `stat-card` |
| Array with timestamps | `list-activity` |
| Array of {label, value} ≤8 items | `bar-chart` |
| Array of {label, value} >8 items | `table-simple` |
| Error/missing data | `empty-state` |

### Phase 5: Template Assembly

1. Load `templates/dashboard-html/base.html`
2. Inject brand CSS:
   - If `~/.claude/design-ops/brand.css` exists → use it
   - Otherwise → use `brands/open-session/brand.css`
3. Inject layout:
   - Single pillar → `layouts/single-pillar.html`
   - All pillars → `layouts/all-pillars.html`
4. Populate components with data
5. Embed chart data as JSON for Chart.js

**Template Variables:**
```
{{TITLE}}         → "Daily Dashboard" / "Weekly Summary"
{{SUBTITLE}}      → "Monday, April 21, 2026"
{{TIMESTAMP}}     → "2026-04-21 10:30 AM"
{{BRAND_CSS}}     → Contents of brand.css file
{{CONTENT}}       → Assembled layout with components
{{DASHBOARD_DATA}} → JSON object with chart configurations
```

### Phase 6: Output

1. Ensure `~/.claude/design-ops/` directory exists
2. Archive previous dashboard if exists:
   ```
   ~/.claude/design-ops/dashboard-history/dashboard-YYYY-MM-DD.html
   ```
3. Write to `~/.claude/design-ops/dashboard.html`
4. Open in browser:
   - macOS: `open ~/.claude/design-ops/dashboard.html`
   - Linux: `xdg-open ~/.claude/design-ops/dashboard.html`
   - Windows: `start ~/.claude/design-ops/dashboard.html`
5. Report success to user

## Component Population

### stat-card

```json
{
  "type": "single_metric",
  "id": "tasks-due",
  "title": "Tasks Due",
  "value": "12",
  "trend": "+3",
  "trend_direction": "up",
  "icon": "check-square"
}
```

### bar-chart

```json
{
  "type": "categorical",
  "id": "top-links",
  "title": "Top Links",
  "labels": ["Link A", "Link B", "Link C"],
  "values": [150, 89, 45]
}
```

Chart config for `dashboardData.charts`:
```json
{
  "id": "chart-top-links",
  "type": "bar",
  "labels": ["Link A", "Link B", "Link C"],
  "data": [150, 89, 45]
}
```

### list-activity

```json
{
  "type": "activity_list",
  "id": "recent-commits",
  "title": "Recent Commits",
  "items": [
    {
      "title": "feat: add dashboard",
      "subtitle": "Alex · main",
      "time": "2h ago",
      "icon": "git-commit"
    }
  ]
}
```

### empty-state

```json
{
  "type": "error",
  "id": "google-oauth",
  "error_type": "oauth_required",
  "icon": "key",
  "icon_color": "warning",
  "title": "Google Workspace",
  "message": "OAuth Required",
  "guidance": "Run any Google command to complete authorization."
}
```

## Error Handling

Always show actionable guidance for errors:

| Error Type | Icon | Message Template |
|------------|------|------------------|
| `oauth_required` | key | "Run any {{TOOL}} command to complete authorization." |
| `api_key_missing` | key | "Set {{ENV_VAR}} in your environment." |
| `not_configured` | settings | "Run /design-ops:configure to set up {{TOOL}}." |
| `connection_error` | wifi-off | "Check your network and try again." |
| `no_data` | inbox | "No {{DATA_TYPE}} found for this timeframe." |

## Output Format

After generating, report:

```markdown
Dashboard generated successfully.

**File:** ~/.claude/design-ops/dashboard.html
**Timeframe:** Daily
**Pillars:** Operations, Design, Analytics
**Components:** 8 cards, 2 charts, 3 activity lists

Opening in browser...
```

## Constraints

- Never require build tools (npm, node, etc.)
- Always use CDN links for dependencies
- Single HTML file output only
- Responsive design required
- Dark mode support required
- Must work offline after initial load

## Related

- `/design-ops:dashboard` - Terminal markdown output
- `/design-ops:configure brand` - Customize branding
- `templates/dashboard-html/mapping.yaml` - Component selection rules

---

*Version: 1.0*
