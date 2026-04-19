# /design-ops:setup

Main onboarding wizard for DESIGN-OPS. Guides users through connecting data sources across three business pillars: Operations, Design, and Analytics.

## Trigger

User runs `/design-ops:setup` to configure the plugin. Works in:
- Claude Code CLI (terminal) — full interactive setup
- Claude Desktop (Code tab) — full interactive setup
- Claude Co-work (web) — read-only mode, directs to terminal

---

## Design Philosophy

This setup flow is **tool-agnostic** and **outcome-driven**:
- Ask what tools they use, discover how to connect
- Evaluate each tool for MCP or API capabilities
- Let users select what data they want in their briefs
- Adapt to whatever combination of tools the user has

---

## Pre-Flight Check

Before starting, detect the environment and existing setup:

### 1. Environment Detection

```
if (web/co-work environment detected):
  Show current config status
  Display: "For full setup, run /design-ops:setup in Claude Code CLI"
  Exit early
```

### 2. Check Existing Configuration

1. **Check for existing config** at `~/.claude/design-ops-config.yaml`
   - If exists, check version field
   - If v1.x: "Found v1 config. Want to migrate to the new pillar-based format?"
   - If v2.x: "You have an existing config. What would you like to do?"
   - Options: `Update existing` | `Start fresh` | `Just show status`

2. **Check for legacy config** at `~/.claude/team-pulse-config.yaml`
   - If exists without design-ops-config: "Found legacy team-pulse config. Want to migrate it?"
   - Options: `Migrate to new format` | `Start fresh`

3. **Check existing skills** at `~/.claude/skills/`
   - Note any conflicting skill names
   - Plan to offer merge options if conflicts found

---

## Welcome Screen

Present the welcome message with ASCII art header:

```
██████╗ ███████╗███████╗██╗ ██████╗ ███╗   ██╗     ██████╗ ██████╗ ███████╗
██╔══██╗██╔════╝██╔════╝██║██╔════╝ ████╗  ██║    ██╔═══██╗██╔══██╗██╔════╝
██║  ██║█████╗  ███████╗██║██║  ███╗██╔██╗ ██║    ██║   ██║██████╔╝███████╗
██║  ██║██╔══╝  ╚════██║██║██║   ██║██║╚██╗██║    ██║   ██║██╔═══╝ ╚════██║
██████╔╝███████╗███████║██║╚██████╔╝██║ ╚████║    ╚██████╔╝██║     ███████║
╚═════╝ ╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚═╝     ╚══════╝

A Claude Code plugin for design companies and entrepreneurs.

Works in:
• Claude Code (terminal)
• Claude Desktop (Code tab)
• VS Code Extension

We'll set up your data sources across three pillars:

1. Operations — Calendar, tasks, communication
2. Design — Code repos, design files
3. Analytics — Web, links, social

Let's get started.
```

---

## Chapter 1: Operations

**Goal**: Connect tools for coordination, scheduling, task management

### Step 1.1: Tool Selection

Use AskUserQuestion with checkboxes:

```markdown
## Operations — What tools do you use for coordination?

Select all that apply:
```

Options:
- `Notion` — Tasks, docs, wikis
- `Google Workspace` — Calendar, email, docs
- `Linear` — Issue tracking
- `Asana` — Project management
- `Slack` — Communication
- `Other` — Free text input
- `None / Skip this section`

### Step 1.2: Tool Evaluation (Async)

**For each selected tool, spawn a background sub-agent to evaluate:**

```markdown
[Checking your tools... ━━━━━━━━━━━━━━━━━━━━ 2/3]
```

Use the Task tool with `subagent_type: Explore` and `run_in_background: true`:

```yaml
task: tool_evaluation
input:
  tools: [notion, google_workspace]
  pillar: operations
```

The sub-agent for each tool:
1. Check if MCP exists and is connected (read `~/.claude/settings.json`)
2. If MCP connected, catalog its reporting capabilities
3. If MCP not connected but available, note it needs setup
4. If no MCP, evaluate if API exists for reporting
5. If no API suitable, mark as unavailable
6. Return capability matrix

### Step 1.3: Present Findings

Once evaluation completes, show what's actually available.

**Connection Status Legend** (show at top of each pillar's findings):

```markdown
**Connection Status:**
• ✓ **Connected** — MCP working and ready
• ✓+ **Connected (API enhances)** — MCP works; optional API adds reporting depth
• ○ **Available** — Official MCP exists, ready to install
• ⚡ **API Only** — No official MCP; direct API integration
• ✗ **Unavailable** — No viable connection method
```

Show findings with clear status and source:

```markdown
## Here's what we found for your Operations tools:

┌──────────────────┬────────────┬──────────┬────────────────────────────────┐
│ Tool             │ Connection │ Source   │ Available Data                 │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Notion           │ MCP ✓      │ Official │ Pages, databases, tasks        │
│                  │            │          │ ↳ Daily: recent pages, tasks   │
│                  │            │          │ ↳ Weekly: page activity        │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Google Workspace │ MCP ✓      │ Official │ Calendar, Gmail, Drive         │
│                  │            │          │ ↳ Daily: today's events        │
│                  │            │          │ ↳ Weekly: event count          │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Slack            │ MCP ○      │ Community│ Messages, channels             │
│                  │ (install)  │          │ ↳ Unread counts, messages      │
└──────────────────┴────────────┴──────────┴────────────────────────────────┘
```

**Source indicators:**
- **Official** — Published by Anthropic or tool vendor
- **Vendor** — Published by the tool's company
- **Community** — Community-maintained package
- **—** — Direct API (no MCP)

### Step 1.4: Handle Available Tools

For tools with ○ Available status (MCP exists but not installed):

#### stdio MCPs (npm packages)

```markdown
### {Tool} — Available

An official MCP exists for {Tool}. Install it to enable automatic data access.

**Install command:**
```bash
claude mcp add {tool} -- npx -y {package}
```

What would you like to do?
- [Install now] — Run the install command
- [Skip for now] — Continue setup, add later
- [Tell me more] — What is an MCP?
```

#### HTTP MCPs (hosted services)

For tools like Figma, Supabase, and Vercel that use HTTP-based MCPs:

```markdown
### {Tool} — Available (HTTP MCP)

{Tool} provides an official HTTP MCP. Install it to enable automatic data access.

**Install command:**
```bash
{install_cmd}
```

Note: This will open a browser for authentication.

What would you like to do?
- [Install now] — Run the install command
- [Skip for now] — Continue setup, add later
- [Tell me more] — What is an HTTP MCP?
```

**HTTP MCP Install Commands:**
- Figma: `claude mcp add --transport http figma https://mcp.figma.com/mcp`
- Supabase: `claude mcp add supabase https://api.supabase.com/mcp`
- Vercel: `claude mcp add --transport http vercel https://mcp.vercel.com`

#### Detection Logic

```yaml
# Check mcp_type from known-tools.yaml
if tool.mcp_type == "http":
  # Use HTTP install pattern
  if tool.install_cmd:
    use tool.install_cmd
  else:
    use "claude mcp add --transport http {name} {mcp_url}"

elif tool.mcp_type == "stdio":
  # Use npm package install pattern
  use "claude mcp add {name} -- npx -y {mcp_package}"
```

**Options handling:**

**[Install now]:**
Run the install command and verify:
- If successful: Update status to ✓ Connected, continue
- If auth flow triggered: Guide user through OAuth (common for HTTP MCPs)
- If fails: Show error, offer to skip or get help

**[Skip for now]:**
Mark tool as `available` in config, continue to next tool.

**[Tell me more]:**
Show the MCP education content (see section below).

### Step 1.4b: Handle Community Package Tools

For tools where only a community MCP exists, show warning:

```markdown
### Community Package Notice

{Tool} uses a community-maintained MCP package.

**Package:** `{package-name}`
**Weekly downloads:** {downloads}
**Last updated:** {date}

Community packages are not officially supported. They may:
- Stop working if not maintained
- Have security or reliability issues

**Alternatives:**
- Use direct API integration instead
- Wait for official MCP release

[Use community package] [Use direct API instead] [Skip this tool]
```

### Step 1.4c: Handle API-Only Tools

For tools with ⚡ API Only status:

```markdown
### {Tool} — API Integration

No official MCP exists for {Tool}. We'll connect via their API directly.

**To get started:**
1. Visit {api_docs_url}
2. Create an API key/token
3. Enter your credentials below

This works just as well as an MCP for reporting purposes.

Enter your API token (or press Enter to skip):
> _
```

---

### "I Need Help" — MCP vs API Education

When user selects **[I need help]**, display this content:

```markdown
### Understanding MCPs and APIs

**What's an MCP?**
An MCP (Model Context Protocol) server is a wrapper around an API that's
designed specifically for AI assistants like Claude. Think of it as a
translator that makes APIs "speak Claude's language."

**Why do both exist?**
┌─────────────────────────────────────────────────────────────────────┐
│  Your Tool (Notion, GitHub, etc.)                                   │
│       ↓                                                             │
│  Raw API — Full access to everything the tool offers                │
│       ↓                                                             │
│  MCP Server — Simplified subset optimized for AI conversations      │
│       ↓                                                             │
│  Claude — Uses MCP to access your tools                             │
└─────────────────────────────────────────────────────────────────────┘

**The trade-off:**
• **MCPs** are easier to set up and work great for basic tasks
• **Raw APIs** often provide more data, batch operations, and advanced queries

**Example with Notion:**
| Capability              | Notion MCP | Notion API |
|-------------------------|------------|------------|
| Search pages            | ✓          | ✓          |
| Read page content       | ✓          | ✓          |
| Create/edit pages       | ✓          | ✓          |
| Query databases         | Limited    | ✓ Full     |
| Batch operations        | ✗          | ✓          |
| Activity history        | ✗          | ✓          |
| User analytics          | ✗          | ✓          |

**What DESIGN-OPS does:**
For tools where the MCP is limited, we can:
1. Help you set up direct API access for richer reporting
2. Create a custom MCP wrapper that exposes more capabilities
3. Use both together — MCP for quick tasks, API for dashboards

**Bottom line:**
Start with the MCP. If you want deeper analytics or find it limiting,
we'll help you add API access for specific features.
```

After showing education content, return to the connection options.

---

### Step 1.5: Progressive Disclosure for API Enhancements

For tools where MCP is connected but API offers richer reporting data, use progressive disclosure:

**Pattern: Soft offer after MCP connection confirmed**

```markdown
### {Tool} — Connected via MCP ✓

Your {Tool} MCP is working. Claude can:
• Search and read your pages
• Create and edit content
• Access your databases

**Optional: Enhance with API** (✓+ status)

The {Tool} API can provide additional data for richer reporting:
• Activity history — Who edited what, when
• Batch queries — Fetch data across many pages at once
• Database aggregations — Task counts, status summaries

┌─────────────────────────────────────────────────────────────────────┐
│  You're NOT blocked — MCP-only is always valid!                     │
│                                                                     │
│  The API is an optional enhancement that unlocks richer dashboard   │
│  data. You can add it now or anytime later.                         │
└─────────────────────────────────────────────────────────────────────┘

What would you like to do?
- [Continue with MCP only] — Works great for most use cases ← default
- [Add API for richer dashboards] — Optional enhancement
- [Tell me more] — What's the difference?
```

**Key principle:** Never block progress. MCP-only is always valid.
The API is an *optional enhancement* for users who want deeper analytics.

**Options handling:**

**[Continue with MCP only]** (default):
Mark tool as connected via MCP, proceed to next tool.

**[Tell me more]:**
Show the MCP vs API education content from "I need help" section.

**[Add API for better dashboards]:**

```markdown
### Adding {Tool} API Access

You'll keep your MCP connection AND add API access for reporting.

**To get a {Tool} API token:**
{Tool-specific instructions - example for Notion:}
1. Go to notion.so/my-integrations
2. Click "New integration"
3. Name it "DESIGN-OPS"
4. Select your workspace
5. Under "Capabilities", enable:
   - Read content ✓
   - Read user information ✓ (for activity tracking)
6. Copy the "Internal Integration Secret"

**Important:** You'll also need to share specific pages/databases
with your integration for it to access them.

Enter your token (or press Enter to skip for now):
> _
```

**Apply this pattern to tools with MCP + API options:**
- **Notion** — MCP basic, API for activity/batch queries
- **GitHub** — MCP good, API for advanced repo analytics
- **Figma** — MCP code-focused, API for team/version reporting

---

### Step 1.6: Outcome Mapping

Based on available capabilities, ask what they want in their briefs:

```markdown
## Based on your connected tools, here's what we can include:

**Daily Brief (Operations):**
☑ Today's calendar events (from Google Workspace)
☑ Tasks due today (from Notion)
☐ Unread emails (from Google Workspace)
☐ Unread Slack messages (requires Slack setup)

**Weekly Recap (Operations):**
☑ Week overview - events attended (from Google Workspace)
☑ Tasks completed this week (from Notion)
☐ Team activity summary (requires Slack)

[Confirm selections]
```

Options are pre-checked based on connected tools. Disabled options show why they're unavailable.

---

### Step 1.7: Operations Summary & Confirmation

Before moving to the next pillar, confirm completion:

```markdown
## Operations Summary

You've configured:
✓ Notion (MCP) — tasks, docs
✓ Google Workspace (MCP) — calendar, email
⚠ Slack — skipped (can add later)

**Before we move on:**
- [Add another Operations tool]
- [Continue to Design pillar →]
```

**Pattern for every tool addition within a pillar:**
```markdown
✓ {Tool} added to Operations

[Add another Operations tool] | [Continue →]
```

If user selects "Add another Operations tool", return to Step 1.1 tool selection.
If user selects "Continue", proceed to Design pillar.

---

## Chapter 2: Design

**Goal**: Connect tools for creative and development work

### Step 2.1: Tool Selection

```markdown
## Design — What tools do you use for design & code?

**Code:**
```

Options:
- `GitHub` — Repos, PRs, issues
- `GitLab`
- `Bitbucket`
- `Other` — Free text input

```markdown
**Creative:**
```

Options:
- `Figma` — Design files
- `Sketch`
- `Adobe XD`
- `Other` — Free text input
- `None / Skip this section`

### Step 2.2: Tool Evaluation

Same async evaluation pattern as Operations.

### Step 2.3: Present Findings

```markdown
## Here's what we found for your Design tools:

┌──────────────────┬────────────┬──────────┬────────────────────────────────┐
│ Tool             │ Connection │ Source   │ Available Data                 │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ GitHub           │ MCP ✓      │ Official │ Repos, commits, PRs, issues    │
│                  │            │          │ ↳ Daily: recent commits, PRs   │
│                  │            │          │ ↳ Weekly: team contributions   │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Figma            │ API ⚡     │ —        │ Files, versions, comments      │
│                  │            │          │ ↳ Daily: files edited, users   │
│                  │            │          │ ↳ Weekly: design versions      │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ GitLab           │ MCP ○      │ Community│ Repos, commits, MRs            │
│                  │ (install)  │ ⚠        │ ↳ Verify package first         │
└──────────────────┴────────────┴──────────┴────────────────────────────────┘
```

**Note:** Figma's official MCP is code-focused (not for reporting). We use the API directly for team/version reporting.

### Step 2.4: Figma Handling

Figma now has an official HTTP MCP that provides comprehensive design access:

```markdown
### Figma — Available (HTTP MCP)

Figma provides an official MCP with full design access.

**Install command:**
```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp
```

This will:
1. Open a browser for Figma authentication
2. Request permission to access your files
3. Enable design context, screenshots, and Code Connect

What would you like to do?
- [Install now] — Run the install command
- [Skip for now] — Continue setup, add later
```

**Capabilities via Figma MCP:**
- Get design context (code, screenshots, metadata)
- Access component libraries and design systems
- Generate diagrams and capture web pages
- Search design system assets
- Code Connect mapping

**Note:** The HTTP MCP requires browser authentication. After install,
you can track specific projects in your config.

### Step 2.5: GitHub Project Selection

If GitHub MCP connected:

```markdown
### GitHub Configuration

GitHub is connected via MCP. Which repositories should I track?
```

Options:
- Show recently accessed repos if discoverable
- Allow manual entry: "Enter repo names (owner/repo format)"
- Option: "Track all repos I have access to"

### Step 2.6: Outcome Mapping

```markdown
## Based on your Design tools, here's what we can include:

**Daily (Design):**
☑ Recent commits (from GitHub) — last 24h
☑ Open PRs needing review (from GitHub)
☑ Figma files edited today (from Figma API)
☐ Who's working on what (requires team tracking setup)

**Weekly (Design):**
☑ Team contribution summary (commits by person)
☑ Design versions created (from Figma)
☑ PR/merge activity (from GitHub)

[Confirm selections]
```

---

### Step 2.7: Design Summary & Confirmation

Before moving to the next pillar, confirm completion:

```markdown
## Design Summary

You've configured:
✓ GitHub (MCP) — repos, PRs, commits
✓ Figma (API) — design files, versions
⚠ Sketch — not connected (can add later)

**Before we move on:**
- [Add another Design tool]
- [Continue to Analytics pillar →]
```

**Pattern for every tool addition within a pillar:**
```markdown
✓ {Tool} added to Design

[Add another Design tool] | [Continue →]
```

If user selects "Add another Design tool", return to Step 2.1 tool selection.
If user selects "Continue", proceed to Analytics pillar.

---

## Chapter 3: Analytics

**Goal**: Connect tools for metrics and insights

### Step 3.1: Tool Selection — Restructured by Purpose

Replace the single mixed "Which analytics tools?" with purpose-based subcategories.
Each subcategory gets its own selection and confirmation before advancing.

**Show category navigation:**

```markdown
## Analytics — Let's set up your metrics by category

We'll configure your analytics tools in 5 categories:
1. Web Analytics (visitor/session data)
2. Social Analytics (audience/engagement)
3. Content Analytics (newsletter/blog)
4. Link Analytics (click tracking)
5. Database/Product Analytics

Let's start with Web Analytics.
```

---

### Step 3.1a: Web Analytics

```markdown
### Web Analytics (visitor/session data)
What do you use to track website traffic?

- [ ] Google Analytics (GA4) — Sessions, pageviews, events
- [ ] Vercel Analytics — Vercel-hosted site metrics
- [ ] Plausible — Privacy-focused analytics
- [ ] PostHog — Product analytics
- [ ] Other (specify)
- [ ] None / Skip web analytics

[Continue →]
```

**After selection, show confirmation:**
```markdown
✓ Web Analytics configured: Google Analytics, Vercel Analytics

Want to add more web analytics tools, or continue to social?
- [Add more web tools]
- [Continue to Social Analytics →]
```

---

### Step 3.1b: Social Analytics

```markdown
### Social Analytics (audience/engagement)
What platforms do you track for social metrics?

- [ ] Instagram — Followers, engagement (Business accounts)
- [ ] Twitter/X — Followers, impressions
- [ ] LinkedIn — Connections, post views
- [ ] YouTube — Subscribers, views
- [ ] TikTok — Followers, views
- [ ] Other (specify)
- [ ] None / Skip social analytics

[Continue →]
```

**Confirmation:**
```markdown
✓ Social Analytics configured: Instagram

Want to add more social platforms, or continue to content?
- [Add more social tools]
- [Continue to Content Analytics →]
```

---

### Step 3.1c: Content Analytics

```markdown
### Content Analytics (newsletter/blog)
What do you use for content performance?

- [ ] Substack — Subscribers, opens, post views
- [ ] Beehiiv — Newsletter metrics
- [ ] ConvertKit — Email metrics
- [ ] Ghost — Blog analytics
- [ ] Other (specify)
- [ ] None / Skip content analytics

[Continue →]
```

**Confirmation:**
```markdown
✓ Content Analytics configured: Substack

Want to add more content tools, or continue to links?
- [Add more content tools]
- [Continue to Link Analytics →]
```

---

### Step 3.1d: Link Analytics

```markdown
### Link Analytics (click tracking)
What do you use for link tracking?

- [ ] Dub.co — Link clicks, referrers
- [ ] Bitly — Short link analytics
- [ ] Other (specify)
- [ ] None / Skip link analytics

[Continue →]
```

**Confirmation:**
```markdown
✓ Link Analytics configured: Dub.co

Want to add more link tools, or continue to database?
- [Add more link tools]
- [Continue to Database Analytics →]
```

---

### Step 3.1e: Database/Product Analytics

```markdown
### Database/Product Analytics
What do you use for database or product metrics?

- [ ] Supabase — Database metrics, user counts
- [ ] Firebase — App analytics
- [ ] Amplitude — Product analytics
- [ ] Mixpanel — User analytics
- [ ] Other (specify)
- [ ] None / Skip database analytics

[Continue →]
```

**Confirmation:**
```markdown
✓ Database Analytics configured: Supabase

Want to add more database/product tools, or continue?
- [Add more database tools]
- [Continue to tool evaluation →]
```

---

### Step 3.2: Tool Evaluation

Same async pattern as Operations and Design. Analytics tools often need custom wrappers.

**For each selected tool, evaluate:**
1. Check if MCP exists and is connected
2. If MCP connected, catalog its reporting capabilities
3. If no MCP, evaluate if API exists for reporting
4. For tools with limited MCPs, note API upgrade options

### Step 3.3: Present Findings

```markdown
## Here's what we found for your Analytics tools:

┌──────────────────┬────────────┬──────────┬────────────────────────────────┐
│ Tool             │ Connection │ Source   │ Available Data                 │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Google Analytics │ MCP ✓      │ Official │ Pageviews, sessions, events    │
│                  │            │          │ ↳ Daily: session count, pages  │
│                  │            │          │ ↳ Weekly: traffic trends       │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Dub.co           │ MCP ✓      │ Community│ Link clicks, referrers, geo    │
│                  │            │          │ ↳ Daily: click counts          │
│                  │            │          │ ↳ Weekly: top links            │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Substack         │ API ⚡     │ —        │ Subscribers, posts, emails     │
│                  │            │          │ ↳ Needs custom wrapper         │
│                  │            │          │ ↳ Use /mcp-builder to create   │
├──────────────────┼────────────┼──────────┼────────────────────────────────┤
│ Instagram        │ ✗          │ —        │ Unavailable                    │
│                  │            │          │ ↳ Business accounts only       │
│                  │            │          │ ↳ Requires Meta approval       │
└──────────────────┴────────────┴──────────┴────────────────────────────────┘
```

### Step 3.4: Handle Custom Wrapper Creation

For tools that need custom wrappers (like Substack):

```markdown
### Substack

Substack has an API that supports reporting data.

We can create a custom MCP wrapper to pull:
- Subscriber count and growth
- Post view counts
- Email open rates

Would you like to set this up now?
```

Options:
- `Yes, guide me through it` — Trigger `mcp-builder` skill with Substack API context
- `Skip for now` — Mark as skipped, can add later

If user chooses to create wrapper:
1. Invoke `/mcp-builder` skill with Substack context
2. Guide through API token creation
3. Scaffold wrapper using mcp-builder
4. User registers wrapper in Claude settings
5. Continue setup with wrapper connected

### Step 3.5: Outcome Mapping

```markdown
## Based on your Analytics tools, here's what we can include:

**Daily (Analytics):**
☑ Page views today (from GA4)
☑ Link click counts (from Dub.co)
☐ New subscribers (requires Substack wrapper)

**Weekly (Analytics):**
☑ Traffic trends (from GA4)
☑ Top performing links (from Dub.co)
☐ Audience growth (requires Substack wrapper)
☐ Social engagement (requires Instagram setup)

Note: Some options are disabled because those tools aren't connected.
You can add them later with `/design-ops:configure analytics`

[Confirm selections]
```

---

### Step 3.6: Analytics Summary & Confirmation

Before moving to Skills selection, confirm completion:

```markdown
## Analytics Summary

You've configured across 5 categories:

**Web Analytics:**
✓ Google Analytics (MCP) — sessions, pageviews

**Social Analytics:**
✓ Instagram (API) — followers, engagement

**Content Analytics:**
⚠ Substack — skipped (can add later)

**Link Analytics:**
✓ Dub.co (MCP) — link clicks, referrers

**Database/Product:**
⚠ None configured

**Before we move on:**
- [Add more Analytics tools]
- [Continue to Skills Library →]
```

**Pattern for every tool/category addition:**
```markdown
✓ {Tool} added to {Category}

[Add more to this category] | [Continue to next category →]
```

If user selects "Add more", return to the appropriate category selection.
If user selects "Continue", proceed to Skills Library.

---

## Chapter 4: Skills Library

**Goal**: Select which utility skills to enable (optional, all available by default)

After completing pillar configuration, present the skills library:

```markdown
## Available Skills

DESIGN-OPS includes a library of utility skills. Select the ones you want to enable:

**Design Quality** (NEW)
☐ design-audit        — Automated design system compliance
☐ a11y-audit          — Accessibility compliance check (WCAG A/AA/AAA)

**Research & Inspiration** (NEW)
☐ competitor-scan     — Competitive design analysis
☐ mood-board          — Curated design inspiration
☐ variation-sprint    — Generate design variations

**Content Creation** (NEW)
☐ copy-variants       — Generate and A/B test copy variations
☐ content-brief       — Create content outlines for articles, blogs, case studies

**Development** (NEW)
☐ research-summary    — Synthesize research into actionable insights

**Auto-Activating Skills** (enabled by default)
☑ brand-guidelines    — Brand identity enforcement
☑ frontend-design     — UI component patterns
☑ design-system-quality — Design compliance review
☑ verification-before-completion — Quality gates
☑ systematic-debugging — 4-phase root cause analysis

Note: Auto-activating skills work automatically based on context.
The selectable skills above are invoked via `/design-ops:library`.

[Enable selected] [Enable all] [Skip for now]
```

Store selections in config:

```yaml
skills:
  design_quality:
    - design_audit
    - a11y_audit
  research:
    - competitor_scan
    - mood_board
    - variation_sprint
  content:
    - copy_variants
    - content_brief
  development:
    - research_summary
  auto_activating:
    - brand_guidelines
    - frontend_design
    - design_system_quality
    - verification_before_completion
    - systematic_debugging
```

---

## Team Member Mapping (Optional)

After skills selection:

```markdown
## Team Configuration (Optional)

Want cleaner output with real names instead of handles?

I can map:
- Figma handles → friendly names
- GitHub usernames → friendly names
- Platform handles → real names

This makes reports more readable.
```

Options:
- `Set up team members`
- `Skip — use handles as-is`

**If setting up team:**

```markdown
Add team members one at a time.

**Your info first:**
- Display name: [input]
- Figma handle (if using Figma): [input or skip]
- GitHub username (if using GitHub): [input or skip]
```

Loop: "Add another team member?" → Yes/Done

---

## Final Synthesis

Generate personalized configuration:

```markdown
## Your Setup Summary

### Connected Tools

**Operations:**
  ✓ Notion (MCP) — tasks, docs
  ✓ Google Workspace (MCP) — calendar, email

**Design:**
  ✓ GitHub (MCP) — repos, PRs
  ✓ Figma (API) — design files

**Analytics:**
  ✓ Google Analytics (MCP) — web traffic
  ✓ Dub.co (MCP) — link clicks
  ⚠ Substack — skipped (no wrapper created)

### Your Daily Brief will include:
- Today's calendar events
- Tasks due today
- Recent commits from your repos
- Figma file updates
- Page views and link clicks

### Your Weekly Recap will include:
- Week overview
- Team contribution summary
- Traffic trends
- Top performing content

### Commands enabled:
- `/design-ops:daily-brief` — Morning overview
- `/design-ops:weekly-recap` — End of week summary
- `/design-ops:team-pulse` — Team activity dashboard
- `/design-ops:analytics` — Metrics summary

[Save Configuration]
```

---

## Write Configuration

### Backup Existing

```bash
if [ -f ~/.claude/design-ops-config.yaml ]; then
  cp ~/.claude/design-ops-config.yaml ~/.claude/design-ops-config.yaml.bak
fi
```

### Generate Config

Write to `~/.claude/design-ops-config.yaml` using the v2 schema:

```yaml
version: "2.0"
created: "{ISO_DATE}"
updated: "{ISO_DATE}"

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
      daily: [calendar_events, tasks_due]
      weekly: [week_overview, tasks_completed]

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
            weekly: [traffic_trends]
      - id: substack
        type: unavailable
        status: skipped
        reason: "No wrapper created"
    outcomes:
      daily: [pageviews, link_clicks]
      weekly: [traffic_trends, top_links]

team:
  members:
    - name: "Jordan Smith"
      handles:
        figma: "jordan.smith"
        github: "jordansmith"

enabled_commands:
  - daily_brief
  - weekly_recap
  - team_pulse
  - analytics

preferences:
  activity_window_hours: 24
  show_prs: true
  show_commits: true
  show_versions: true
```

---

## Verification Tests

Run `/design-ops:test` automatically:

```markdown
## Verifying Setup

Running verification tests...
```

Display checklist as tests complete:

```markdown
**Configuration:**
- [x] Config file created at ~/.claude/design-ops-config.yaml
- [x] Config syntax valid (v2.0)

**Operations Pillar:**
- [x] Notion MCP: Connected, can search pages
- [x] Google Workspace MCP: Connected, can list events

**Design Pillar:**
- [x] GitHub MCP: Connected, can list repos
- [x] Figma API: Token valid, can fetch files

**Analytics Pillar:**
- [x] Google Analytics MCP: Connected
- [~] Substack: Skipped (can add later)

**Skills:**
- [x] All auto-activating skills loaded
- [x] No naming conflicts detected
```

---

## Completion Summary

```markdown
## ✓ Setup complete!

DESIGN-OPS is configured and ready.

### Next steps:
• Run `/design-ops:status` to verify your configuration
• Run `/design-ops:dashboard` for today's overview
• Run `/design-ops:library` to explore utility commands

### Your Dashboard Commands
- `/design-ops:dashboard` — All pillars, daily (default)
- `/design-ops:dashboard ops weekly` — Operations, weekly
- `/design-ops:dashboard design` — Design pillar focus
- `/design-ops:dashboard analytics ytd` — Analytics, year-to-date

### Legacy Aliases (still work)
- `/design-ops:daily-brief` — Same as `/design-ops:dashboard daily`
- `/design-ops:weekly-recap` — Same as `/design-ops:dashboard weekly`
- `/design-ops:team-pulse` — Same as `/design-ops:dashboard design daily`

### Utility Library
Run `/design-ops:library` to browse 14 utility commands:
- **logistics/** — meeting-brief, meeting-recap, kickoff-prep
- **content/** — social-post, copy-variants, content-brief
- **development/** — site-analysis, devils-advocate, research-summary
- **design/** — design-audit, a11y-audit, mood-board, competitor-scan, variation-sprint

### Auto-Activating Skills
These work automatically when relevant — no command needed:
- **brand-guidelines** — Triggers on brand/color/voice mentions
- **frontend-design** — Triggers on UI/component work
- **design-system-quality** — Triggers on design system reviews
- **verification-before-completion** — Triggers when claiming "done"
- **systematic-debugging** — Triggers on debugging/error investigation

### Configuration
- Config file: `~/.claude/design-ops-config.yaml`
- View status: `/design-ops:status` — Quick overview of what's configured
- Diagnose issues: `/design-ops:test` — Deep diagnostics when troubleshooting
- Update settings: `/design-ops:configure`

Something not working? Run `/design-ops:test` to diagnose.
```

---

## Tool Evaluation Flow Reference

For **every tool** the user selects, the `tool-evaluator` skill invokes `mcp-discovery`:

```
┌─────────────────────────────────────────────────────────────┐
│  User selects: "Substack"                                   │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  Step 1: Check if already installed                         │
│  Read ~/.claude/settings.json mcpServers                    │
│  If found and responding → status: connected                │
└─────────────────────────────────────────────────────────────┘
                          │ not installed
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  Step 2: Invoke mcp-discovery skill                         │
│  - Check known-tools.yaml (fast path)                       │
│  - Search npm for official/vendor MCPs                      │
│  - Evaluate community packages (quality metrics)            │
│  - Find API documentation                                   │
│                                                             │
│  Returns: mcp_source, mcp_confidence, recommendation        │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  Step 3: Based on discovery recommendation                  │
│                                                             │
│  mcp (high confidence):                                     │
│    → Offer to install, status: available (○)                │
│                                                             │
│  mcp (medium confidence - community):                       │
│    → Show warning, offer install or API alternative         │
│                                                             │
│  api:                                                       │
│    → Guide API token setup, status: api_only (⚡)           │
│                                                             │
│  unavailable:                                               │
│    → Mark unavailable (✗), suggest alternatives             │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  Step 4: For API-only tools with wrapper option             │
│  Walk user through creating a custom MCP wrapper:           │
│  1. Gather API credentials                                  │
│  2. Use /mcp-builder skill to scaffold wrapper              │
│  3. Test the wrapper                                        │
│  4. Register in Claude settings                             │
│                                                             │
│  Or: User skips, tool marked as "skipped"                   │
└─────────────────────────────────────────────────────────────┘
```

See `skills/mcp-discovery/SKILL.md` for the full discovery flow.

---

## Connection Types Summary

| Type | Description | How to Detect | Setup Process |
|------|-------------|---------------|---------------|
| **MCP** | Native MCP server | In `~/.claude/settings.json` | Guide MCP installation |
| **API** | Direct API (plugin calls) | Token in config or env | Guide token creation |
| **Custom Wrapper** | User-created MCP | User registers after creation | `/mcp-builder` skill |
| **Unavailable** | No API/MCP support | API evaluation fails | Inform user, suggest alternatives |

---

## Error Handling

**If ~/.claude directory doesn't exist:**
```bash
mkdir -p ~/.claude
```

**If write fails:**
```markdown
Couldn't write config file. Check permissions for ~/.claude/

Manual fix:
1. Run: mkdir -p ~/.claude
2. Run: chmod 755 ~/.claude
3. Re-run /design-ops:setup

Still stuck? See: references/troubleshooting.md
```

**If API validation fails:**
```markdown
API check failed for {service}.

This might be:
- Network issue (try again)
- Invalid credentials (re-enter)
- Service outage (check status page)

Continue setup without {service}? You can add it later with /design-ops:configure.
```

---

## Re-Running Setup

If user runs `/design-ops:setup` with existing config:

1. Show current config summary with pillar breakdown
2. Ask what to change:
   - "Update a pillar (Operations, Design, Analytics)"
   - "Add new tools"
   - "Modify team members"
   - "Start completely fresh"
3. Only modify selected sections
4. Run verification tests

---

## Non-Destructive Guarantees

1. **Never overwrite** existing files without asking
2. **Always backup** before changes: `*.yaml.bak`
3. **Show diff** of proposed config changes before writing
4. **Merge** new settings with existing (don't replace wholesale)
5. **Namespace** all commands with `do:` to avoid conflicts

---

*Version: 2.0*
