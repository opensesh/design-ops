# Security & Secrets Management

API key governance and secure credential management for DESIGN-OPS.

---

## Overview

DESIGN-OPS connects to multiple external services (Notion, GitHub, Google Analytics, etc.). Secure credential management is critical to protect your data and prevent unauthorized access.

**Key Principle**: Never store secrets in plain text files. Always use a secrets manager.

---

## Secrets Manager Options

### Recommended: 1Password CLI

1Password provides the most seamless integration for developers:

```bash
# Install 1Password CLI
brew install --cask 1password-cli

# Sign in (first time)
op signin

# Verify installation
op whoami
```

### Alternatives

| Manager | CLI Tool | Environment Integration |
|---------|----------|------------------------|
| 1Password | `op` | Native shell plugin |
| Bitwarden | `bw` | Export to env vars |
| AWS Secrets Manager | `aws secretsmanager` | SDK integration |
| HashiCorp Vault | `vault` | Enterprise-grade |
| macOS Keychain | `security` | Local only |

---

## Required Credentials by Tool

| Tool | Secret Type | Environment Variable | Where to Get It |
|------|-------------|---------------------|-----------------|
| Notion | Integration Token | `NOTION_API_KEY` | [notion.so/my-integrations](https://www.notion.so/my-integrations) |
| Google Analytics | Property ID | `GA4_PROPERTY_ID` | [analytics.google.com](https://analytics.google.com) → Admin → Property Settings |
| Figma | Personal Access Token | `FIGMA_API_TOKEN` | [figma.com/developers](https://www.figma.com/developers/api#access-tokens) |
| GitHub | Personal Access Token | `GITHUB_TOKEN` | [github.com/settings/tokens](https://github.com/settings/tokens) |
| Dub.co | API Key | `DUB_API_KEY` | [dub.co/settings/tokens](https://dub.co/settings/tokens) |

**Note**: Google Workspace, Supabase, and Figma MCPs use OAuth (browser-based) and don't require environment variables.

---

## 1Password Setup (Detailed)

### Step 1: Create a Vault

Create a dedicated vault for DESIGN-OPS secrets:

```bash
# Create vault (optional - you can use Personal vault)
op vault create "DESIGN-OPS" --description "API keys and tokens for DESIGN-OPS"
```

### Step 2: Store Your Secrets

Add each credential as a secure note or API credential:

```bash
# Notion API Key
op item create \
  --category="API Credential" \
  --title="Notion API" \
  --vault="DESIGN-OPS" \
  'credential=secret_xxxxxxxxxxxxxxxx'

# Google Analytics Property ID
op item create \
  --category="Secure Note" \
  --title="Google Analytics" \
  --vault="DESIGN-OPS" \
  'property_id=123456789'
```

Or use the 1Password desktop app to add credentials manually.

### Step 3: Reference Secrets in Shell Profile

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
# DESIGN-OPS Secrets (via 1Password CLI)
# These are loaded on-demand when referenced

# Function to load secrets (call once per session)
load_design_ops_secrets() {
  # Sign in to 1Password if needed
  if ! op account get &>/dev/null; then
    eval $(op signin)
  fi

  # Load secrets into environment
  export NOTION_API_KEY="$(op read 'op://DESIGN-OPS/Notion API/credential' 2>/dev/null)"
  export GA4_PROPERTY_ID="$(op read 'op://DESIGN-OPS/Google Analytics/property_id' 2>/dev/null)"
  export FIGMA_API_TOKEN="$(op read 'op://DESIGN-OPS/Figma/credential' 2>/dev/null)"
  export GITHUB_TOKEN="$(op read 'op://DESIGN-OPS/GitHub/credential' 2>/dev/null)"

  echo "DESIGN-OPS secrets loaded"
}

# Optional: Create alias
alias dos-secrets='load_design_ops_secrets'
```

### Step 4: Verify Setup

```bash
# Load secrets
source ~/.zshrc
load_design_ops_secrets

# Verify (shows first/last few chars only)
echo "NOTION_API_KEY: ${NOTION_API_KEY:0:10}...${NOTION_API_KEY: -4}"
```

---

## Alternative: 1Password Shell Plugin

For seamless integration without manual loading:

```bash
# Install shell plugin
op plugin init

# Sign in with biometrics
op plugin run -- zsh
```

The shell plugin automatically injects secrets when referenced.

---

## Bitwarden Setup

```bash
# Install Bitwarden CLI
brew install bitwarden-cli

# Login
bw login

# Unlock vault
export BW_SESSION=$(bw unlock --raw)

# Get a secret
export NOTION_API_KEY=$(bw get password "Notion API Key")
```

Add to shell profile:

```bash
# Bitwarden secrets loader
load_design_ops_secrets() {
  export BW_SESSION=$(bw unlock --raw)
  export NOTION_API_KEY=$(bw get password "Notion API Key")
  export GA4_PROPERTY_ID=$(bw get notes "Google Analytics Property ID")
  echo "DESIGN-OPS secrets loaded"
}
```

---

## Security Best Practices

### DO

- Store API keys in a secrets manager (1Password, Bitwarden, etc.)
- Use environment variables that reference secrets managers
- Create separate credentials for DESIGN-OPS (not your personal accounts)
- Use read-only or scoped tokens when possible
- Rotate API keys periodically (quarterly recommended)
- Audit which tools have access to which services
- Use OAuth when available (more secure than API keys)

### DON'T

- Commit API keys to git (even in `.env` files)
- Store keys in plain text in `~/.zshrc` or config files
- Share API keys via Slack, email, or other messaging
- Use personal admin tokens for automated tools
- Grant more permissions than necessary
- Ignore key rotation warnings from services

---

## Scoped Permissions

When creating API tokens, use the minimum required permissions:

### Notion Integration

Required capabilities:
- Read content ✓
- Read user information ✓ (for activity tracking)
- No insert/update needed for dashboard only

### GitHub Token (Fine-Grained)

Required permissions:
- Repository: Read access
- Pull requests: Read access
- Commits: Read access
- No write access needed

### Figma Token

Figma tokens are all-or-nothing. If concerned:
- Create a separate Figma account for CI/automation
- Invite it to specific projects only

---

## Leaked Key Response

If you suspect a key has been compromised:

### Immediate Actions (within 5 minutes)

1. **Revoke the key** — Go to the service's settings and delete/revoke the token
2. **Generate a new key** — Create a fresh credential
3. **Update 1Password** — Store the new key in your secrets manager
4. **Restart terminal** — Clear env vars and reload

### Service-Specific Revocation

| Service | Revocation URL |
|---------|----------------|
| Notion | [notion.so/my-integrations](https://www.notion.so/my-integrations) |
| GitHub | [github.com/settings/tokens](https://github.com/settings/tokens) |
| Figma | [figma.com/developers](https://www.figma.com/developers/api#access-tokens) |
| Google | [console.cloud.google.com](https://console.cloud.google.com/apis/credentials) |

### Follow-Up (within 24 hours)

1. **Check for unauthorized access** — Review service audit logs
2. **Scan for exposure** — Search GitHub, Pastebin for your key
3. **Document the incident** — Note how the leak occurred
4. **Prevent recurrence** — Update processes/scripts that exposed the key

---

## Configuration File Safety

The DESIGN-OPS config file (`~/.claude/design-ops-config.yaml`) should NEVER contain actual credentials:

```yaml
# WRONG - Never do this
pillars:
  operations:
    tools:
      - id: notion
        api_key: "secret_xxxxxxxx"  # NEVER store keys here

# CORRECT - Reference environment variables
pillars:
  operations:
    tools:
      - id: notion
        type: mcp
        status: connected
        auth:
          token_env: NOTION_API_KEY  # Reference, not value
```

---

## Git Safety

### Pre-commit Hook

Add a pre-commit hook to catch accidental credential commits:

```bash
# .git/hooks/pre-commit
#!/bin/bash

# Check for common secret patterns
if git diff --cached | grep -E '(secret_|sk_live_|AKIA|ghp_|fgpat_)' > /dev/null; then
  echo "ERROR: Possible secret detected in commit"
  echo "Run 'git diff --cached' to review"
  exit 1
fi
```

### Global Gitignore

Add to `~/.gitignore_global`:

```
# Secrets
.env
.env.local
*.pem
*.key
credentials.json
```

---

## Troubleshooting

### "NOTION_API_KEY not set"

1. Check if 1Password CLI is signed in: `op whoami`
2. Verify the secret exists: `op item get "Notion API" --vault="DESIGN-OPS"`
3. Source your shell profile: `source ~/.zshrc`
4. Run the loader function: `load_design_ops_secrets`

### "op: command not found"

1Password CLI not installed:
```bash
brew install --cask 1password-cli
```

### "Couldn't authenticate"

1Password needs to be unlocked:
```bash
eval $(op signin)
```

Or enable biometric unlock in 1Password settings.

---

## Detection During Setup

The `/design-ops:setup` command now detects available secrets managers:

```markdown
## Secrets Manager Detection

Found: 1Password CLI (`op` command available)

We recommend storing your API keys securely:
- Notion API key → `op://DESIGN-OPS/Notion API/credential`
- GA4 Property ID → `op://DESIGN-OPS/Google Analytics/property_id`

[Guide me through 1Password setup] | [I'll handle secrets myself]
```

---

## Related Documentation

- [Troubleshooting Guide](troubleshooting.md) — Connection issues
- [Config Schema](config-schema.md) — Full configuration reference
- [Tool Registry](tool-registry.md) — Supported tools and their auth methods

---

*Version: 1.0*
