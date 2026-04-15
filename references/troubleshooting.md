# Troubleshooting

Common issues and how to fix them.

---

## Commands don't appear after installation

### In Claude Desktop

1. Close and reopen Claude Desktop completely
2. Or type `/reload-plugins` in the Code tab

### In Terminal

1. Exit Claude Code by typing `exit`
2. Restart Claude: `claude`
3. Verify the plugin is installed:
   ```bash
   ls .claude/plugins/design-ops
   ```
   You should see the `commands/`, `skills/`, and `references/` directories.

---

## Plugin not found error

### Check the plugin is installed

**Mac/Linux:**
```bash
ls .claude/plugins/design-ops
```

**Windows:**
```powershell
dir .claude\plugins\design-ops
```

If the folder doesn't exist, re-run the install script:

### Re-install the plugin

**Option 1: Terminal**
```bash
git clone https://github.com/opensesh/DESIGN-OPS
bash DESIGN-OPS/.design-ops/install.sh ./my-project
```

**Option 2: Claude Code**
```
Clone github.com/opensesh/DESIGN-OPS and run the install script to set up DESIGN-OPS in this project.
```

---

## Config file issues

### Config not being saved

Check if the `.claude` directory exists:

**Mac/Linux:**
```bash
ls ~/.claude
```

If it doesn't exist, create it:
```bash
mkdir -p ~/.claude
```

**Windows:**
```powershell
dir %USERPROFILE%\.claude
```

If it doesn't exist:
```powershell
mkdir %USERPROFILE%\.claude
```

### Config looks wrong

The config lives at `~/.claude/do-config.yaml`. You can:

1. View it:
   ```bash
   cat ~/.claude/do-config.yaml
   ```

2. Reset it by running `/do:setup` again and choosing "Start fresh"

---

## Tool connectors not working

### In Claude Desktop

1. Click the **+** button next to the prompt box
2. Select **Connectors**
3. Verify the connector shows as "Connected"
4. If not connected, click it to authorize

### Check MCP status

In the Code tab, Claude can detect which MCPs are configured. Run:
```
What MCPs do I have connected?
```

Claude will list what's available and what's missing.

### Re-authorize a connector

1. Click **+** → **Connectors**
2. Click the connector you want to fix
3. Follow the authorization flow again

---

## Specific command issues

### /daily-brief shows nothing

This command works at any integration level:
- **With Calendar connected:** Shows your meetings automatically
- **Without Calendar:** Just tell Claude what's on your schedule

If connected but nothing shows, check your connector authorization (see above).

### /add-tool isn't working

The `/add-tool` command guides you through MCP setup. If it's failing:
1. Make sure you're in the **Code tab** (not Cowork)
2. Try running it with a specific tool: `/add-tool google-calendar`
3. Check the detailed guides in [`mcp-setup/`](mcp-setup/)

---

## Permission errors

### Can't write to ~/.claude

**Mac/Linux:**
```bash
chmod 755 ~/.claude
```

**Windows:** Run PowerShell as Administrator and check folder permissions.

### Plugin folder is read-only

If files are marked as read-only after installation, fix with:

**Mac/Linux:**
```bash
chmod -R 755 .claude/plugins/design-ops
```

---

## Still stuck?

1. **Check the [GitHub Issues](https://github.com/opensesh/DESIGN-OPS/issues)** — your problem might already be solved
2. **Open a new issue** with:
   - What you tried
   - What happened
   - Your OS (Mac, Windows, Linux)
   - How you installed (Terminal or Claude Code)
3. **Email:** [hello@opensession.co](mailto:hello@opensession.co)
