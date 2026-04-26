# /design-ops:validate

Re-validate all configured tool connections. Use this to check tool status after setup, after changing API keys, or when troubleshooting connection problems.

## Trigger

```bash
/design-ops:validate [--fix]
```

## Parameters

| Flag | Description |
|------|-------------|
| (none) | Check all tools and report status |
| `--fix` | Check tools and guide through fixing failures interactively |

---

## Use Cases

1. **After setup** — Double-check everything works before running dashboard
2. **After changing credentials** — Verify new API keys or OAuth tokens work
3. **Before running dashboard** — Catch issues early instead of discovering errors in dashboard
4. **When troubleshooting** — Diagnose which tools are failing and why
5. **After environment changes** — Verify tools still work after system updates or config changes

---

## Workflow

### Step 1: Load Configuration

1. **Read** `~/.claude/design-ops-config.yaml`
2. **Extract** all configured tools across all pillars
3. **Skip** tools marked as `status: skipped`

### Step 2: Validate Each Tool

For each tool (not skipped):

#### MCP Tools (stdio)

1. **Check** MCP is registered in `~/.claude/settings.json`
2. **Make test call** appropriate for the tool:
   - **Notion:** `mcp__notion__API-get-self`
   - **GitHub:** `mcp__github__search_repositories` with simple query
   - **Linear:** Query for current user
3. **Record** result: success, error message, response time

#### MCP Tools (HTTP/OAuth)

1. **Check** MCP is registered
2. **Make test call** that requires authentication:
   - **Google Workspace:** `mcp__google-workspace__list_calendars`
   - **Figma:** `mcp__figma__whoami`
   - **Supabase:** List databases or tables
3. **Detect** OAuth errors:
   - If OAuth prompt triggered → status: `oauth_pending`
   - If auth successful → status: `connected`
   - If token expired → status: `oauth_expired`

#### API Tools (direct)

1. **Check** environment variable is set:
   - **Notion:** `NOTION_API_KEY`
   - **Figma (legacy):** `FIGMA_API_TOKEN`
   - **GA4:** `GA4_PROPERTY_ID`
2. **Make test API call** to validate token
3. **Record** result: valid, invalid, expired, missing

### Step 3: Generate Report

```markdown
## DESIGN-OPS Tool Validation

Checked {count} tools at {timestamp}

┌───────────────────┬──────────┬─────────────────────────────────────┐
│ Tool              │ Status   │ Issue / Notes                       │
├───────────────────┼──────────┼─────────────────────────────────────┤
│ GitHub            │ ✓ Ready  │ MCP responding (245ms)              │
│ Notion            │ ✗ Failed │ NOTION_API_KEY not set              │
│ Google Workspace  │ ✓ Ready  │ OAuth valid, expires in 12 days     │
│ Figma             │ ⚠ OAuth  │ Token expired, re-auth required     │
│ Dub.co            │ ✓ Ready  │ MCP responding (312ms)              │
│ Supabase          │ — Skipped│ —                                   │
│ Vercel            │ ✗ Failed │ 403 Forbidden (scope insufficient)  │
│ Google Analytics  │ ✗ Failed │ GA4_PROPERTY_ID not configured      │
└───────────────────┴──────────┴─────────────────────────────────────┘

**Summary:**
- ✓ Ready: 3 tools
- ✗ Failed: 3 tools
- ⚠ Needs attention: 1 tool
- — Skipped: 1 tool

{If any failures:}
**3 tools need attention.**

Run `/design-ops:validate --fix` to fix issues interactively.

{If all ready:}
**All tools are working!**

Run `/design-ops:dashboard` to see your data.
```

---

## --fix Mode

When `--fix` flag is provided, guide user through fixing each failure.

### Fix Flow

For each failed tool, in order of priority (P1 → P2 → P3):

**Priority order:**
1. OAuth pending/expired (quick to fix)
2. Environment variable missing
3. Token invalid/expired
4. Configuration issues
5. MCP not installed

```markdown
## Fixing Tool Issues

Let's fix {count} tools that need attention.

---

### 1/3: Figma — OAuth Expired

Your Figma OAuth token has expired.

**To fix:**
1. I'll trigger a Figma command to start the OAuth flow
2. A browser window will open
3. Log in and authorize
4. Return here

[Start OAuth flow] [Skip this tool]
```

After each fix attempt:
1. Re-validate the tool
2. If successful: Show ✓ and move to next
3. If still failing: Show error, offer retry or skip

### Fix Templates by Issue Type

#### OAuth Pending/Expired

```markdown
### {Tool} — Complete OAuth

**Status:** OAuth {pending/expired}

**To fix:**
1. I'll run a {Tool} command to trigger OAuth
2. A browser window will open
3. Log in to {Tool} and authorize DESIGN-OPS
4. Return here when done

[Start OAuth flow] [Skip]
```

After OAuth flow:
- Make test call
- If success: "✓ {Tool} is now connected!"
- If fail: "Still not working. Check browser completed OAuth."

#### Environment Variable Missing

```markdown
### {Tool} — API Key Missing

**Status:** {ENV_VAR} not set

**To fix:**

{If 1Password detected:}
1. Create/retrieve your {Tool} API key from: {service_url}
2. Store in 1Password:
   ```bash
   op item create \
     --category="API Credential" \
     --title="{Tool} API" \
     --vault="DESIGN-OPS" \
     'credential=YOUR_KEY_HERE'
   ```
3. Run `source ~/.zshrc` to reload secrets

{If no secrets manager:}
1. Create/retrieve your {Tool} API key from: {service_url}
2. Add to ~/.zshrc:
   ```bash
   export {ENV_VAR}="your-key-here"
   ```
3. Run `source ~/.zshrc` to reload

[I've set it — verify now] [Skip]
```

#### Token Invalid/Expired

```markdown
### {Tool} — Token Invalid

**Status:** API returned: {error_message}

**Likely causes:**
1. Token was revoked
2. Token expired (if using expiring tokens)
3. Permissions changed

**To fix:**
1. Go to {service_url}
2. Revoke the old token (if visible)
3. Generate a new token with these scopes: {required_scopes}
4. Update your {ENV_VAR} with the new token

[I've updated it — verify now] [Skip]
```

#### 403 Forbidden (Scope Issue)

```markdown
### {Tool} — Insufficient Permissions

**Status:** 403 Forbidden

**The error indicates your token doesn't have the required permissions.**

**Required scopes for DESIGN-OPS:**
{tool_specific_scopes}

**To fix:**
1. Go to {service_url}
2. Check your token's permissions
3. Either update the token's scopes, or generate a new token with:
   {scope_list}

[I've updated it — verify now] [Skip]
```

#### MCP Not Installed

```markdown
### {Tool} — MCP Not Installed

**Status:** MCP not found in Claude settings

**The {Tool} MCP needs to be installed.**

**Install command:**
```bash
{install_command}
```

[Install now] [Skip]
```

---

## Output After --fix Completes

```markdown
## Fix Summary

Fixed {success_count} of {total_count} issues:

✓ Figma — OAuth completed
✓ Notion — API key configured
✗ Vercel — Skipped (will show errors in dashboard)

**Current status:**
- ✓ Ready: 5 tools
- ✗ Still failing: 1 tool (Vercel)
- — Skipped: 2 tools

{If all fixed:}
All issues resolved! Run `/design-ops:dashboard` to see your data.

{If some skipped:}
Note: Skipped tools will show errors in the dashboard.
Run `/design-ops:validate --fix` anytime to fix them.
```

---

## Tool-Specific Validation Details

### Notion

| Check | Method | Success Criteria |
|-------|--------|------------------|
| MCP registered | Read settings.json | "notion" in mcpServers |
| API key set | Check env | NOTION_API_KEY exists |
| API key valid | mcp__notion__API-get-self | Returns user object |

### GitHub

| Check | Method | Success Criteria |
|-------|--------|------------------|
| MCP registered | Read settings.json | "github" in mcpServers |
| Token valid | mcp__github__search_repositories | Returns results (even empty) |
| Repo access | List tracked repos | Can access configured repos |

### Google Workspace

| Check | Method | Success Criteria |
|-------|--------|------------------|
| MCP registered | Read settings.json | "google-workspace" in mcpServers |
| OAuth valid | mcp__google-workspace__list_calendars | Returns calendar list |

### Figma

| Check | Method | Success Criteria |
|-------|--------|------------------|
| MCP registered | Read settings.json | "figma" in mcpServers |
| OAuth valid | mcp__figma__whoami | Returns user info |

### Supabase

| Check | Method | Success Criteria |
|-------|--------|------------------|
| MCP registered | Read settings.json | "supabase" in mcpServers |
| OAuth valid | List tables or databases | Returns data |

### Vercel

| Check | Method | Success Criteria |
|-------|--------|------------------|
| MCP registered | Read settings.json | "vercel" in mcpServers |
| Token valid | List deployments | Returns deployment list |
| Required scopes | Check response | No 403 errors |

### Dub.co

| Check | Method | Success Criteria |
|-------|--------|------------------|
| MCP registered | Read settings.json | "dubco" in mcpServers |
| API working | Get link count | Returns data |

Note: Dub.co MCP may not support listing links (MCP limitation).
Validation checks what's available.

### Google Analytics

| Check | Method | Success Criteria |
|-------|--------|------------------|
| Property ID set | Check env/config | GA4_PROPERTY_ID exists |
| Access valid | Fetch basic metrics | Returns session data |

---

## Update Config After Validation

After validation completes, update config with current status:

```yaml
tools:
  - id: notion
    status: connected
    validated_at: "2024-01-15T10:30:00Z"
    validation_result:
      success: true
      response_time_ms: 245
  - id: figma
    status: oauth_pending
    validated_at: "2024-01-15T10:30:00Z"
    validation_result:
      success: false
      error: "OAuth token expired"
```

---

## Related Commands

| Command | Purpose |
|---------|---------|
| `/design-ops:setup` | Full setup wizard with built-in validation |
| `/design-ops:dashboard` | View dashboard (runs lightweight status check) |
| `/design-ops:configure` | Update configuration |
| `/design-ops:status` | Quick overview of what's configured |

---

*Version: 1.0*
