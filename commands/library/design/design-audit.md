# /design-ops:design-audit

Automated design system compliance check. Validates components, screens, or files against your design tokens and patterns.

## Trigger

User invokes `/design-ops:design-audit` to check design system compliance for:
- Figma files (via URL or file key)
- Screenshots (uploaded images)
- Component names (references existing patterns)

---

## Workflow

### Step 1: Input Collection

"What would you like to audit?"

**Options:**
- `Figma file URL` — Paste a Figma link
- `Screenshot` — Upload or reference an image
- `Component name` — Check against known patterns

### Step 2: Design System Reference

Check for design system configuration:

1. **Read** `~/.claude/design-ops-config.yaml` for design system tokens
2. **Check** for project-local `references/design-system.md`
3. **Fall back** to Open Session defaults if no custom system

If no design system found:
```
No design system configured. I'll use general best practices.

To add your design system:
1. Create `references/design-system.md` in your project
2. Or run `/design-ops:configure design` to add tokens

Continue with general audit? [Yes / Configure first]
```

### Step 3: Run Audit

For each auditable element, check:

**Colors:**
- Are all colors from the design token palette?
- Any raw hex values that should be tokens?
- Contrast ratios meet accessibility standards?

**Typography:**
- Font families match approved list?
- Font sizes use the type scale?
- Line heights follow guidelines?

**Spacing:**
- Uses 8px grid (or configured base)?
- Consistent padding/margins?
- No arbitrary spacing values?

**Components:**
- Using approved component patterns?
- Variant usage consistent?
- No one-off custom components?

### Step 4: Generate Report

```markdown
## Design Audit Results

**File:** {filename or description}
**Score:** {X}% compliant

### Violations Found

| Element | Issue | Fix |
|---------|-------|-----|
| CTA Button | Uses #FF0000 (not Aperol) | Change to --bg-brand-solid |
| Body text | 14px (below minimum) | Use 16px / var(--text-base) |
| Card padding | 13px (off-grid) | Use 16px (2 units) |

### Warnings

| Element | Note |
|---------|------|
| Hero section | Custom gradient — verify intentional |
| Icon color | Using gray-500, consider gray-600 for contrast |

### Passed

- Spacing uses 8px grid
- Typography uses approved fonts
- Color contrast meets WCAG AA
- Button variants are consistent

### Recommendations

1. **High priority:** Fix the 3 color violations
2. **Medium:** Review custom components for extraction
3. **Low:** Consider documenting the gradient pattern
```

---

## Integration Points

### Design System Quality Skill

This command leverages the `design-system-quality` skill for:
- Pattern detection
- Token validation
- Compliance scoring

### Figma API

If auditing Figma files:
1. Extract styles via Figma API
2. Map to design token names
3. Identify divergences

---

## Configuration

Store audit preferences in config:

```yaml
design_audit:
  token_source: "references/design-system.md"
  grid_base: 8
  min_font_size: 16
  required_contrast: "AA"
  ignore_patterns:
    - "experimental/*"
    - "archive/*"
```

---

## Example Session

**User:** `/design-ops:design-audit`

**Claude:** "What would you like to audit?"

**User:** "https://figma.com/file/ABC123/Homepage-Redesign"

**Claude:** *Fetches file, extracts styles, runs audit*

```markdown
## Design Audit Results

**File:** Homepage Redesign
**Score:** 85% compliant

### Violations Found (3)

| Element | Issue | Fix |
|---------|-------|-----|
| Hero CTA | #E34902 (close but not Aperol) | Use #FE5102 / --bg-brand-solid |
| Subtitle | 15px font size | Use 16px / --text-base |
| Card shadow | 0 2px 8px | Use --shadow-sm token |

### Passed

- Primary colors correct
- Typography scale followed
- Grid alignment consistent
- Component patterns match library

Would you like me to generate a fix list for your designer?
```

---

## Error Handling

| Error | Response |
|-------|----------|
| Invalid Figma URL | "That doesn't look like a valid Figma URL. Format: figma.com/file/KEY/name" |
| No Figma token | "Figma API access required. Run `/design-ops:configure design` to add your token." |
| File not accessible | "Can't access that file. Check sharing permissions or token scope." |
| No design system | "No design system found. Proceeding with general best practices." |

---

*Version: 1.0*
