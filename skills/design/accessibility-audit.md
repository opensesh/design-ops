# Accessibility Audit

WCAG compliance checking and accessibility issue identification for digital products.

## Purpose

Evaluate designs, code, or live sites for accessibility compliance. Identify issues that would prevent users with disabilities from using the product effectively.

## When to Activate

Use this skill when:
- Reviewing designs before development
- Auditing existing websites or applications
- Checking components for WCAG compliance
- Preparing for accessibility certification

---

## WCAG Compliance Levels

**Level A** - Minimum accessibility requirements
**Level AA** - Standard compliance target (most common requirement)
**Level AAA** - Highest level, not always achievable for all content

Default target: **WCAG 2.1 Level AA** unless specified otherwise.

---

## Audit Process

### Step 1: Determine Scope

Ask:
- "What am I auditing? (design file, live URL, code component)"
- "What compliance level are you targeting?"
- "Any specific areas of concern?"

### Step 2: Systematic Review

Evaluate against these categories:

**1. Perceivable**
- Text alternatives for images
- Captions/transcripts for media
- Color contrast ratios
- Text resizing without loss
- Content structure and hierarchy

**2. Operable**
- Keyboard accessibility
- Focus indicators
- Skip navigation
- No seizure-inducing content
- Touch target sizes (mobile)

**3. Understandable**
- Readable text
- Predictable navigation
- Input assistance and error handling
- Consistent components

**4. Robust**
- Valid HTML/ARIA
- Compatible with assistive technologies
- Name, role, value for custom components

### Step 3: Generate Report

```
## Accessibility Audit Report

**Subject:** [What was audited]
**Date:** [Date]
**Target Compliance:** WCAG 2.1 Level [A/AA/AAA]
**Auditor:** Claude

---

### Summary

**Issues Found:** [X total]
- Critical (Level A failures): [X]
- Major (Level AA failures): [X]
- Minor (Best practices): [X]

**Overall Status:** [Pass / Fail / Conditional Pass]

---

### Critical Issues (Must Fix)

#### Issue 1: [Title]
**WCAG Criterion:** [X.X.X - Name]
**Location:** [Where found]
**Problem:** [Description]
**Impact:** [Who is affected and how]
**Fix:** [How to resolve]

#### Issue 2: [Title]
...

---

### Major Issues (Should Fix)

#### Issue 1: [Title]
**WCAG Criterion:** [X.X.X - Name]
**Location:** [Where found]
**Problem:** [Description]
**Fix:** [How to resolve]

---

### Minor Issues (Consider Fixing)

- [Issue] - [Location] - [Quick fix]
- [Issue] - [Location] - [Quick fix]

---

### Passed Criteria

✅ [Criterion] - [How it passes]
✅ [Criterion] - [How it passes]

---

### Recommendations

1. [Priority recommendation]
2. [Secondary recommendation]
3. [Future consideration]

---

### Testing Notes

**Tools Used:** [Any automated tools mentioned]
**Manual Tests Performed:** [Key manual checks]
**Limitations:** [What couldn't be tested]
```

---

## Common Issues by Category

### Color & Contrast

| Issue | WCAG | Requirement |
|-------|------|-------------|
| Text contrast | 1.4.3 | 4.5:1 minimum (normal text) |
| Large text contrast | 1.4.3 | 3:1 minimum (18pt+ or 14pt bold) |
| Non-text contrast | 1.4.11 | 3:1 for UI components |
| Color-only info | 1.4.1 | Don't rely solely on color |

### Keyboard & Focus

| Issue | WCAG | Requirement |
|-------|------|-------------|
| Keyboard access | 2.1.1 | All functionality via keyboard |
| No keyboard traps | 2.1.2 | Focus can always escape |
| Focus visible | 2.4.7 | Focus indicator visible |
| Focus order | 2.4.3 | Logical tab sequence |

### Images & Media

| Issue | WCAG | Requirement |
|-------|------|-------------|
| Image alt text | 1.1.1 | All images have alt (or alt="") |
| Complex images | 1.1.1 | Long description for charts/infographics |
| Video captions | 1.2.2 | Synchronized captions |
| Audio descriptions | 1.2.5 | For meaningful visuals |

### Forms & Inputs

| Issue | WCAG | Requirement |
|-------|------|-------------|
| Form labels | 1.3.1 | All inputs have labels |
| Error identification | 3.3.1 | Errors clearly described |
| Error suggestions | 3.3.3 | Help users fix errors |
| Required fields | 3.3.2 | Clear indication |

### Structure & Navigation

| Issue | WCAG | Requirement |
|-------|------|-------------|
| Heading hierarchy | 1.3.1 | Logical H1-H6 structure |
| Landmarks | 1.3.1 | Main, nav, header, footer |
| Skip links | 2.4.1 | Skip to main content |
| Page titles | 2.4.2 | Descriptive page titles |

---

## Quick Checks

For rapid assessment, check these first:

1. **Zoom to 200%** - Does layout break?
2. **Keyboard only** - Can you navigate and interact?
3. **Color contrast** - Use a contrast checker
4. **Images** - Do they have meaningful alt text?
5. **Forms** - Are all inputs labeled?
6. **Headings** - Logical hierarchy?

---

## Tools Reference

**Automated Testing:**
- axe DevTools (browser extension)
- WAVE (web accessibility evaluation)
- Lighthouse (Chrome DevTools)

**Manual Testing:**
- Screen reader (NVDA, VoiceOver, JAWS)
- Keyboard-only navigation
- Zoom testing (200%+)

**Contrast Checkers:**
- WebAIM Contrast Checker
- Stark (Figma plugin)
- Color Contrast Analyzer

---

## Severity Definitions

**Critical:** Completely blocks access for some users. Legal risk.
**Major:** Significant barrier but workarounds may exist.
**Minor:** Inconvenience but doesn't block access.

---

*Version: 1.0*
