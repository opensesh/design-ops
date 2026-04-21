# Open Session Brand

Default brand for DESIGN-OPS dashboards, extracted from the [BOS-3.0 design system](https://github.com/opensesh/BOS-3.0).

## Brand Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Aperol** | `#FE5102` | Primary accent, CTAs, links |
| **Charcoal** | `#191919` | Dark backgrounds, primary text |
| **Vanilla** | `#FFFAEE` | Light backgrounds, light text |

## Color Strategy: "Warm Neutrals"

Instead of standard grays, Open Session uses Charcoal and Vanilla as the foundation for the entire neutral scale. This gives the UI warmth and brand recognition while maintaining excellent accessibility.

### Accessibility

| Combination | Contrast | Rating |
|-------------|----------|--------|
| Vanilla on Charcoal | 18.5:1 | AAA |
| Charcoal on Vanilla | 18.5:1 | AAA |
| Aperol on Charcoal | 5.5:1 | AA (large text) |

## Typography

The dashboard uses system fonts for CDN compatibility:

- **Display/Body**: System UI stack (San Francisco, Segoe UI, Roboto)
- **Mono**: System monospace stack (SF Mono, Menlo, Consolas)

Note: The full BOS-3.0 system uses custom fonts (Neue Haas Grotesk Display Pro, Offbit), but these require font hosting.

## Semantic Tokens

### Light Mode

```css
--bg-primary: #faf8f5;      /* Page background */
--bg-secondary: #ffffff;     /* Card background */
--fg-primary: #191919;       /* Primary text */
--fg-secondary: #44403a;     /* Secondary text */
--border-secondary: #ebe8e4; /* Card borders */
```

### Dark Mode

```css
--bg-primary: #191919;       /* Page background */
--bg-secondary: #1f1f1f;     /* Card background */
--fg-primary: #fffaee;       /* Primary text */
--fg-secondary: #d5d1cb;     /* Secondary text */
--border-secondary: #2e2e2e; /* Card borders */
```

## Files

| File | Purpose |
|------|---------|
| `brand.css` | Complete CSS variables for dashboard theming |

## Learn More

- [Open Session Website](https://opensession.studio)
- [BOS-3.0 Design System](https://github.com/opensesh/BOS-3.0)
