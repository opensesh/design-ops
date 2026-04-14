# /do:team-pulse

**Legacy alias** for `/do:dashboard design daily` with team focus

## Trigger

User invokes `/do:team-pulse` to see who's working on what across Figma and GitHub.

---

## Behavior

This command is a backwards-compatible alias. It delegates to the unified dashboard command with team-focused output:

```
/do:team-pulse  →  /do:dashboard design daily --team
```

### Execution

1. **Invoke** `/do:dashboard design daily` with team member breakdown
2. **Return** the design dashboard with emphasis on:
   - Activity by team member
   - Team snapshot table
   - Who's working on what

### Team Focus Flag

The `--team` modifier enhances the design dashboard to include:

```markdown
### Team Snapshot

| Person | Design | Code |
|--------|--------|------|
| {Name} | {N} files | {N} commits |
| {Name} | — | {N} commits, {N} PRs |
```

This flag is automatically applied when using `/do:team-pulse`.

---

## Migration Notice

`/do:team-pulse` continues to work for backwards compatibility, but the recommended command is now:

```bash
/do:dashboard design daily    # Design pillar, daily timeframe
/do:dashboard design weekly   # Design pillar, weekly summary
```

The team snapshot table is included in design dashboards when team members are configured.

See `/do:dashboard` for full documentation on pillar and timeframe options.

---

## Prerequisites

For best results, configure team members in `~/.claude/do-config.yaml`:

```yaml
team:
  members:
    - name: "Jordan Smith"
      handles:
        figma: "jordan.smith"
        github: "jordansmith"
    - name: "Taylor Lee"
      handles:
        figma: "taylor.lee"
        github: "taylorl"
```

Run `/do:configure` → Team to update team member mappings.

---

## Why This Alias Exists

- **Muscle memory** — Existing users know `/do:team-pulse`
- **Semantic clarity** — "Team pulse" clearly communicates team activity focus
- **Gradual migration** — Users can adopt new syntax at their own pace

---

*Version: 2.0 (alias wrapper)*
*Delegates to: /do:dashboard design daily --team*
