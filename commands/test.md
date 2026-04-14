# /do:test

Verification suite that checks all integrations, skills, and commands are working correctly. Organized by pillars.

## Trigger

User runs `/do:test` to diagnose issues or verify setup after changes.

---

## Workflow

### Step 1: Announce Test Suite

```markdown
## DESIGN-OPS — Diagnostics

Running verification tests...
```

---

### Step 2: Configuration Tests

```markdown
### Configuration
```

**Test 1: Config file exists**
- Check: `~/.claude/do-config.yaml` exists
- Pass: `[x] Config file exists`
- Fail: `[ ] Config file not found — run /do:setup`

**Test 2: Config syntax valid**
- Check: YAML parses without errors
- Pass: `[x] Config syntax valid`
- Fail: `[ ] Config has syntax errors — see details below`

**Test 3: Config version**
- Check: `version` field is "2.0"
- Pass: `[x] Config version: 2.0`
- Warn: `[~] Config version: 1.0 — run /do:setup to migrate`

**Test 4: At least one pillar enabled**
- Check: At least one pillar has `enabled: true`
- Pass: `[x] Pillars enabled: {count}`
- Fail: `[ ] No pillars enabled — run /do:configure`

---

### Step 3: Operations Pillar Tests

```markdown
### Operations Pillar
```

**If pillar enabled:**

For each tool in `pillars.operations.tools`:

**Test: {Tool} connection**
- MCP: Try basic query
- API: Validate token
- Pass: `[x] {Tool}: Connected`
- Fail: `[ ] {Tool}: {error_message}`

**Test: {Tool} capabilities**
- Check: Can fetch data for configured outcomes
- Pass: `[x] {Tool} capabilities: All accessible`
- Partial: `[~] {Tool} capabilities: {N}/{M} accessible`

**If pillar disabled:**
```markdown
- [○] Operations pillar: Disabled (skipped)
```

---

### Step 4: Design Pillar Tests

```markdown
### Design Pillar
```

**If pillar enabled:**

**Test: GitHub MCP (if configured)**
- Try: `mcp__github__list_commits` on one tracked repo
- Pass: `[x] GitHub MCP: Connected, can list repos`
- Fail: `[ ] GitHub MCP: {error_message}`

**Test: GitHub repos accessible (if configured)**
For each tracked repo:
- Try: List recent commits
- Pass: `[x] GitHub repos: All {N} accessible`
- Partial: `[~] GitHub repos: {N}/{M} accessible`
- Fail: `[ ] GitHub repos: None accessible`

**Test: Figma API (if configured)**
```bash
curl -s -H "Authorization: Bearer {token}" "https://api.figma.com/v1/me"
```
- Pass: `[x] Figma API: Connected as {handle}`
- Fail: `[ ] Figma API: {error_message}`

**Test: Figma projects accessible (if configured)**
For each tracked project:
- Pass: `[x] Figma projects: All {N} accessible`
- Partial: `[~] Figma projects: {N}/{M} accessible`

---

### Step 5: Analytics Pillar Tests

```markdown
### Analytics Pillar
```

**If pillar enabled:**

For each analytics tool:

**Test: {Tool} connection**
- Pass: `[x] {Tool}: Connected`
- Fail: `[ ] {Tool}: {error_message}`
- Skipped: `[○] {Tool}: Skipped (no wrapper)`

---

### Step 6: Skills Tests

```markdown
### Skills
```

**Test: Skill files exist**
For each expected skill:
- Check: `skills/{name}/SKILL.md` or `skills/{name}.md` exists
- Pass: `[x] {skill-name}: Found`
- Fail: `[ ] {skill-name}: Missing`

Expected skills:
- brand-guidelines
- frontend-design
- design-system-quality
- brand-voice
- design-feedback
- verification-before-completion
- tool-evaluator

**Test: Skill frontmatter valid**
- Check: YAML frontmatter parses, has `name` and `description`
- Pass: `[x] Skill frontmatter: All valid`
- Fail: `[ ] Skill frontmatter: {skill} has errors`

---

### Step 7: Commands Tests

```markdown
### Commands
```

**Test: Command files exist**
For each expected command:
- Check: `commands/{name}.md` exists
- Pass: `[x] All commands registered`
- Fail: `[ ] Missing: {command}`

Expected commands:
- setup, configure, status, test, help
- daily-brief, weekly-recap
- meeting-brief, meeting-recap
- team-pulse, team-pulse-setup
- devils-advocate, site-analysis
- social-post, add-tool

**Test: No naming conflicts**
- Check: No duplicate command names across plugins
- Pass: `[x] No naming conflicts`
- Fail: `[ ] Conflict with: {plugin}/{command}`

---

### Step 8: End-to-End Test

```markdown
### End-to-End Test
```

**Test: Daily brief data fetch**
If any pillar enabled:
- Try: Fetch data from each connected tool
- Pass: `[x] Daily brief: Can fetch from all sources`
- Partial: `[~] Daily brief: Partial data ({N} of {M} sources)`
- Fail: `[ ] Daily brief: Cannot fetch any data`

**Test: Outcome mapping**
- Check: All configured outcomes map to available capabilities
- Pass: `[x] Outcomes: All mappings valid`
- Warn: `[~] Outcomes: {outcome} has no source (tool not connected)`

---

### Step 9: Summary

```markdown
---

## Results

**Passed:** 18/20 tests
**Warnings:** 2
**Failed:** 0

### Warnings

- Figma project "Old Project" (id: 111) returned 404 — may have been deleted
- Substack not connected — some analytics outcomes unavailable

### Recommendations

1. Remove deleted Figma project: `/do:configure` → Design → Figma
2. Connect Substack for full analytics: `/do:add-tool substack`
```

---

## Output Format

Full test output:

```markdown
## DESIGN-OPS — Diagnostics

### Configuration
- [x] Config file exists
- [x] Config syntax valid
- [x] Config version: 2.0
- [x] Pillars enabled: 3

### Operations Pillar
- [x] Notion MCP: Connected
- [x] Notion capabilities: All accessible
- [x] Google Workspace MCP: Connected
- [x] Google Workspace capabilities: All accessible
- [○] Slack: Not configured (optional)

### Design Pillar
- [x] GitHub MCP: Connected
- [x] GitHub repos: All 2 accessible
- [x] Figma API: Connected as jordan.smith
- [~] Figma projects: 1/2 accessible

### Analytics Pillar
- [x] Google Analytics MCP: Connected
- [x] Dub.co MCP: Connected
- [○] Substack: Skipped (no wrapper)

### Skills
- [x] brand-guidelines: Found
- [x] frontend-design: Found
- [x] design-system-quality: Found
- [x] tool-evaluator: Found
- [x] All 7 skills valid

### Commands
- [x] All 15 commands registered
- [x] No naming conflicts

### End-to-End
- [x] Daily brief: Can fetch from all sources
- [~] Outcomes: substack_subscribers has no source

---

## Results

**Passed:** 18/20 tests
**Warnings:** 2
**Failed:** 0

All critical systems operational. Some optional features need attention.

Run `/do:configure` to fix warnings, or `/do:status` for overview.
```

---

## Quick Test Mode

If user runs `/do:test quick`:

Only run critical tests:
1. Config exists and valid
2. One tool per pillar responds
3. Skills directory accessible

```markdown
## Quick Diagnostics

- [x] Config: OK (v2.0)
- [x] Operations: OK (Notion responding)
- [x] Design: OK (GitHub responding)
- [x] Analytics: OK (GA4 responding)

All systems operational.
```

---

## Test by Pillar

User can test specific pillar:

```
/do:test operations
/do:test design
/do:test analytics
```

---

## Error Details

When tests fail, provide actionable details:

```markdown
### Failed: Figma API

**Error:** 403 Forbidden

**Likely causes:**
1. Token has expired — regenerate at figma.com/developers
2. Token was revoked — check Figma account settings
3. Wrong token scope — needs "File content" permission

**Fix:** Run `/do:configure` → Design → Figma → Update token
```

```markdown
### Failed: GitHub MCP

**Error:** MCP not responding (timeout after 10s)

**Likely causes:**
1. MCP server crashed — restart Claude
2. Network issue — check internet connection
3. MCP misconfigured — check ~/.claude/settings.json

**Fix:** Try restarting Claude, or run `claude mcp list` to check status
```

---

*Version: 2.0*
