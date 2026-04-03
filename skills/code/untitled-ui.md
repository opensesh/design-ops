# Untitled UI

Use Untitled UI as the foundation for building interfaces with Claude. A professional component library with semantic search, page templates, and icons.

## Purpose

Untitled UI provides production-ready React components, page templates, and icons. This skill ensures Claude leverages the library effectively rather than building from scratch.

## When to Activate

Use this skill when:
- Building new UI components or pages
- User mentions Untitled UI, UTUI, or component library
- Creating dashboards, marketing pages, or application UIs
- Need icons for an interface
- Looking for page templates or layouts

---

## Core Principle

**Always search before building.** Untitled UI likely has a component for what you need. Never build from scratch without first checking the library.

---

## MCP Tools Available

| Tool | Purpose |
|------|---------|
| `search_components` | Semantic search for components (primary tool) |
| `list_components` | Browse by category |
| `get_component` | Get install command for a specific component |
| `get_component_bundle` | Install multiple components at once |
| `get_page_templates` | Browse/search full page templates |
| `get_page_template_files` | Get install command for a template |
| `search_icons` | Find icons by name or concept |

---

## Workflow

### Step 1: Understand the Need

Before searching, clarify:
- What type of UI? (dashboard, marketing, application)
- What functionality? (login, pricing, settings, data table)
- Any specific elements? (avatar, file upload, charts)

### Step 2: Search Components

Use `search_components` with descriptive natural language:

**Good queries:**
- "login page with social auth buttons"
- "pricing table with feature comparison"
- "modal dialog with file upload"
- "data table with sorting and pagination"
- "dashboard sidebar with navigation"

**Categories:**
- `base` - Foundational UI elements
- `application` - App-specific components (dashboards, settings)
- `marketing` - Landing pages, pricing, testimonials
- `foundations` - Design tokens, primitives
- `shared-assets` - Common utilities

### Step 3: Get Component

Once you find a match, use `get_component` to get the CLI install command:

```
get_component({ component_name: "login-01" })
```

Returns a CLI command like:
```bash
npx @untitledui/cli add login-01
```

### Step 4: Install and Customize

1. Run the CLI command to add the component
2. Customize styling, content, and behavior as needed
3. Integrate with the project's existing patterns

---

## Page Templates

For full pages, use `get_page_templates`:

**Categories:**
- `landing-pages`, `pricing-pages`, `about-pages`
- `dashboards`, `settings`
- `login`, `signup`, `forgot-password`
- `blog-pages`, `blog-posts`
- `404-pages`, `faq-pages`, `legal-pages`

**Semantic search:**
```
get_page_templates({
  query: "SaaS landing page with pricing and testimonials",
  page_type: "marketing"
})
```

**Layout options for dashboards:**
- `sidebar` - Side navigation
- `header` - Top navigation
- `full-width` - No persistent nav

---

## Icons

**Always verify icons exist** before importing. Use `search_icons`:

```
search_icons({ query: "settings" })
search_icons({ query: "arrow right" })
search_icons({ query: "user profile" })
```

**Icon categories:**
- `alerts-feedback`, `arrows`, `charts`
- `communication`, `development`, `editor`
- `files`, `finance-ecommerce`, `general`
- `maps-travel`, `media-devices`, `security`
- `users`, `weather`, `time`

**Import format:**
```tsx
import { Settings01, ArrowRight, User01 } from '@untitledui/icons'
```

Icons use PascalCase with numeric suffixes for variants.

---

## Bundle Multiple Components

When building a page that needs several components:

```
get_component_bundle({
  components: ["header-01", "sidebar-01", "table-01", "pagination-01"]
})
```

Returns a single CLI command to install all at once.

---

## Version Selection

Untitled UI has two versions:
- **Version 8** (default) - Latest, recommended
- **Version 7** - Legacy support

Specify version when needed:
```
search_components({ query: "modal", version: "7" })
```

---

## PRO Components

Some components require a PRO license:
- If PRO component requested without key, follow `agent_instructions` in response
- **Never build PRO components from scratch** - respect licensing
- Free components are always available

---

## Best Practices

### Do:
- Search with descriptive, specific queries
- Use semantic search - it understands visual concepts
- Bundle related components for efficiency
- Verify icon names before importing
- Start with page templates for full pages

### Don't:
- Build components that exist in the library
- Guess icon import names - always search first
- Ignore PRO component instructions
- Use version 7 unless specifically required

---

## Example Workflows

### Building a Login Page

```
1. search_components({ query: "login page with social auth" })
2. Review results, select best match (e.g., "login-03")
3. get_component({ component_name: "login-03" })
4. Run CLI command: npx @untitledui/cli add login-03
5. Customize with project branding and auth logic
```

### Building a Dashboard

```
1. get_page_templates({
     category: "dashboards",
     layout: "sidebar",
     query: "analytics dashboard with charts"
   })
2. Select template, get files with get_page_template_files
3. Run CLI command to install
4. search_components for additional widgets as needed
5. search_icons for any missing icons
```

### Finding Icons

```
1. search_icons({ query: "notification bell" })
2. Results show: Bell01, Bell02, BellOff, etc.
3. Import: import { Bell01 } from '@untitledui/icons'
```

---

## Integration with Other Skills

- **frontend-design**: Use Untitled UI components as the implementation layer
- **design-system-scaffolder**: Document Untitled UI as the component foundation
- **accessibility-audit**: Untitled UI components are WCAG compliant by default

---

*Version: 1.0*
