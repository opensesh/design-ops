# Custom Brand Template

This folder contains a template for creating your own dashboard brand.

## Quick Start

1. Copy `brand.css` to `~/.claude/design-ops/brand.css`
2. Edit the three core colors at the top of the file
3. Regenerate your dashboard with `/design-ops:dashboard-html`

## Core Colors

Only three colors need to be customized:

```css
/* Primary accent color - used for CTAs, links, highlights */
--color-accent: #3B82F6;

/* Dark color - used for dark backgrounds and light mode text */
--color-dark: #0F172A;

/* Light color - used for light backgrounds and dark mode text */
--color-light: #F8FAFC;
```

All other colors (brand scale, gray scale, semantic tokens) are automatically derived from these three values using CSS `color-mix()`.

## Example Brands

### Tech Blue (Default Template)
```css
--color-accent: #3B82F6;
--color-dark: #0F172A;
--color-light: #F8FAFC;
```

### Forest Green
```css
--color-accent: #10B981;
--color-dark: #064E3B;
--color-light: #ECFDF5;
```

### Purple Haze
```css
--color-accent: #8B5CF6;
--color-dark: #1E1B4B;
--color-light: #FAF5FF;
```

### Coral Warmth
```css
--color-accent: #F97316;
--color-dark: #1C1917;
--color-light: #FFF7ED;
```

### Open Session (Default)
```css
--color-accent: #FE5102;  /* Aperol */
--color-dark: #191919;    /* Charcoal */
--color-light: #FFFAEE;   /* Vanilla */
```

## Advanced Customization

If the auto-derived colors don't match your brand perfectly, you can override individual tokens:

```css
:root {
  /* Core colors */
  --color-accent: #3B82F6;
  --color-dark: #0F172A;
  --color-light: #F8FAFC;

  /* Override specific brand shades */
  --color-brand-500: #2563EB;  /* Slightly different primary */
  --color-brand-600: #1D4ED8;  /* Darker hover state */

  /* Override semantic tokens */
  --bg-brand-solid: #2563EB;
  --fg-brand-primary: #3B82F6;
}
```

## Typography

By default, the template uses system fonts for maximum compatibility:

```css
--font-display: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
--font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
```

To use Google Fonts, add an `@import` at the top of your brand.css:

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

:root {
  --font-display: 'Inter', sans-serif;
  --font-sans: 'Inter', sans-serif;
  /* ... rest of your brand */
}
```

## Status Colors

Status colors (success, warning, error) are separate from your brand and default to accessible standard colors. Override if needed:

```css
:root {
  /* Custom success green */
  --color-success-50: #D1FAE5;
  --color-success-500: #059669;

  /* Custom warning orange */
  --color-warning-50: #FEF3C7;
  --color-warning-500: #D97706;
}
```

## Using Your Brand

After saving your `brand.css`:

```bash
# Generate dashboard with your brand
/design-ops:dashboard-html

# Your brand is automatically detected and applied
```

## Resetting to Default

To go back to the Open Session default brand:

```bash
rm ~/.claude/design-ops/brand.css
/design-ops:dashboard-html
```
