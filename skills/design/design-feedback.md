# Design Feedback

Provide structured, actionable feedback on visual designs.

## Purpose

This skill enables constructive design critique that helps designers improve their work through specific, objective observations rather than vague opinions.

## When to Activate

Use this skill when:
- Reviewing mockups, wireframes, or prototypes
- Preparing design critique for team reviews
- Documenting feedback for async design reviews
- Helping non-designers articulate design concerns

## Instructions

### Core Behavior

Approach design feedback with:
1. **Objectivity** - Focus on how design serves goals, not personal preference
2. **Specificity** - Point to exact elements, not general impressions
3. **Constructiveness** - Suggest improvements, don't just identify problems

### Feedback Framework

Evaluate designs across these dimensions:

| Category | What to Assess |
|----------|----------------|
| Hierarchy | Visual weight, reading order, emphasis |
| Consistency | Spacing, typography, component usage |
| Clarity | Message comprehension, user orientation |
| Accessibility | Contrast, text size, touch targets |
| Brand Alignment | Voice, style, identity adherence |

### Process

1. **Understand context** - What is this design trying to achieve?
2. **First impression** - What do you notice immediately?
3. **Systematic review** - Walk through each feedback category
4. **Prioritize** - Rank issues by impact
5. **Suggest solutions** - Offer concrete alternatives

### Output Format

Structure feedback as:

```
## Overview
[1-2 sentence summary of design strengths and main opportunity]

## What's Working
- [Specific positive observation]
- [Specific positive observation]

## Opportunities
### [Issue Title]
**Observation:** [What you see]
**Impact:** [Why it matters]
**Suggestion:** [How to improve]

## Priority Actions
1. [Most important change]
2. [Second priority]
3. [Third priority]
```

## Constraints

- Never say "I don't like" — always explain why something doesn't work
- Avoid subjective color preferences unless they affect usability
- Don't provide feedback without understanding the design's purpose
- Limit feedback to actionable items (max 5-7 per review)

## Examples

### Example 1: Landing Page Review

**Input:**
```
Review this landing page mockup for our SaaS product.
Goal: Drive free trial signups.
```

**Output:**
```
## Overview
Strong visual hierarchy guides users toward the CTA. The primary
opportunity is improving the value proposition clarity above the fold.

## What's Working
- CTA button has clear visual prominence with good contrast
- Social proof section builds credibility effectively
- Consistent spacing creates professional rhythm

## Opportunities

### Headline Clarity
**Observation:** Current headline "Transform Your Workflow" is generic
**Impact:** Users can't quickly understand what the product does
**Suggestion:** Lead with specific outcome: "Cut Meeting Time in Half
with AI-Powered Scheduling"

### Mobile CTA Visibility
**Observation:** Primary CTA falls below fold on mobile viewport
**Impact:** ~60% of traffic may miss the signup prompt
**Suggestion:** Add sticky mobile CTA or move above feature grid

## Priority Actions
1. Revise headline for specificity
2. Ensure CTA visible on mobile without scrolling
3. Add micro-copy under CTA explaining what happens next
```

## Related Skills

- brand-guidelines
- accessibility-review

---

*Version: 1.0 | Last Updated: 2024-01*
