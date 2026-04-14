# Configuration Schema Reference (v2.0)

Complete reference for the Design Company Skills configuration file.

## Version History

| Version | Description |
|---------|-------------|
| 2.0 | Three-pillar structure with capability matrices |
| 1.0 | Original flat structure (deprecated) |

---

## File Locations

| File | Purpose | Location |
|------|---------|----------|
| Global config | Main configuration | `~/.claude/dcs-config.yaml` |
| Project config | Per-project overrides | `.claude/design-company-skills.local.md` |
| Legacy config | Old team-pulse config (v1) | `~/.claude/team-pulse-config.yaml` |

---

## Configuration Structure Overview

```yaml
version: "2.0"
created: "2025-04-14"
updated: "2025-04-14"

pillars:
  operations:
    enabled: true/false
    tools: [...]
    outcomes:
      daily: [...]
      weekly: [...]
      monthly: [...]

  design:
    enabled: true/false
    tools: [...]
    outcomes:
      daily: [...]
      weekly: [...]
      monthly: [...]

  analytics:
    enabled: true/false
    tools: [...]
    outcomes:
      daily: [...]
      weekly: [...]
      monthly: [...]

team:
  members: [...]

preferences:
  activity_window_hours: 24
  show_prs: true
  show_commits: true
  show_versions: true

enabled_commands: [...]
```

---

## Metadata

```yaml
version: "2.0"           # Config schema version (required)
created: "2025-04-14"    # ISO date created
updated: "2025-04-14"    # ISO date last modified
```

---

## Pillars Structure

Each pillar (Operations, Design, Analytics) follows the same structure:

```yaml
pillars:
  {pillar_name}:
    enabled: true/false
    tools: [...]
    outcomes:
      daily: [...]
      weekly: [...]
      monthly: [...]
```

### Pillar: Operations

Covers coordination, scheduling, and task management tools.

**Common tools:** Notion, Google Workspace, Linear, Asana, Slack

### Pillar: Design

Covers creative work, code repositories, and design files.

**Common tools:** GitHub, GitLab, Figma, Sketch

### Pillar: Analytics

Covers metrics, insights, and reporting tools.

**Common tools:** Google Analytics, Dub.co, Substack, Plausible

---

## Tool Definition

Each tool in a pillar's `tools` array has this structure:

```yaml
tools:
  - id: string              # Unique tool identifier (e.g., "notion", "github")
    type: string            # Connection type: mcp | api | custom_wrapper | unavailable
    status: string          # connected | needs_setup | skipped | unavailable

    # For MCP connections
    mcp_name: string        # MCP server name as registered

    # For API connections
    auth:
      token: string         # Direct token (not recommended)
      token_env: string     # Environment variable name (recommended)

    # Capability matrix (auto-populated during setup)
    capabilities:
      data_types: [string]  # What data the tool provides
      reporting:
        daily: [string]     # Available daily metrics
        weekly: [string]    # Available weekly metrics
        monthly: [string]   # Available monthly metrics

    # Tool-specific tracking (optional)
    tracked_repos: [...]    # For GitHub/GitLab
    tracked_projects: [...] # For Figma/Notion
    tracked_files: [...]    # For Figma
    tracked_channels: [...] # For Slack

    # If unavailable or skipped
    reason: string          # Why tool isn't available
```

### Connection Types

| Type | Description | When to Use |
|------|-------------|-------------|
| `mcp` | Native MCP server | MCP available and connected |
| `api` | Direct API calls | No suitable MCP, good API available |
| `custom_wrapper` | User-created MCP wrapper | API needs wrapping for MCP interface |
| `unavailable` | Cannot connect | No MCP or API available |

### Status Values

| Status | Description |
|--------|-------------|
| `connected` | Tool is connected and working |
| `needs_setup` | MCP/API available but not configured |
| `skipped` | User chose to skip this tool |
| `unavailable` | Tool cannot be connected |

---

## Tool Examples

### MCP Connection (Notion)

```yaml
- id: notion
  type: mcp
  mcp_name: "notion"
  status: connected
  capabilities:
    data_types: [pages, databases, tasks, comments]
    reporting:
      daily: [recent_pages, task_counts]
      weekly: [page_activity, task_completion]
      monthly: [content_growth]
```

### API Connection (Figma)

```yaml
- id: figma
  type: api
  auth:
    token_env: FIGMA_API_TOKEN
  status: connected
  capabilities:
    data_types: [files, versions, comments, users]
    reporting:
      daily: [files_edited, active_users]
      weekly: [design_versions, comment_activity]
      monthly: [project_progress]
  tracked_projects:
    - id: "123456789"
      name: "Design System"
  tracked_files:
    - key: "ABC123xyz"
      name: "Marketing Landing Page"
```

### Custom Wrapper (Substack)

```yaml
- id: substack
  type: custom_wrapper
  mcp_name: "substack-wrapper"
  status: connected
  capabilities:
    data_types: [subscribers, posts, email_stats]
    reporting:
      daily: [new_subscribers]
      weekly: [subscriber_growth, post_views]
      monthly: [audience_trends]
```

### Unavailable Tool (Instagram)

```yaml
- id: instagram
  type: unavailable
  status: unavailable
  reason: "API limited to business accounts with complex approval process"
```

---

## Outcomes Configuration

Outcomes define what data to include in daily briefs, weekly recaps, and monthly reports.

```yaml
outcomes:
  daily:
    - calendar_events      # From google_workspace
    - tasks_due            # From notion/linear
    - recent_commits       # From github
    - design_updates       # From figma

  weekly:
    - week_overview        # From google_workspace
    - tasks_completed      # From notion/linear
    - team_contributions   # From github
    - traffic_trends       # From google_analytics

  monthly:
    - project_status       # From notion/linear
    - month_comparison     # From google_analytics
```

### Outcome to Tool Mapping

Each outcome references a capability from a connected tool:

| Outcome | Source Tool | Capability |
|---------|-------------|------------|
| `calendar_events` | google_workspace | `todays_events` |
| `tasks_due` | notion, linear | `task_counts` |
| `recent_commits` | github | `recent_commits` |
| `design_updates` | figma | `files_edited` |
| `traffic_trends` | google_analytics | `traffic_trends` |

Commands read the outcomes list and fetch data from the corresponding tool's capabilities.

---

## Team Configuration

```yaml
team:
  members:
    - name: "Jordan Smith"      # Display name
      handles:
        figma: "jordan.smith"   # Figma username
        github: "jordansmith"  # GitHub username
        notion: "Jordan Smith" # Notion display name
        slack: "jordan"           # Slack handle

    - name: "Taylor Lee"
      handles:
        figma: "taylor.lee"
        github: "taylorl"
```

Maps platform handles to friendly names for cleaner output in reports.

---

## Preferences

```yaml
preferences:
  activity_window_hours: 24   # Look-back window (default: 24h)
  show_prs: true              # Include open PRs in output
  show_commits: true          # Include recent commits
  show_versions: true         # Include Figma named versions
```

---

## Enabled Commands

Auto-computed based on connected tools:

```yaml
enabled_commands:
  - daily_brief      # Requires: any operations tool
  - weekly_recap     # Requires: any operations tool
  - team_pulse       # Requires: figma OR github
  - analytics        # Requires: any analytics tool
```

### Command Requirements

| Command | Required Tools |
|---------|----------------|
| `daily_brief` | At least one operations or design tool |
| `weekly_recap` | At least one operations or design tool |
| `team_pulse` | Figma OR GitHub with team tracking |
| `analytics` | At least one analytics tool |

---

## Complete Example (v2.0)

```yaml
version: "2.0"
created: "2025-04-14"
updated: "2025-04-14"

pillars:
  operations:
    enabled: true
    tools:
      - id: notion
        type: mcp
        mcp_name: "notion"
        status: connected
        capabilities:
          data_types: [pages, databases, tasks, comments]
          reporting:
            daily: [recent_pages, task_counts]
            weekly: [page_activity, task_completion]

      - id: google_workspace
        type: mcp
        mcp_name: "google-workspace"
        status: connected
        capabilities:
          data_types: [calendar, gmail, drive]
          reporting:
            daily: [todays_events, unread_emails]
            weekly: [event_count, email_volume]

    outcomes:
      daily: [calendar_events, tasks_due, unread_emails]
      weekly: [week_overview, tasks_completed]
      monthly: []

  design:
    enabled: true
    tools:
      - id: github
        type: mcp
        mcp_name: "github"
        status: connected
        capabilities:
          data_types: [repos, commits, prs, issues]
          reporting:
            daily: [recent_commits, open_prs]
            weekly: [team_contributions, pr_activity]
        tracked_repos:
          - owner: "opensesh"
            repo: "webapp"
          - owner: "opensesh"
            repo: "design-system"

      - id: figma
        type: api
        auth:
          token_env: FIGMA_API_TOKEN
        status: connected
        capabilities:
          data_types: [files, versions, comments, users]
          reporting:
            daily: [files_edited, active_users]
            weekly: [design_versions]
        tracked_projects:
          - id: "123456789"
            name: "Design System"

    outcomes:
      daily: [recent_commits, open_prs, design_updates]
      weekly: [team_contributions, design_versions, pr_activity]
      monthly: []

  analytics:
    enabled: true
    tools:
      - id: google_analytics
        type: mcp
        mcp_name: "ga4"
        status: connected
        capabilities:
          data_types: [pageviews, sessions, events]
          reporting:
            daily: [session_count, top_pages]
            weekly: [traffic_trends, source_breakdown]

      - id: dubco
        type: mcp
        mcp_name: "dubco"
        status: connected
        capabilities:
          data_types: [links, clicks, referrers]
          reporting:
            daily: [click_counts]
            weekly: [top_links]

      - id: substack
        type: unavailable
        status: skipped
        reason: "User skipped wrapper creation"

    outcomes:
      daily: [pageviews, link_clicks]
      weekly: [traffic_trends, top_links]
      monthly: [month_comparison]

team:
  members:
    - name: "Jordan Smith"
      handles:
        figma: "jordan.smith"
        github: "jordansmith"
        notion: "Jordan Smith"
    - name: "Taylor Lee"
      handles:
        figma: "taylor.lee"
        github: "taylorl"

preferences:
  activity_window_hours: 24
  show_prs: true
  show_commits: true
  show_versions: true

enabled_commands:
  - daily_brief
  - weekly_recap
  - team_pulse
  - analytics
```

---

## Migration from v1.0

If you have an existing v1.0 config, `/dcs:setup` will offer to migrate it.

### v1.0 Structure (deprecated)

```yaml
version: 1.0
figma:
  enabled: true
  api_token: "..."
  tracked_projects: [...]

github:
  enabled: true
  tracked_repos: [...]

team:
  members: [...]

workflows:
  daily: [morning_brief]
  weekly: [weekly_recap]
```

### Migration Mapping

| v1.0 Field | v2.0 Location |
|------------|---------------|
| `figma.*` | `pillars.design.tools[id=figma]` |
| `github.*` | `pillars.design.tools[id=github]` |
| `slack.*` | `pillars.operations.tools[id=slack]` |
| `team.members` | `team.members` (restructured handles) |
| `workflows.*` | `pillars.*.outcomes` |

---

## Validation Rules

### Required Fields

For `/dcs:test` to pass:
- `version` must be "2.0"
- At least one pillar must be enabled
- Enabled pillars must have at least one connected tool

### Token Validation

**Figma token:**
```bash
curl -s -H "Authorization: Bearer {token}" "https://api.figma.com/v1/me"
```

**MCP validation:**
Check that MCP server responds to basic queries.

---

## Troubleshooting

### Config Not Loading

1. Check file exists: `ls ~/.claude/dcs-config.yaml`
2. Check YAML syntax: `python -c "import yaml; yaml.safe_load(open(...))" `
3. Run `/dcs:test` for diagnostics

### Version Mismatch

If you see "Config version mismatch":
1. Back up current config
2. Run `/dcs:setup` to migrate
3. Or manually update to v2.0 structure

### Tool Connection Issues

1. Check `status` field in config
2. Verify MCP is in `~/.claude/settings.json`
3. Test API token manually
4. Run `/dcs:test` for specific tool tests

---

*See also: `/dcs:configure`, `/dcs:test`, `/dcs:status`*

*Version: 2.0*
