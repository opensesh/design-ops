# Design System Scaffolder

Help establish and document design systems from scratch or organize existing patterns into a coherent system.

## Purpose

Guide the creation of design systems with proper foundations, documentation structure, and governance. Start from any point—whether building new or systematizing existing work.

## When to Activate

Use this skill when:
- Starting a design system from scratch
- Organizing existing components into a system
- Documenting an undocumented system
- Planning design system architecture

---

## Design System Layers

### The Stack (bottom to top)

```
┌─────────────────────────────────────┐
│           PAGE TEMPLATES            │  ← Full page layouts
├─────────────────────────────────────┤
│             PATTERNS                │  ← Component combinations
├─────────────────────────────────────┤
│            COMPONENTS               │  ← UI building blocks
├─────────────────────────────────────┤
│           FOUNDATIONS               │  ← Tokens + primitives
└─────────────────────────────────────┘
```

---

## Scaffolding Process

### Step 1: Audit Existing Work

Before building, understand what exists:

```
## Design System Audit

### Visual Inventory
- [ ] Colors in use (extract all unique values)
- [ ] Typography (fonts, sizes, weights)
- [ ] Spacing values (margins, padding)
- [ ] Border radii
- [ ] Shadows/elevation
- [ ] Icons and iconography

### Component Inventory
- [ ] List all UI components in use
- [ ] Note variations of each component
- [ ] Identify inconsistencies
- [ ] Group by function (navigation, forms, content, etc.)

### Pattern Inventory
- [ ] Common page layouts
- [ ] Repeated sections
- [ ] Standard user flows

### Findings
[Summary of current state, inconsistencies, opportunities]
```

### Step 2: Establish Foundations

Create design tokens:

```
## Design Tokens

### Color System

#### Semantic Tokens (use these)
| Token | Value | Usage |
|-------|-------|-------|
| `--color-text-primary` | [hex] | Main body text |
| `--color-text-secondary` | [hex] | Supporting text |
| `--color-bg-primary` | [hex] | Main backgrounds |
| `--color-bg-secondary` | [hex] | Cards, surfaces |
| `--color-border` | [hex] | Default borders |
| `--color-interactive` | [hex] | Links, buttons |
| `--color-interactive-hover` | [hex] | Hover states |
| `--color-success` | [hex] | Success states |
| `--color-warning` | [hex] | Warning states |
| `--color-error` | [hex] | Error states |

### Typography Scale

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `--text-xs` | 12px | 1.5 | 400 | Captions, labels |
| `--text-sm` | 14px | 1.5 | 400 | Secondary text |
| `--text-base` | 16px | 1.5 | 400 | Body text |
| `--text-lg` | 18px | 1.4 | 500 | Lead text |
| `--text-xl` | 24px | 1.3 | 600 | H3 |
| `--text-2xl` | 32px | 1.2 | 700 | H2 |
| `--text-3xl` | 48px | 1.1 | 700 | H1 |

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| `--space-1` | 4px | Tight spacing |
| `--space-2` | 8px | Related elements |
| `--space-3` | 12px | Standard gaps |
| `--space-4` | 16px | Section padding |
| `--space-6` | 24px | Component separation |
| `--space-8` | 32px | Section separation |
| `--space-12` | 48px | Major sections |
| `--space-16` | 64px | Page sections |

### Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `--radius-sm` | 4px | Small elements, tags |
| `--radius-md` | 8px | Buttons, inputs |
| `--radius-lg` | 12px | Cards, modals |
| `--radius-full` | 9999px | Pills, avatars |

### Shadows

| Token | Value | Usage |
|-------|-------|-------|
| `--shadow-sm` | 0 1px 2px rgba(0,0,0,0.05) | Subtle elevation |
| `--shadow-md` | 0 4px 6px rgba(0,0,0,0.1) | Cards |
| `--shadow-lg` | 0 10px 15px rgba(0,0,0,0.1) | Modals, dropdowns |
```

### Step 3: Define Components

Document each component:

```
## Component: [Name]

### Description
[What this component is and when to use it]

### Anatomy
[Diagram or description of parts]

### Variants
| Variant | Description | Usage |
|---------|-------------|-------|
| Primary | [Description] | [When to use] |
| Secondary | [Description] | [When to use] |
| Ghost | [Description] | [When to use] |

### States
- Default
- Hover
- Active/Pressed
- Focused
- Disabled
- Loading (if applicable)

### Sizes
| Size | Height | Padding | Font Size |
|------|--------|---------|-----------|
| Small | 32px | 8px 12px | 14px |
| Medium | 40px | 12px 16px | 16px |
| Large | 48px | 16px 20px | 18px |

### Props/API
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| variant | string | 'primary' | Visual style |
| size | string | 'medium' | Component size |
| disabled | boolean | false | Disabled state |

### Usage Guidelines
**Do:**
- [Best practice]
- [Best practice]

**Don't:**
- [Anti-pattern]
- [Anti-pattern]

### Accessibility
- [A11y requirement]
- [Keyboard behavior]
- [ARIA attributes]

### Code Example
[Include code snippet]
```

### Step 4: Create Documentation Structure

Recommended docs structure:

```
design-system/
├── README.md                 # Overview and getting started
├── CHANGELOG.md              # Version history
├── foundations/
│   ├── colors.md
│   ├── typography.md
│   ├── spacing.md
│   ├── elevation.md
│   └── motion.md
├── components/
│   ├── buttons.md
│   ├── forms.md
│   ├── cards.md
│   └── [etc.]
├── patterns/
│   ├── navigation.md
│   ├── data-entry.md
│   └── [etc.]
└── resources/
    ├── figma-library.md
    ├── code-setup.md
    └── contribution.md
```

---

## Component Categories

Organize components by function:

### Navigation
- Navbar, Sidebar, Breadcrumbs, Tabs, Pagination, Menu

### Forms
- Input, Textarea, Select, Checkbox, Radio, Switch, Slider, File Upload

### Feedback
- Alert, Toast, Modal, Dialog, Tooltip, Progress, Skeleton

### Data Display
- Table, List, Card, Badge, Avatar, Tag, Stat

### Layout
- Container, Grid, Stack, Divider, Spacer

### Actions
- Button, IconButton, Link, Dropdown

---

## Governance

Include governance guidelines:

```
## Design System Governance

### Contribution Process
1. Propose new component/change in [location]
2. Design review with [team]
3. Build and document
4. Code review
5. Merge and announce

### Decision Criteria
New components must:
- [ ] Solve a problem that exists in 3+ places
- [ ] Not be achievable with existing components
- [ ] Have clear use cases documented
- [ ] Meet accessibility requirements
- [ ] Include all necessary states

### Versioning
- Major: Breaking changes
- Minor: New components, non-breaking additions
- Patch: Bug fixes, documentation

### Owners
- Design: [Name]
- Engineering: [Name]
- Documentation: [Name]
```

---

## Quick Start Templates

### For New System

1. Audit existing designs
2. Extract color palette (5-7 primary, semantic colors)
3. Define type scale (6-8 sizes)
4. Set spacing scale (8pt base recommended)
5. Document 5 most-used components
6. Create Figma library + code package
7. Write contribution guidelines

### For Existing Chaos

1. Screenshot every unique UI pattern
2. Group by similarity
3. Pick the best variant as canonical
4. Document the chosen patterns
5. Create migration guide
6. Deprecate non-standard versions

---

*Version: 1.0*
