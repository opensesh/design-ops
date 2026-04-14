# Tool Registry

Known tools database for DESIGN-OPS. Contains MCP availability, API capabilities, and reporting potential for each tool.

---

## Quick Reference

| Tool | MCP | API | Status | Pillar |
|------|-----|-----|--------|--------|
| Notion | Official ✓ | ✓ | Full support | Operations |
| Google Workspace | Official ✓ | ✓ | Full support | Operations |
| Linear | Community ✓ | ✓ | Full support | Operations |
| Asana | Limited | ✓ | API recommended | Operations |
| Slack | Community ✓ | ✓ | Full support | Operations |
| GitHub | Official ✓ | ✓ | Full support | Design |
| GitLab | Community ✓ | ✓ | Full support | Design |
| Bitbucket | None | ✓ | Wrapper needed | Design |
| Figma | Code-only | ✓ | API for reporting | Design |
| Sketch | None | Limited | Limited support | Design |
| GA4 | Official ✓ | ✓ | Full support | Analytics |
| Plausible | None | ✓ | Wrapper needed | Analytics |
| Dub.co | Unofficial ✓ | ✓ | Full support | Analytics |
| Bitly | None | ✓ | Wrapper needed | Analytics |
| Substack | None | ✓ | Wrapper needed | Analytics |
| Instagram | None | Limited | Business only | Analytics |
| Twitter/X | None | Paid | Paid tiers only | Analytics |
| LinkedIn | None | Limited | Company pages only | Analytics |

---

## Operations Pillar Tools

### Notion

**MCP Status:** Official hosted MCP ✓
**Install:** `claude mcp add notion -- npx -y @anthropic/mcp-notion`
**Auth:** API key (Internal Integration Token)
**Docs:** https://developers.notion.com

**Capabilities:**
```yaml
data_types: [pages, databases, blocks, comments, users]
reporting:
  daily:
    - recent_pages: "Pages modified in last 24h"
    - task_counts: "Tasks by status (Todo/In Progress/Done)"
    - recent_comments: "Comments from today"
  weekly:
    - page_activity: "Page creation/modification counts"
    - task_completion: "Tasks completed this week"
    - database_changes: "Database entries added/modified"
  monthly:
    - content_growth: "Total pages/databases created"
    - workspace_activity: "Overall activity trends"
```

**API Endpoints for Reporting:**
- `POST /v1/search` — Find pages modified in timeframe
- `POST /v1/databases/{id}/query` — Query tasks/items
- `GET /v1/blocks/{id}/children` — Get page content
- `GET /v1/comments` — Get comments

---

### Google Workspace

**MCP Status:** Multiple official MCPs ✓
**Components:**
- Google Calendar: `claude mcp add google-calendar -- npx -y @anthropic/mcp-google-calendar`
- Gmail: `claude mcp add gmail -- npx -y @anthropic/mcp-gmail`
- Google Drive: `claude mcp add google-drive -- npx -y @anthropic/mcp-google-drive`
- Google Docs: `claude mcp add google-docs -- npx -y @anthropic/mcp-google-docs`

**Auth:** OAuth (browser-based)
**Docs:** https://developers.google.com/workspace

**Capabilities:**
```yaml
data_types: [calendar_events, emails, documents, files]
reporting:
  daily:
    - todays_events: "Calendar events for today"
    - unread_emails: "Unread email count and summaries"
    - recent_docs: "Recently modified documents"
  weekly:
    - event_count: "Total meetings this week"
    - email_volume: "Emails sent/received"
    - busy_days: "Most meeting-heavy days"
  monthly:
    - meeting_trends: "Meeting patterns over time"
```

---

### Linear

**MCP Status:** Community MCP ✓
**Install:** `claude mcp add linear -- npx -y @linear/mcp-linear`
**Auth:** API key
**Docs:** https://developers.linear.app

**Capabilities:**
```yaml
data_types: [issues, projects, cycles, teams, labels]
reporting:
  daily:
    - issues_due: "Issues due today"
    - assigned_issues: "Issues assigned to user"
    - recently_updated: "Issues updated in last 24h"
  weekly:
    - issues_completed: "Issues closed this week"
    - cycle_progress: "Current cycle burn-down"
    - velocity: "Points completed vs planned"
  monthly:
    - team_velocity: "Average velocity trends"
    - project_progress: "Project completion rates"
```

---

### Asana

**MCP Status:** Limited community support
**Recommended:** Direct API integration
**Auth:** Personal Access Token
**Docs:** https://developers.asana.com

**Capabilities:**
```yaml
data_types: [tasks, projects, sections, workspaces]
reporting:
  daily:
    - tasks_due: "Tasks due today"
    - assigned_tasks: "Tasks assigned to user"
    - recently_completed: "Tasks completed in last 24h"
  weekly:
    - project_progress: "Tasks completed per project"
    - section_flow: "Task movement between sections"
  monthly:
    - completion_trends: "Task completion over time"
```

**API Endpoints:**
- `GET /tasks` — List tasks with filters
- `GET /projects/{gid}/tasks` — Project tasks
- `GET /workspaces/{gid}/tasks/search` — Search tasks

---

### Slack

**MCP Status:** Community MCPs available ✓
**Install:** `claude mcp add slack -- npx -y @anthropic/mcp-slack`
**Auth:** OAuth / Bot Token
**Docs:** https://api.slack.com

**Capabilities:**
```yaml
data_types: [messages, channels, reactions, users]
reporting:
  daily:
    - unread_counts: "Unread message counts per channel"
    - recent_mentions: "Messages mentioning user"
    - dm_summary: "Direct message overview"
  weekly:
    - channel_activity: "Most active channels"
    - thread_participation: "Threads user participated in"
  monthly:
    - communication_patterns: "Peak activity times"
```

**Limitations:**
- Message history limited by Slack plan
- Some MCPs require bot installation in workspace

---

## Design Pillar Tools

### GitHub

**MCP Status:** Official MCP ✓
**Install:** `claude mcp add github -- npx -y @anthropic/mcp-github`
**Auth:** OAuth or Personal Access Token
**Docs:** https://docs.github.com/en/rest

**Capabilities:**
```yaml
data_types: [repos, commits, pull_requests, issues, actions]
reporting:
  daily:
    - recent_commits: "Commits in last 24h"
    - open_prs: "Open pull requests needing review"
    - pr_reviews: "Reviews requested from user"
  weekly:
    - team_contributions: "Commits grouped by author"
    - pr_activity: "PRs opened, merged, closed"
    - issue_flow: "Issues opened vs closed"
  monthly:
    - merge_stats: "PR merge times, approval rates"
    - contributor_ranking: "Top contributors"
```

---

### GitLab

**MCP Status:** Community MCP ✓
**Install:** `claude mcp add gitlab -- npx -y mcp-gitlab`
**Auth:** Personal Access Token
**Docs:** https://docs.gitlab.com/ee/api/

**Capabilities:**
```yaml
data_types: [projects, commits, merge_requests, issues, pipelines]
reporting:
  daily:
    - recent_commits: "Commits in last 24h"
    - open_mrs: "Open merge requests"
    - pipeline_status: "Recent pipeline runs"
  weekly:
    - contributions: "Commits by author"
    - mr_activity: "MRs opened, merged, closed"
    - ci_stats: "Pipeline success rates"
```

---

### Bitbucket

**MCP Status:** None
**Recommended:** Custom wrapper via API
**Auth:** App password
**Docs:** https://developer.atlassian.com/cloud/bitbucket/rest/intro/

**Capabilities:**
```yaml
data_types: [repositories, commits, pull_requests, pipelines]
reporting:
  daily:
    - recent_commits: "Commits in last 24h"
    - open_prs: "Open pull requests"
  weekly:
    - contributions: "Commits by author"
```

**Wrapper Creation:**
Use `/mcp-builder` with Bitbucket REST API v2.0

---

### Figma

**MCP Status:** Official MCP (code-focused, NOT for reporting)
**Recommended:** Direct API for reporting
**Auth:** Personal Access Token
**Docs:** https://www.figma.com/developers/api

**Why not MCP for reporting:**
The official Figma MCP is designed for code generation workflows (reading design tokens, generating code from components). It doesn't expose the endpoints needed for activity tracking.

**Capabilities via API:**
```yaml
data_types: [files, versions, comments, users, projects]
reporting:
  daily:
    - files_edited: "Files modified in last 24h"
    - active_users: "Users with recent activity"
    - new_comments: "Comments posted today"
  weekly:
    - design_versions: "Named versions created"
    - comment_activity: "Comment threads and replies"
    - file_changes: "Significant file modifications"
  monthly:
    - project_progress: "Design completion estimates"
```

**API Endpoints:**
- `GET /v1/files/{key}/versions` — File version history
- `GET /v1/files/{key}/comments` — File comments
- `GET /v1/projects/{id}/files` — Project files
- `GET /v1/me` — Current user info

**Token Setup:**
1. Go to: https://www.figma.com/developers/api#access-tokens
2. Generate token with "File content" scope
3. Store in env var `FIGMA_API_TOKEN` or config

---

### Sketch

**MCP Status:** None
**API Status:** Limited (Sketch Cloud API)
**Docs:** https://developer.sketch.com/

**Limitations:**
- Sketch Cloud API has limited functionality
- No version history or activity tracking
- File access requires Sketch Cloud subscription

**Status:** Often unavailable for reporting purposes

**Alternatives:**
- Export designs to Figma for tracking
- Use Abstract for version control (has better API)

---

## Analytics Pillar Tools

### Google Analytics (GA4)

**MCP Status:** Official GA4 MCP ✓
**Install:** `claude mcp add ga4 -- npx -y @anthropic/mcp-google-analytics`
**Auth:** OAuth
**Docs:** https://developers.google.com/analytics

**Capabilities:**
```yaml
data_types: [pageviews, sessions, events, conversions, users]
reporting:
  daily:
    - session_count: "Total sessions today"
    - top_pages: "Most viewed pages"
    - active_users: "Real-time user count"
  weekly:
    - traffic_trends: "Session trends over week"
    - source_breakdown: "Traffic sources"
    - top_content: "Best performing content"
  monthly:
    - month_comparison: "Month-over-month changes"
    - conversion_rates: "Goal completion rates"
    - audience_growth: "New vs returning users"
```

---

### Plausible

**MCP Status:** None
**API Status:** Good reporting API ✓
**Docs:** https://plausible.io/docs/stats-api

**Capabilities:**
```yaml
data_types: [visitors, pageviews, sources, countries, devices]
reporting:
  daily:
    - visitor_count: "Unique visitors today"
    - top_pages: "Most viewed pages"
  weekly:
    - traffic_trends: "Visitor trends"
    - referrer_breakdown: "Traffic sources"
```

**Wrapper Creation:**
Use `/mcp-builder` with Plausible Stats API

---

### Dub.co

**MCP Status:** Unofficial MCP ✓
**Install:** `claude mcp add dubco -- npx -y mcp-dub`
**Auth:** API key
**Docs:** https://dub.co/docs/api-reference

**Capabilities:**
```yaml
data_types: [links, clicks, referrers, countries, devices]
reporting:
  daily:
    - click_counts: "Clicks per link today"
    - top_referrers: "Where clicks came from"
  weekly:
    - top_links: "Best performing links"
    - click_trends: "Click patterns over time"
    - geo_breakdown: "Clicks by country"
```

---

### Bitly

**MCP Status:** None
**API Status:** Good API ✓
**Docs:** https://dev.bitly.com/

**Capabilities:**
```yaml
data_types: [links, clicks, referrers]
reporting:
  daily:
    - click_counts: "Clicks per link"
  weekly:
    - top_links: "Best performers"
```

**Wrapper Creation:**
Use `/mcp-builder` with Bitly API v4

---

### Substack

**MCP Status:** None
**API Status:** Basic API available ✓
**Docs:** https://substack.com/api (limited documentation)

**Capabilities:**
```yaml
data_types: [subscribers, posts, email_stats]
reporting:
  daily:
    - new_subscribers: "Subscribers gained today"
  weekly:
    - subscriber_growth: "Net subscriber change"
    - post_views: "Views per post"
    - email_open_rates: "Email performance"
  monthly:
    - audience_trends: "Growth over time"
```

**API Endpoints (unofficial):**
- `GET /api/v1/publication/{id}/stats` — Publication stats
- Newsletter statistics available in dashboard export

**Wrapper Creation:**
Use `/mcp-builder` with Substack's endpoints. Note: Some data may require scraping dashboard exports.

---

### Instagram

**MCP Status:** None
**API Status:** Very limited ⚠
**Docs:** https://developers.facebook.com/docs/instagram-api

**Limitations:**
- Requires Facebook Business account
- Must apply for Basic Display API access
- Review process can take weeks
- Limited to business/creator accounts

**Available for Business Accounts:**
```yaml
data_types: [profile, media, insights]
reporting:
  daily:
    - follower_count: "Current followers"
  weekly:
    - engagement: "Likes, comments, saves"
    - reach: "Account reach"
```

**Status:** Often unavailable for most users

**Alternatives:**
- Buffer, Later, Hootsuite have better APIs
- Consider manual tracking or dashboard exports

---

### Twitter/X

**MCP Status:** None
**API Status:** Paid tiers only ⚠
**Docs:** https://developer.twitter.com/

**Limitations:**
- Free tier extremely limited (read-only, low volume)
- Basic tier ($100/month) for meaningful access
- Pro tier ($5000/month) for analytics

**Status:** Generally unavailable due to cost

**Alternatives:**
- TweetDeck exports
- Third-party analytics tools (Followerwonk, etc.)

---

### LinkedIn

**MCP Status:** None
**API Status:** Very restricted ⚠
**Docs:** https://developer.linkedin.com/

**Limitations:**
- Marketing API only for company pages
- Requires LinkedIn Partnership Program for most data
- Personal profile data extremely limited

**Available for Company Pages:**
```yaml
data_types: [followers, posts, engagement]
reporting:
  weekly:
    - follower_growth: "Page followers"
    - post_engagement: "Likes, comments, shares"
```

**Status:** Limited to company page admins

---

## Connection Type Matrix

| Connection Type | Description | Setup Complexity | Reliability |
|-----------------|-------------|------------------|-------------|
| `mcp` | Native MCP server | Low | High |
| `api` | Direct API calls | Medium | High |
| `custom_wrapper` | User-created MCP | High | Medium |
| `unavailable` | No viable connection | N/A | N/A |

---

## Adding New Tools

When evaluating a new tool:

1. **Check for MCP:**
   - Search npm: `npm search mcp-{toolname}`
   - Check Anthropic's MCP registry
   - Search GitHub for community MCPs

2. **Evaluate API:**
   - Does it have a public REST API?
   - What authentication is required?
   - Are reporting endpoints available?
   - What rate limits apply?

3. **Determine Viability:**
   - Can it provide daily/weekly/monthly data?
   - Is auth process reasonable for users?
   - Are there usage limits that matter?

4. **Document in Registry:**
   - Add entry to appropriate pillar section
   - Include MCP install command if available
   - Document API endpoints for reporting
   - Note any limitations

---

*Last updated: 2025-04-14*
*Version: 1.0*
