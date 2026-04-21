# /design-ops:dashboard-html

Generate a static HTML dashboard viewable in any browser. Outputs a single HTML file with embedded CSS and JavaScript — no build step required.

## Trigger

```bash
/design-ops:dashboard-html [pillar] [timeframe]
```

## Parameters

### Pillar (optional)

| Value | Description | Default |
|-------|-------------|---------|
| `ops` | Operations — calendar, tasks, communication | All pillars |
| `design` | Design — code repos, design files, team activity | All pillars |
| `analytics` | Analytics — web traffic, links, subscribers | All pillars |
| omitted | All enabled pillars combined | All pillars |

### Timeframe (optional)

| Value | Aliases | Description | Default |
|-------|---------|-------------|---------|
| `daily` | `today`, `d` | Today's activity | Daily |
| `weekly` | `week`, `w` | This week's summary | — |
| `quarterly` | `quarter`, `q` | Quarter-to-date metrics | — |
| `ytd` | `year`, `y` | Year-to-date overview | — |

---

## Technology Stack

```
Output Format:     Single HTML file with embedded CSS/JS
Styling:           Tailwind CSS 3.x (CDN) + Brand CSS variables
Charts:            Chart.js 4.x (CDN)
Icons:             Lucide Icons (CDN)
Data Format:       Embedded JSON in <script> tag
Interactivity:     Minimal vanilla JS (dark mode toggle)
Default Brand:     Open Session (BOS-3.0 design system)
```

---

## Output Location

```
~/.claude/design-ops/dashboard.html         # Generated dashboard
~/.claude/design-ops/dashboard-history/     # Archived versions
```

---

## Workflow

### Phase 1: Parse & Load Config

1. **Parse** command arguments (pillar, timeframe)
2. **Read** `~/.claude/design-ops-config.yaml`
3. **Validate** enabled pillars and connected tools
4. **Check** for custom brand at `~/.claude/design-ops/brand.css`

### Phase 2: Fetch MCP Data

For each enabled pillar and connected tool:

1. **Attempt data fetch** via MCP tool call
2. **If successful** → Store normalized data
3. **If failed** → Store error state with fix guidance
4. **Normalize** data into standard format for components

### Phase 3: Component Selection

Use `templates/dashboard-html/mapping.yaml` rules:

| Data Shape | Component |
|------------|-----------|
| Single metric with trend | `stat-card` |
| Time series data | `line-chart` |
| Categorical comparisons (≤8) | `bar-chart` |
| Activity list with times | `list-activity` |
| Multi-column data | `table-simple` |
| Error states | `empty-state` |

### Phase 4: Template Assembly

1. **Load** `templates/dashboard-html/base.html`
2. **Inject** brand CSS (user's or default Open Session)
3. **Inject** layout template (single-pillar or all-pillars)
4. **Populate** component templates with data
5. **Embed** chart data as JSON for Chart.js initialization

### Phase 5: Output & Present

1. **Archive** previous dashboard (if exists)
2. **Write** to `~/.claude/design-ops/dashboard.html`
3. **Open** in browser (platform-specific command)
4. **Report** file path to user

---

## Component Templates

### stat-card

Single metric with optional trend indicator.

```html
<div class="bg-bg-secondary rounded-xl border border-border-secondary p-6">
  <div class="flex items-center justify-between">
    <p class="text-sm text-fg-secondary">{{TITLE}}</p>
    <span class="text-xs {{TREND_COLOR}}">{{TREND}}</span>
  </div>
  <p class="mt-2 text-3xl font-semibold">{{VALUE}}</p>
</div>
```

### bar-chart

Categorical data visualization for comparisons.

```html
<div class="bg-bg-secondary rounded-xl border border-border-secondary p-6">
  <h3 class="text-sm text-fg-secondary mb-4">{{TITLE}}</h3>
  <canvas id="chart-{{ID}}" class="h-64"></canvas>
</div>
```

### list-activity

Ordered list of activities with timestamps.

```html
<div class="bg-bg-secondary rounded-xl border border-border-secondary p-6">
  <h3 class="text-sm text-fg-secondary mb-4">{{TITLE}}</h3>
  <ul class="divide-y divide-border-secondary">
    <!-- Activity items -->
  </ul>
</div>
```

### empty-state

Error state with actionable guidance.

```html
<div class="bg-bg-secondary rounded-xl border border-border-secondary p-6 text-center">
  <div class="w-12 h-12 mx-auto rounded-full bg-warning-50 flex items-center justify-center">
    <i data-lucide="alert-triangle" class="w-6 h-6 text-warning-500"></i>
  </div>
  <h3 class="mt-4 font-medium">{{TITLE}}</h3>
  <p class="mt-2 text-sm text-fg-secondary">{{MESSAGE}}</p>
  <p class="mt-4 text-sm text-fg-tertiary">{{GUIDANCE}}</p>
</div>
```

---

## Data Normalization

### Single Metric Format

```json
{
  "type": "single_metric",
  "title": "Tasks Due",
  "value": 5,
  "trend": "+2",
  "trend_direction": "up"
}
```

### Categorical Format

```json
{
  "type": "categorical",
  "title": "Top Links",
  "labels": ["Link A", "Link B", "Link C"],
  "values": [150, 89, 45]
}
```

### Activity List Format

```json
{
  "type": "activity_list",
  "title": "Recent Commits",
  "items": [
    {
      "title": "feat: add dashboard",
      "subtitle": "Alex · main",
      "time": "2h ago",
      "icon": "git-commit"
    }
  ]
}
```

### Error Format

```json
{
  "type": "error",
  "title": "Google Workspace",
  "error_type": "oauth_required",
  "message": "OAuth Required",
  "guidance": "Run any Google command to complete authorization."
}
```

---

## Responsive Layout

### Mobile (<640px)

- Single column, full-width cards
- Collapsible pillar sections

### Tablet (640-1024px)

- 2 columns

### Desktop (>1024px)

- 3 columns (one per pillar)

---

## Dark Mode

Automatically respects system preference via CSS media query:

```css
@media (prefers-color-scheme: dark) {
  :root { /* dark tokens */ }
}
```

---

## Brand Customization

### Default: Open Session

Ships with Open Session brand from BOS-3.0 design system:
- Aperol (#FE5102) — accent
- Charcoal (#191919) — dark
- Vanilla (#FFFAEE) — light

### Custom Brand

Users can customize via `/design-ops:configure brand`:

1. Creates `~/.claude/design-ops/brand.css`
2. Dashboard uses custom brand instead of default

---

## Examples

### Default (All Pillars, Daily)

```bash
/design-ops:dashboard-html
```

Generates daily dashboard for all enabled pillars.

### Operations Weekly

```bash
/design-ops:dashboard-html ops weekly
```

Generates operations-only weekly summary.

### Analytics Quarterly

```bash
/design-ops:dashboard-html analytics quarterly
```

Generates analytics-only quarterly report.

---

## Related Commands

| Command | Purpose |
|---------|---------|
| `/design-ops:dashboard` | Terminal markdown output |
| `/design-ops:configure brand` | Customize dashboard branding |
| `/design-ops:setup` | Initial configuration |

---

*Version: 1.0*
