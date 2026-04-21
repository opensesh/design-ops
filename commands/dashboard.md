# /design-ops:dashboard

Unified dashboard command that generates pillar × timeframe reports from connected tools.

## Trigger

```bash
/design-ops:dashboard [pillar] [timeframe]
```

## Parameters

### Pillar (optional)

| Value | Description | Default |
|-------|-------------|---------|
| `ops` | Operations — calendar, tasks, communication | All pillars |
| `design` | Design — code repos, design files, team activity | All pillars |
| `analytics` | Analytics — web traffic, links, subscribers | All pillars |
| omitted | All enabled pillars combined | ✓ |

### Timeframe (optional)

| Value | Aliases | Description | Default |
|-------|---------|-------------|---------|
| `daily` | `today`, `d` | Today's activity | ✓ |
| `weekly` | `week`, `w` | This week's summary | — |
| `quarterly` | `quarter`, `q` | Quarter-to-date metrics | — |
| `ytd` | `year`, `y` | Year-to-date overview | — |

---

## Argument Parsing Logic

```
/design-ops:dashboard                    → all pillars, daily
/design-ops:dashboard ops                → operations, daily
/design-ops:dashboard weekly             → all pillars, weekly
/design-ops:dashboard ops weekly         → operations, weekly
/design-ops:dashboard design quarterly   → design, quarterly
/design-ops:dashboard analytics ytd      → analytics, year-to-date
```

**Detection rules:**
1. No args → all pillars, daily (defaults)
2. One arg → detect if pillar or timeframe, fill default for other
   - Pillar keywords: `ops`, `operations`, `design`, `analytics`
   - Timeframe keywords: `daily`, `today`, `d`, `weekly`, `week`, `w`, `quarterly`, `quarter`, `q`, `ytd`, `year`, `y`
3. Two args → pillar first, timeframe second

---

## Config-Aware Behavior

This command reads from `~/.claude/design-ops-config.yaml` and fetches data based on:
1. Which pillars are enabled
2. Which tools are connected in each pillar
3. Which outcomes are selected for the requested timeframe

### Pillar-Based Data Gathering

```yaml
# From config:
pillars:
  operations:
    outcomes:
      daily: [calendar_events, tasks_due, unread_emails]
      weekly: [week_overview, tasks_completed, team_activity]
      quarterly: [quarter_goals, budget_status, project_completions]
      ytd: [annual_goals, revenue_tracking, client_retention]
  design:
    outcomes:
      daily: [recent_commits, open_prs, design_updates]
      weekly: [team_contributions, design_versions, pr_activity]
      quarterly: [shipped_projects, design_velocity, system_coverage]
      ytd: [projects_shipped, design_maturity, component_growth]
  analytics:
    outcomes:
      daily: [pageviews, link_clicks]
      weekly: [traffic_trends, top_links, audience_growth]
      quarterly: [quarter_trends, campaign_performance, conversion_funnel]
      ytd: [annual_traffic, yoy_comparison, total_growth]
```

---

## Workflow

### Step 1: Parse Arguments

1. **Parse** command arguments
2. **Detect** pillar vs timeframe
3. **Apply defaults** for missing values
4. **Validate** pillar is enabled in config

### Step 2: Load Config

1. **Read** `~/.claude/design-ops-config.yaml`
2. **Filter** to requested pillar(s)
3. **Get** outcomes for requested timeframe
4. **Map** outcomes to connected tools

### Step 3: Fetch Data by Pillar × Timeframe

**CRITICAL:** Dashboard must attempt to fetch actual data from each connected tool.
Never display just "Connected" status — either show real data or explain why data isn't available.

For each enabled pillar and connected tool:

1. **Attempt data fetch** via MCP tool call
2. **If successful** → Display the actual metrics
3. **If failed** → Show specific error with fix guidance

#### Operations Pillar Data Fetching

```
For each tool in operations.tools where status == connected:

  if tool == notion:
    → Call mcp__notion__API-query-data-source to get tasks
    → If success: Display "Tasks due today: {count}" with task list
    → If error: Show "Notion — ⚠ {error_message}" with fix guidance

  if tool == google_workspace:
    → Call Google Calendar MCP for today's events
    → If OAuth needed: Show "Google Workspace — ⚠ OAuth Required"
      → Guidance: "Run a Google command to complete OAuth"
    → If success: Display "{count} events today" with schedule

  if tool == linear:
    → Call Linear MCP for assigned issues
    → Display "Open issues: {count}" with priority breakdown
```

#### Design Pillar Data Fetching

```
For each tool in design.tools where status == connected:

  if tool == github:
    → Call mcp__github__list_commits for each tracked repo
    → Display actual commit data with authors, messages, timestamps
    → Show open PRs with review status

  if tool == figma:
    → Use Figma MCP to get recent file activity
    → If OAuth needed: Show "Figma — ⚠ OAuth Required"
    → If success: Display "{file_name} — edited {time_ago} by {editor}"
```

#### Analytics Pillar Data Fetching

```
For each tool in analytics.tools where status == connected:

  if tool == dubco:
    → Call Dub.co MCP to list links and aggregate click counts
    → Display: "Total clicks: {count}"
    → Show top performing links with click counts

  if tool == vercel:
    → Call mcp__vercel__get_runtime_logs or list_deployments
    → Display deployment status, last deploy time

  if tool == google_analytics:
    → If configured: Fetch pageview/session data
    → If not configured: Show "GA4 — ⚠ Property ID needed"

  if tool == supabase:
    → If not authed: Show "Supabase — ⚠ OAuth Required"
      → Guidance: "Run a Supabase query to complete OAuth"
    → If authed: Display query count or user metrics
```

#### Summary by Pillar

**Operations pillar:**
- Daily: Calendar events, tasks due, unread emails/messages
- Weekly: Meeting count, tasks completed, communication volume
- Quarterly: Quarter goals progress, budget status, project completions
- YTD: Annual goals, revenue tracking, client retention metrics

**Design pillar:**
- Daily: Recent commits, open PRs, design file updates
- Weekly: Team contributions, design versions, PR activity
- Quarterly: Shipped projects, design velocity, system coverage
- YTD: Total projects shipped, design maturity score, component growth

**Analytics pillar:**
- Daily: Page views, link clicks, new subscribers
- Weekly: Traffic trends, top links, audience growth
- Quarterly: Quarter trends, campaign performance, conversion funnel
- YTD: Annual traffic totals, YoY comparison, total growth metrics

### Step 4: Render Output

Generate report using the appropriate template for pillar × timeframe.

**IMPORTANT:** When rendering output:
- Show actual data values from tool responses
- Never show just "✓ Connected" without data
- For failed fetches, show the error state with fix guidance

---

## Error State Templates

When data can't be fetched, show actionable guidance instead of silent failure.

### Template: Tool Needs OAuth

```markdown
**{Tool Name}** — ⚠ OAuth Required

Run any {Tool} command to complete authorization.
A browser window will open for OAuth.

Example: "show my {example_action}"
```

**Examples:**

```markdown
**Google Workspace** — ⚠ OAuth Required

Run any Google command to complete authorization.
A browser window will open for OAuth.

Example: "show my calendar for today"
```

```markdown
**Supabase** — ⚠ OAuth Required

Run any Supabase query to complete authorization.
A browser window will open for OAuth.

Example: "show my Supabase tables"
```

```markdown
**Figma** — ⚠ OAuth Required

Run any Figma command or paste a Figma URL to complete authorization.
A browser window will open for OAuth.

Example: Paste a figma.com/design/... URL
```

### Template: Environment Variable Missing

```markdown
**{Tool Name}** — ⚠ API Key Missing

Set {ENV_VAR} in your environment:
```bash
export {ENV_VAR}="{example_value}"
```

Then restart your terminal.
```

**Examples:**

```markdown
**Notion** — ⚠ API Key Missing

Set NOTION_API_KEY in your environment:
```bash
export NOTION_API_KEY="secret_..."
```

Then restart your terminal.

Get your token: https://www.notion.so/my-integrations
```

### Template: Tool Not Configured

```markdown
**{Tool Name}** — ⚠ Not Configured

To enable {tool_type} metrics:
1. {setup_step_1}
2. {setup_step_2}
3. Run `/design-ops:configure {pillar}` to add it

Or skip with: `/design-ops:configure {pillar}` to remove this tool
```

**Example:**

```markdown
**Google Analytics** — ⚠ Not Configured

To enable traffic metrics:
1. Get a GA4 property ID from analytics.google.com
2. Run `/design-ops:configure analytics` to add it

Or skip: This tool won't appear in dashboards until configured.
```

### Template: Connection Error

```markdown
**{Tool Name}** — ⚠ Connection Error

{error_message}

**Likely causes:**
1. {cause_1}
2. {cause_2}

**Fix:** {fix_guidance}
```

**Example:**

```markdown
**GitHub** — ⚠ Connection Error

MCP not responding (timeout after 10s)

**Likely causes:**
1. MCP server crashed — restart Claude
2. Network issue — check internet connection

**Fix:** Try restarting Claude, or run `claude mcp list`
```

---

## Output Templates

### Daily Template (All Pillars)

```markdown
## Dashboard — {Day}, {Month} {Date}

{If operations enabled:}
### Operations
**Schedule**
- {time} — {event title}

**Tasks Due**
- [ ] {task name}

**Communications**
- {count} unread emails ({flagged} flagged)
- {count} unread Slack messages

{If design enabled:}
### Design
**Recent Commits**
- **{repo}** — {author}: "{message}" ({time ago})

**Open PRs**
- #{number} "{title}" — {author} ({age})

**Figma Activity**
- **{file name}** — {editor}, {time ago}

{If analytics enabled:}
### Analytics

**Link Performance (Dub.co)**
{If dub.co connected and data fetched:}
- Total clicks today: {count} ({change} vs yesterday)
- Top links:
  1. /{slug_1} — {clicks_1} clicks
  2. /{slug_2} — {clicks_2} clicks
  3. /{slug_3} — {clicks_3} clicks
{If dub.co needs auth:}
⚠ Dub.co — OAuth required. Run a Dub command to complete setup.

**Web Traffic (Google Analytics)**
{If GA configured and data fetched:}
- Sessions today: {count}
- Page views: {count}
- Top page: {page} ({views} views)
{If GA not configured:}
⚠ Google Analytics — Not configured.
   Run `/design-ops:configure analytics` to add your GA4 property ID.

**Deployments (Vercel)**
{If vercel connected:}
- Latest deploy: {time_ago} ({status})
- Domains: {domain_list}
{If vercel needs auth:}
⚠ Vercel — OAuth required. Run a Vercel command to complete setup.

---

**Heads Up**
- {synthesized insight 1}
- {synthesized insight 2}
```

### Weekly Template (All Pillars)

```markdown
## Week of {Start Date} – {End Date}

{If operations enabled:}
### Operations Summary
**Meetings:** {count} this week ({comparison})
**Tasks:** {completed} of {planned} completed ({percentage}%)
**Communication:** {emails} emails, {messages} Slack messages

{If design enabled:}
### Development Summary
**Commits:** {total}
{For each team member:}
- {name}: {count} commits

**Pull Requests:**
- Opened: {count}
- Merged: {count}
- Avg review time: {hours} hours

### Design Summary
**Figma activity:**
- {versions} named versions created
- {files} files modified
- Most active: {file name}

{If analytics enabled:}
### Analytics Summary
**Traffic:** {sessions} sessions ({change} vs last week)
**Top pages:**
1. {page} — {views} views
2. {page} — {views} views

**Link performance:**
- Total clicks: {count}
- Top link: "{name}" — {clicks} clicks

---

### Patterns & Insights
- {pattern 1}
- {pattern 2}

### Focus for Next Week
1. {priority 1}
2. {priority 2}
```

### Quarterly Template (All Pillars)

```markdown
## Q{N} {Year} Dashboard

{If operations enabled:}
### Operations — Quarter Summary
**Goals Progress**
| Goal | Target | Actual | Status |
|------|--------|--------|--------|
| {goal} | {target} | {actual} | {status} |

**Projects Completed:** {count}
**Budget Status:** {amount} of {total} ({percentage}%)

{If design enabled:}
### Design — Quarter Summary
**Shipped Projects:** {count}
- {project name} — {date shipped}

**Design Velocity**
- PRs merged: {count}
- Avg cycle time: {days} days
- Design iterations: {count}

**System Coverage**
- Components documented: {count}
- Design token coverage: {percentage}%

{If analytics enabled:}
### Analytics — Quarter Summary
**Traffic Trends**
| Month | Sessions | Change |
|-------|----------|--------|
| {month} | {count} | {change} |

**Campaign Performance**
- Total campaigns: {count}
- Best performer: {name} ({metric})
- Conversion rate: {percentage}%

---

### Quarter Highlights
- {highlight 1}
- {highlight 2}

### Areas for Improvement
- {area 1}
- {area 2}
```

### YTD Template (All Pillars)

```markdown
## Year-to-Date Dashboard — {Year}

{If operations enabled:}
### Operations — YTD Summary
**Annual Goals**
| Goal | Progress | On Track |
|------|----------|----------|
| {goal} | {progress}% | {yes/no} |

**Client Retention:** {percentage}%
**Projects Delivered:** {count}
**Revenue:** ${amount} of ${target} ({percentage}%)

{If design enabled:}
### Design — YTD Summary
**Projects Shipped:** {count}
**Design Maturity**
- Design system adoption: {percentage}%
- Component reuse rate: {percentage}%
- Accessibility compliance: {percentage}%

**Growth Metrics**
- New components: {count}
- Documentation pages: {count}
- Design tokens: {count}

{If analytics enabled:}
### Analytics — YTD Summary
**Annual Traffic:** {total} sessions
**Year-over-Year:** {change}% vs {last_year}

**Growth by Quarter**
| Quarter | Sessions | Growth |
|---------|----------|--------|
| Q1 | {count} | {change}% |
| Q2 | {count} | {change}% |
| Q3 | {count} | {change}% |
| Q4 | {count} | {change}% |

**Total Growth:** {total_growth}%

---

### Year Highlights
- {highlight 1}
- {highlight 2}

### Remaining Goals
- {goal 1}
- {goal 2}
```

---

## Single Pillar Templates

When a specific pillar is requested, show only that pillar's data with expanded detail.

### Operations Only

```markdown
## Operations Dashboard — {Timeframe Title}

{Full operations section with expanded detail}
{Additional operations-specific metrics not shown in combined view}
```

### Design Only

```markdown
## Design Dashboard — {Timeframe Title}

{Full design section with expanded detail}
{Team member breakdown}
{Repository-level detail}
```

### Analytics Only

```markdown
## Analytics Dashboard — {Timeframe Title}

{Full analytics section with expanded detail}
{Source/medium breakdown}
{Geographic data if available}
```

---

## Graceful Degradation

### Pillar Disabled

If requested pillar is disabled:

```markdown
The {pillar} pillar is not enabled in your config.

Run `/design-ops:configure` to enable it, or try:
- `/design-ops:dashboard` (all enabled pillars)
- `/design-ops:dashboard {other_pillar}`
```

### No Data for Timeframe

If no outcomes configured for timeframe:

```markdown
No {timeframe} outcomes configured for {pillar}.

Your current config has outcomes for: {available_timeframes}

To add {timeframe} outcomes, run `/design-ops:configure`.
```

### No Config

```markdown
DESIGN-OPS isn't configured yet.

Run `/design-ops:setup` to connect your tools and start getting automated dashboards.

Or tell me what you'd like to review, and I'll help manually.
```

---

## Outcome to Tool Mapping

### Daily Outcomes

| Outcome | Tool | Capability |
|---------|------|------------|
| `calendar_events` | google_workspace | todays_events |
| `tasks_due` | notion, linear | task_counts |
| `unread_emails` | google_workspace | unread_emails |
| `recent_commits` | github | recent_commits |
| `open_prs` | github | open_prs |
| `design_updates` | figma | files_edited |
| `pageviews` | google_analytics | session_count |
| `link_clicks` | dubco | click_counts |

### Weekly Outcomes

| Outcome | Tool | Capability |
|---------|------|------------|
| `week_overview` | google_workspace | event_count |
| `tasks_completed` | notion, linear | task_completion |
| `team_contributions` | github | team_contributions |
| `design_versions` | figma | design_versions |
| `traffic_trends` | google_analytics | traffic_trends |
| `top_links` | dubco | top_links |

### Quarterly Outcomes

| Outcome | Tool | Capability |
|---------|------|------------|
| `quarter_goals` | notion, linear | goal_tracking |
| `budget_status` | notion | budget_tracking |
| `shipped_projects` | github, figma | release_history |
| `design_velocity` | github | pr_velocity |
| `quarter_trends` | google_analytics | quarter_comparison |
| `campaign_performance` | google_analytics | campaign_metrics |

### YTD Outcomes

| Outcome | Tool | Capability |
|---------|------|------------|
| `annual_goals` | notion, linear | annual_tracking |
| `revenue_tracking` | notion | revenue_metrics |
| `projects_shipped` | github, figma | annual_releases |
| `design_maturity` | figma | system_coverage |
| `annual_traffic` | google_analytics | annual_totals |
| `yoy_comparison` | google_analytics | year_comparison |

---

## Follow-up Offers

After presenting any dashboard:

```markdown
---

**Want me to:**
- Drill down into any section?
- Compare to a different timeframe?
- Export this as a document?
```

---

## Examples

### Example: Default (All Pillars, Daily)

```bash
/design-ops:dashboard
```

Shows combined daily dashboard across all enabled pillars.

### Example: Operations Weekly

```bash
/design-ops:dashboard ops weekly
```

Shows operations-only weekly summary with meeting count, tasks completed, and communication volume.

### Example: Design Quarterly

```bash
/design-ops:dashboard design quarterly
```

Shows design-only quarterly summary with shipped projects, design velocity, and system coverage metrics.

### Example: Analytics YTD

```bash
/design-ops:dashboard analytics ytd
```

Shows analytics-only year-to-date summary with annual traffic totals and YoY comparisons.

### Example: Just Timeframe

```bash
/design-ops:dashboard weekly
```

Shows all enabled pillars with weekly timeframe.

---

*Version: 1.0*
