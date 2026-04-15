# /do:research-summary

Synthesize research into actionable insights. Analyzes multiple sources and produces executive summaries with recommendations.

## Trigger

User invokes `/do:research-summary` when they need to:
- Synthesize findings from multiple sources
- Create executive summaries from research
- Extract patterns and recommendations
- Document research for stakeholders

---

## Workflow

### Step 1: Research Input

"What research do you want to synthesize?"

**Input types:**
- `Topic` — I'll research and synthesize (e.g., "dark mode implementation patterns")
- `URLs` — Provide 2-10 sources to analyze
- `Files` — Point to local research documents
- `Notes` — Paste raw research notes

### Step 2: Output Format

"How should I present the findings?"

**Options:**
- `Executive summary` — High-level findings for stakeholders
- `Technical brief` — Detailed implementation guidance
- `Comparison matrix` — Side-by-side analysis
- `Decision doc` — Recommendation with trade-offs
- `Full report` — Comprehensive documentation

### Step 3: Audience Clarification

"Who will read this?"

**Options:**
- Technical team (engineers, designers)
- Leadership (executives, managers)
- Cross-functional (mixed audience)
- External (clients, partners)

### Step 4: Research & Synthesis

**If researching topic:**
1. Search for authoritative sources
2. Analyze top 5-10 results
3. Extract key findings
4. Identify patterns and contradictions
5. Formulate recommendations

**If analyzing provided sources:**
1. Read/fetch each source
2. Extract key points
3. Cross-reference findings
4. Note agreements and contradictions
5. Synthesize into cohesive summary

### Step 5: Generate Summary

```markdown
## Research Summary: {Topic}

**Date:** {Current date}
**Researcher:** {If applicable}
**Audience:** {Target audience}

---

### Executive Summary

{2-3 paragraph overview of findings and recommendations}

---

### Sources Analyzed

| Source | Type | Key Contribution |
|--------|------|------------------|
| {Source 1} | {Article/Doc/Site} | {What it provided} |
| {Source 2} | {Article/Doc/Site} | {What it provided} |
| {Source 3} | {Article/Doc/Site} | {What it provided} |

---

### Key Findings

**Finding 1: {Title}**
- What we learned: {Summary}
- Evidence: {Supporting data/sources}
- Confidence: {High/Medium/Low}
- Implications: {What this means}

**Finding 2: {Title}**
- What we learned: {Summary}
- Evidence: {Supporting data/sources}
- Confidence: {High/Medium/Low}
- Implications: {What this means}

**Finding 3: {Title}**
- What we learned: {Summary}
- Evidence: {Supporting data/sources}
- Confidence: {High/Medium/Low}
- Implications: {What this means}

---

### Patterns Observed

**Pattern 1: {Name}**
- Observed in: {X} of {Y} sources
- Description: {What the pattern is}
- Relevance: {Why it matters to us}

**Pattern 2: {Name}**
- Observed in: {X} of {Y} sources
- Description: {What the pattern is}
- Relevance: {Why it matters to us}

---

### Contradictions & Open Questions

| Topic | Source A Says | Source B Says | Our Take |
|-------|---------------|---------------|----------|
| {Topic 1} | {Position} | {Position} | {Resolution} |
| {Topic 2} | {Position} | {Position} | {Resolution} |

**Unresolved questions:**
- {Question 1} — needs further research
- {Question 2} — may require testing

---

### Recommendations

**Recommendation 1: {Action}**
- Priority: {High/Medium/Low}
- Effort: {Low/Medium/High}
- Rationale: {Why this is recommended}
- Trade-offs: {What we give up}

**Recommendation 2: {Action}**
- Priority: {High/Medium/Low}
- Effort: {Low/Medium/High}
- Rationale: {Why this is recommended}
- Trade-offs: {What we give up}

**Recommendation 3: {Action}**
- Priority: {High/Medium/Low}
- Effort: {Low/Medium/High}
- Rationale: {Why this is recommended}
- Trade-offs: {What we give up}

---

### Actionable Next Steps

1. **Immediate:** {What to do this week}
2. **Short-term:** {What to do this month}
3. **Long-term:** {What to plan for}

---

### Appendix: Detailed Notes

{Optional section for raw data, extended quotes, etc.}

---

### References

1. {Full citation 1}
2. {Full citation 2}
3. {Full citation 3}
```

---

## Output Format Templates

### Technical Brief Format

```markdown
## Technical Brief: {Topic}

### Overview
{Problem statement and scope}

### Technical Analysis

**Approach A: {Name}**
- How it works: {Technical explanation}
- Pros: {List}
- Cons: {List}
- Example implementation: {Code or reference}

**Approach B: {Name}**
- How it works: {Technical explanation}
- Pros: {List}
- Cons: {List}
- Example implementation: {Code or reference}

### Recommendation
{Which approach and why}

### Implementation Notes
- Dependencies: {What's needed}
- Estimated effort: {Time/complexity}
- Risks: {Potential issues}
```

### Comparison Matrix Format

```markdown
## Comparison: {Topic}

| Criteria | Option A | Option B | Option C |
|----------|----------|----------|----------|
| {Criterion 1} | {Rating/Value} | {Rating/Value} | {Rating/Value} |
| {Criterion 2} | {Rating/Value} | {Rating/Value} | {Rating/Value} |
| {Criterion 3} | {Rating/Value} | {Rating/Value} | {Rating/Value} |
| **Score** | {Total} | {Total} | {Total} |

### Analysis
{Interpretation of the comparison}

### Recommendation
{Which option and why}
```

---

## Integration Points

### Website Intelligence

Uses `website-intelligence` for:
- Deep site analysis
- Pattern extraction
- Content summarization

### Firecrawl Tools

Uses firecrawl for:
- Multi-source research
- Content extraction
- Structured data gathering

---

## Example Session

**User:** `/do:research-summary`

**Claude:** "What research do you want to synthesize?"

**User:** "Dark mode implementation patterns"

**Claude:** "How should I present the findings?"

**User:** "Technical brief for the engineering team"

**Claude:** *Researches topic, analyzes sources*

```markdown
## Research Summary: Dark Mode Implementation Patterns

**Audience:** Engineering team
**Sources:** 12 competitor apps, 3 design system docs, 5 a11y guidelines

---

### Key Findings

**Pattern 1: System Preference Detection**
- 11/12 competitors auto-detect OS preference
- All provide manual toggle
- Best practice: Default to system, persist user choice

**Pattern 2: Color Token Strategy**
- Semantic tokens (--bg-primary) vs mode-specific (--bg-dark)
- 8/12 use semantic approach
- Recommendation: Semantic tokens reduce maintenance

**Pattern 3: Transition Handling**
- Instant switch: 7 apps
- Animated transition: 5 apps
- User preference data is split
- Recommendation: Subtle 200ms fade, no flash

---

### Actionable Next Steps

1. Add `prefers-color-scheme` media query detection
2. Create semantic color token layer
3. Implement localStorage preference persistence
4. Test transitions for WCAG motion preferences
```

---

## Error Handling

| Error | Response |
|-------|----------|
| No sources found | "Couldn't find enough sources on this topic. Can you provide specific URLs?" |
| Sources inaccessible | "Can't access {source}. Continuing with available sources." |
| Conflicting research | "Found significant contradictions. Highlighting these in the summary." |
| Topic too broad | "This is a broad topic. Can you narrow it down?" |

---

*Version: 1.0*
