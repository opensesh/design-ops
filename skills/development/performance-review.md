# Performance Review

Analyze code or websites for performance issues and suggest optimizations.

## Purpose

Identify performance bottlenecks in code, websites, or applications. Provide actionable recommendations prioritized by impact.

## When to Activate

Use this skill when:
- Site feels slow and needs optimization
- Code review with performance focus
- Preparing for high traffic events
- Debugging performance regressions

---

## Performance Audit Process

### Step 1: Establish Context

Ask:
- "What am I reviewing? (URL, code, or describe the issue)"
- "What performance problems are you experiencing?"
- "What's your target performance budget?"

### Step 2: Measure Baseline

For websites, gather Core Web Vitals:

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| **LCP** (Largest Contentful Paint) | <2.5s | 2.5-4s | >4s |
| **FID** (First Input Delay) | <100ms | 100-300ms | >300ms |
| **CLS** (Cumulative Layout Shift) | <0.1 | 0.1-0.25 | >0.25 |
| **TTFB** (Time to First Byte) | <800ms | 800-1800ms | >1800ms |
| **FCP** (First Contentful Paint) | <1.8s | 1.8-3s | >3s |

### Step 3: Identify Issues

Evaluate across categories:

**Loading Performance**
- Asset sizes (images, JS, CSS)
- Number of requests
- Render-blocking resources
- Third-party scripts

**Runtime Performance**
- JavaScript execution time
- Main thread blocking
- Memory usage
- Layout thrashing

**Network Performance**
- TTFB
- CDN usage
- Compression (gzip/brotli)
- Caching headers

**Perceived Performance**
- Above-the-fold content
- Loading states
- Progressive rendering

---

## Report Template

```
## Performance Review: [Subject]

**Date:** [Date]
**Reviewed:** [URL or file paths]

---

### Executive Summary

**Overall Score:** [Poor / Needs Work / Good / Excellent]

**Key Metrics:**
| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| LCP | [value] | <2.5s | 🔴/🟡/🟢 |
| FID | [value] | <100ms | 🔴/🟡/🟢 |
| CLS | [value] | <0.1 | 🔴/🟡/🟢 |
| Page Size | [value] | <[target] | 🔴/🟡/🟢 |

**Top 3 Issues:**
1. [Issue with biggest impact]
2. [Second biggest issue]
3. [Third biggest issue]

---

### Critical Issues (High Impact)

#### Issue 1: [Title]
**Impact:** [What metric this affects]
**Current State:** [Measurement]
**Root Cause:** [Why this is happening]
**Recommendation:** [Specific fix]
**Effort:** Low / Medium / High
**Expected Improvement:** [Estimated gain]

#### Issue 2: [Title]
...

---

### Moderate Issues (Medium Impact)

#### Issue 1: [Title]
**Impact:** [What this affects]
**Recommendation:** [Fix]
**Effort:** Low / Medium / High

---

### Minor Issues (Low Impact)

- [Issue] - [Quick fix]
- [Issue] - [Quick fix]

---

### Optimization Roadmap

| Priority | Task | Impact | Effort | Owner |
|----------|------|--------|--------|-------|
| P0 | [Critical fix] | High | [effort] | [name] |
| P1 | [Important fix] | Medium | [effort] | [name] |
| P2 | [Nice to have] | Low | [effort] | [name] |

---

### Tools & Next Steps

**Monitoring:**
- Set up [tool] for ongoing monitoring
- Alert thresholds: [recommendations]

**Re-test After:**
- [Milestone or date]
```

---

## Common Performance Issues

### Images

| Issue | Detection | Fix |
|-------|-----------|-----|
| Unoptimized images | Large file sizes | Compress, use WebP/AVIF |
| Missing dimensions | CLS warnings | Add width/height attributes |
| No lazy loading | All images load at once | Add loading="lazy" |
| Wrong format | PNG for photos | Use JPEG/WebP for photos |
| Missing srcset | Large images on mobile | Implement responsive images |

### JavaScript

| Issue | Detection | Fix |
|-------|-----------|-----|
| Large bundles | >200KB main bundle | Code split, tree shake |
| Render blocking | JS in head | Defer or async |
| Unused code | Coverage shows red | Remove or lazy load |
| Long tasks | Main thread blocked | Break up work, use workers |
| Third-party bloat | Waterfall analysis | Lazy load, facade pattern |

### CSS

| Issue | Detection | Fix |
|-------|-----------|-----|
| Render blocking | Large CSS in head | Inline critical CSS |
| Unused CSS | Coverage tool | PurgeCSS, manual audit |
| @import chains | Network waterfall | Use link tags |
| Large frameworks | >50KB CSS | Use subset, utility CSS |

### Network

| Issue | Detection | Fix |
|-------|-----------|-----|
| No compression | Check headers | Enable gzip/brotli |
| No caching | Cache-Control missing | Set appropriate headers |
| No CDN | High TTFB globally | Implement CDN |
| Too many requests | >50 requests | Bundle, sprite, inline |
| No HTTP/2 | Protocol check | Upgrade server |

### Fonts

| Issue | Detection | Fix |
|-------|-----------|-----|
| FOIT/FOUT | Flash of invisible/unstyled | font-display: swap |
| Too many fonts | Multiple families/weights | Reduce to essentials |
| External hosting | Google Fonts | Self-host |
| No preload | Late font loading | Preload critical fonts |

---

## Performance Budget Template

```
## Performance Budget

### Page Weight Limits
| Asset Type | Budget | Current |
|------------|--------|---------|
| HTML | 50KB | |
| CSS | 75KB | |
| JavaScript | 200KB | |
| Images | 500KB | |
| Fonts | 100KB | |
| **Total** | **925KB** | |

### Timing Targets
| Metric | Target |
|--------|--------|
| TTFB | <600ms |
| FCP | <1.5s |
| LCP | <2.5s |
| TTI | <3.5s |

### Request Limits
| Type | Budget |
|------|--------|
| Total requests | <50 |
| Third-party requests | <10 |
```

---

## Quick Wins Checklist

Immediate improvements, minimal effort:

- [ ] Enable compression (gzip/brotli)
- [ ] Add caching headers
- [ ] Optimize and compress images
- [ ] Defer non-critical JavaScript
- [ ] Remove unused CSS/JS
- [ ] Lazy load below-fold images
- [ ] Preload critical assets
- [ ] Self-host fonts with display:swap

---

*Version: 1.0*
