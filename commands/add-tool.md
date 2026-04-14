# /do:add-tool

Guided setup for adding a new tool to DESIGN-OPS. Uses the evaluation cascade to determine the best connection method.

## Trigger

User runs `/do:add-tool` or `/do:add-tool {toolname}` to connect a new tool.

---

## Workflow Overview

```
User wants to add a tool
        │
        ▼
┌───────────────────────┐
│ 1. Identify the tool  │ ← Which tool? Which pillar?
└───────────────────────┘
        │
        ▼
┌───────────────────────┐
│ 2. Evaluate the tool  │ ← Check MCP → Check API → Assess viability
└───────────────────────┘
        │
        ▼
┌───────────────────────┐
│ 3. Guide connection   │ ← Based on evaluation results
└───────────────────────┘
        │
        ▼
┌───────────────────────┐
│ 4. Update config      │ ← Add to appropriate pillar
└───────────────────────┘
```

---

## Step 1: Identify the Tool

### If tool specified in command

```
/do:add-tool substack
```

Parse the tool name and proceed to evaluation.

### If no tool specified

Present options organized by pillar:

```markdown
## Add a New Tool

What would you like to connect?

**Operations (coordination, scheduling, tasks):**
1. Notion — Tasks, docs, wikis
2. Google Workspace — Calendar, email, docs
3. Linear — Issue tracking
4. Asana — Project management
5. Slack — Communication

**Design (code, creative work):**
6. GitHub — Repos, PRs, issues
7. GitLab — Repos, merge requests
8. Figma — Design files
9. Bitbucket — Repos, PRs

**Analytics (metrics, insights):**
10. Google Analytics (GA4) — Web traffic
11. Dub.co — Link analytics
12. Plausible — Privacy-focused analytics
13. Substack — Newsletter metrics
14. Bitly — Link tracking

**Other:**
15. Custom tool — I'll specify the name

Which one? (enter number or name)
```

---

## Step 2: Evaluate the Tool

Use the tool-evaluator skill to assess the tool:

```markdown
Evaluating {tool_name}...
```

### Evaluation Cascade

1. **Check for MCP**
   - Search `~/.claude/settings.json` for existing MCP
   - Check `references/tool-registry.md` for known MCPs
   - Determine if MCP supports reporting data we need

2. **If MCP found:**
   - Check if already connected
   - If not connected, guide MCP installation
   - Catalog capabilities

3. **If no MCP, check API:**
   - Consult tool registry for API information
   - Assess if API supports reporting (daily/weekly data)
   - Determine auth requirements

4. **Determine connection type:**
   - `mcp` — MCP available
   - `api` — Direct API integration
   - `custom_wrapper` — API needs MCP wrapper
   - `unavailable` — No viable connection

---

## Step 3: Guide Connection

### Connection Type: MCP (available, not connected)

```markdown
## {Tool} — MCP Available

{Tool} has an official MCP that provides reporting data.

**Installation:**
```bash
claude mcp add {mcp-name} -- npx -y {package-name}
```

**Authentication:**
{Auth instructions based on tool type}

Run the command above, then say "done" when complete.
```

### Connection Type: MCP (already connected)

```markdown
## {Tool} — Already Connected

{Tool} MCP is already installed and connected.

**Capabilities detected:**
- {capability 1}
- {capability 2}
- {capability 3}

Would you like to:
1. Configure which data to include in briefs
2. Set up project/repo tracking
3. Skip — tool is ready to use
```

### Connection Type: API (direct)

```markdown
## {Tool} — API Integration

{Tool} doesn't have an MCP for reporting, but has a good API.

**To connect:**
1. Get your API token from: {token_url}
2. {Specific token generation instructions}
3. Enter your token below:

Token: [____________]
```

After token entry, validate and store.

### Connection Type: Custom Wrapper

```markdown
## {Tool} — Needs Custom Wrapper

{Tool} has an API that can provide reporting data, but needs
an MCP wrapper to integrate with DESIGN-OPS.

**What this means:**
- We'll create a simple MCP server that wraps {Tool}'s API
- This takes a few minutes to set up
- Once created, it works like any other MCP

Would you like to create the wrapper now?

[Yes, guide me through it] [Skip for now]
```

If yes, invoke `/mcp-builder` skill with tool context.

### Connection Type: Unavailable

```markdown
## {Tool} — Not Available

Unfortunately, {Tool} can't be connected at this time.

**Reason:** {specific_reason}

{If alternatives exist:}
**Alternatives you might consider:**
- {Alternative 1} — {brief description}
- {Alternative 2} — {brief description}

Would you like to add one of these instead?
```

---

## Step 4: Configure the Tool

### For tools with project/repo tracking

```markdown
## Configure {Tool} Tracking

Which {items} should I track for activity reports?

{List of detected items if available}

Or enter manually:
- {format instructions}
```

### Determine pillar placement

If not obvious from tool type:

```markdown
## Where should {Tool} appear in reports?

1. **Operations** — Include in task/scheduling sections
2. **Design** — Include in code/creative sections
3. **Analytics** — Include in metrics sections
```

### Select outcomes

```markdown
## What data from {Tool} do you want in your briefs?

**Daily:**
☐ {outcome 1} — {description}
☐ {outcome 2} — {description}

**Weekly:**
☐ {outcome 3} — {description}
☐ {outcome 4} — {description}

[Confirm selections]
```

---

## Step 5: Update Configuration

Write changes to `~/.claude/do-config.yaml`:

```yaml
pillars:
  {pillar}:
    enabled: true
    tools:
      # ... existing tools ...
      - id: {tool_id}
        type: {connection_type}
        mcp_name: "{mcp_name}"  # if MCP
        auth:                    # if API
          token_env: {ENV_VAR}
        status: connected
        capabilities:
          data_types: [{types}]
          reporting:
            daily: [{daily_caps}]
            weekly: [{weekly_caps}]
        {tracking_config}        # if applicable
    outcomes:
      daily: [{updated_daily}]
      weekly: [{updated_weekly}]
```

---

## Step 6: Verification

Test the new connection:

```markdown
## Verifying Connection

Testing {Tool}...

- [x] Authentication valid
- [x] Can fetch data
- [x] Reporting endpoints accessible

{Tool} is connected and ready!

**What's now available:**
- {capability 1} in daily briefs
- {capability 2} in weekly recaps

**Commands affected:**
- `/do:daily-brief` — now includes {tool} data
- `/do:weekly-recap` — now includes {tool} data
```

---

## Quick Reference: Common Tools

### OAuth-Based (Browser Auth)

| Tool | Command |
|------|---------|
| Google Calendar | `claude mcp add google-calendar -- npx -y @anthropic/mcp-google-calendar` |
| Gmail | `claude mcp add gmail -- npx -y @anthropic/mcp-gmail` |
| GitHub | `claude mcp add github -- npx -y @anthropic/mcp-github` |

### API Key-Based

| Tool | Auth Location |
|------|---------------|
| Notion | notion.so/my-integrations |
| Figma | figma.com/developers/api#access-tokens |
| Linear | linear.app/settings/api |
| Dub.co | dub.co/settings/tokens |

### Need Custom Wrapper

| Tool | API Docs |
|------|----------|
| Substack | substack.com/api (limited docs) |
| Plausible | plausible.io/docs/stats-api |
| Bitly | dev.bitly.com |

### Unavailable

| Tool | Reason |
|------|--------|
| Instagram | Business accounts only, complex approval |
| Twitter/X | Paid API tiers only |
| LinkedIn | Restricted to company pages |

---

## Error Handling

### MCP Installation Failed

```markdown
MCP installation failed.

**Common fixes:**
1. Ensure Node.js is installed: `node --version`
2. Try running with sudo: `sudo claude mcp add ...`
3. Check npm permissions: `npm config get prefix`

Try again, or skip this tool for now?
```

### Token Validation Failed

```markdown
Token validation failed for {Tool}.

**This might be:**
- Token has expired — regenerate at {url}
- Wrong token scope — needs "{required_scope}"
- Copy/paste error — try entering again

Enter a new token, or skip for now?
```

### API Unavailable

```markdown
Couldn't reach {Tool}'s API.

**This might be:**
- Network issue — check your connection
- Service outage — check {status_page}
- Firewall blocking — try a different network

Try again later, or skip for now?
```

---

## Re-Adding a Skipped Tool

If user previously skipped a tool:

```markdown
## {Tool} — Previously Skipped

{Tool} was skipped during setup.

Current status: {reason_for_skip}

Would you like to:
1. Try connecting now
2. Keep it skipped
```

---

## Integration with /do:configure

This command can also be triggered from `/do:configure`:

```
/do:configure → "Add new tools" → /do:add-tool flow
```

Or for a specific pillar:

```
/do:configure analytics → "Add new tool" → /do:add-tool (filtered to analytics tools)
```

---

*Version: 2.0*
