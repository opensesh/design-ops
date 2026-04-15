# /do:content-brief

Create structured content briefs for articles, blog posts, case studies, and other long-form content.

## Trigger

User invokes `/do:content-brief` when planning:
- Blog posts and articles
- Case studies
- Tutorials and how-to guides
- Newsletter issues
- Documentation pages

---

## Workflow

### Step 1: Content Type Selection

"What type of content are you creating?"

**Options:**
- `Blog post` — Thought leadership, updates, insights
- `Case study` — Project showcase with results
- `Tutorial` — Step-by-step how-to guide
- `Newsletter` — Email newsletter issue
- `Documentation` — Technical docs or guides
- `Other` — Custom format

### Step 2: Topic & Context

"What's the topic? And who's the target audience?"

**Gather:**
- Main topic or title idea
- Target audience (who reads this?)
- Publishing context (blog, newsletter, etc.)
- Key message or takeaway

### Step 3: Goal Clarification

"What's the goal of this content?"

**Options:**
- Establish thought leadership
- Drive conversions/signups
- Educate the audience
- Build brand awareness
- Document a process
- Share results/outcomes

### Step 4: Generate Brief

```markdown
## Content Brief: {Title/Topic}

**Type:** {Content type}
**Target audience:** {Audience description}
**Goal:** {Primary goal}
**Estimated length:** {Word count range}
**Publish channel:** {Where it will live}

---

### Hook (50-75 words)

{Opening paragraph guidance}

- Lead with: {Specific hook strategy}
- Key stat or question to open with: {Suggestion}
- Avoid: {What not to do}

**Example opening:**
> "{Sample first sentence or two}"

---

### Outline

**Introduction (100-150 words)**
- Hook the reader with {specific approach}
- Establish the problem or opportunity
- Promise what they'll learn

**Section 1: {Title} (200-300 words)**
- Key point: {Main idea}
- Supporting details:
  - {Detail 1}
  - {Detail 2}
  - {Detail 3}
- Transition to next section: {How to bridge}

**Section 2: {Title} (200-300 words)**
- Key point: {Main idea}
- Supporting details:
  - {Detail 1}
  - {Detail 2}
  - {Detail 3}
- Example or evidence: {What to include}

**Section 3: {Title} (200-300 words)**
- Key point: {Main idea}
- Supporting details:
  - {Detail 1}
  - {Detail 2}
  - {Detail 3}
- Practical application: {How reader uses this}

**Conclusion (100-150 words)**
- Summarize key takeaways
- Reinforce main message
- Include CTA: {Specific call-to-action}

---

### Key Messages

The reader should walk away with:

1. **Primary takeaway:** {One sentence}
2. **Secondary takeaway:** {One sentence}
3. **Action item:** {What they should do next}

---

### SEO Considerations

**Target keyword:** {Primary keyword}
**Secondary keywords:** {2-3 related keywords}
**Suggested meta description:** "{150-160 character description}"

**Internal links to include:**
- {Related article 1}
- {Related article 2}

**External links to consider:**
- {Authoritative source 1}
- {Authoritative source 2}

---

### Visual Needs

- **Hero image:** {Description/requirements}
- **Section graphics:** {What's needed}
- **Diagrams/charts:** {If applicable}
- **Screenshots:** {If applicable}

---

### Brand Voice Notes

- Use "we" not "I"
- Show vulnerability in learnings
- Data-first, not opinion-first
- Smart but not smug
- {Additional voice guidance}

---

### Research Needed

- [ ] {Research item 1}
- [ ] {Research item 2}
- [ ] {Research item 3}

---

### CTA

**Primary CTA:** {What action to drive}
**CTA copy suggestion:** "{Suggested CTA text}"
**Link to:** {Where CTA goes}

---

### Timeline

- **Research due:** {Date}
- **First draft due:** {Date}
- **Review round:** {Date}
- **Publish date:** {Date}

---

### Additional Notes

{Any other context, requirements, or considerations}
```

---

## Content Type Templates

### Case Study Brief

Additional sections for case studies:

```markdown
### Case Study Structure

**Client overview (50 words)**
- Who they are
- Industry/size
- Why they came to us

**Challenge (100-150 words)**
- What problem they faced
- Why it mattered
- Previous attempts/failures

**Solution (200-300 words)**
- What we did
- Key decisions made
- Timeline overview

**Results (100-150 words)**
- Quantified outcomes
- Before/after comparison
- Client testimonial

**Learnings (100 words)**
- What we'd do differently
- Unexpected insights

### Required Assets

- [ ] Client logo (approved for use)
- [ ] Before screenshots
- [ ] After screenshots
- [ ] Key metrics/data
- [ ] Client testimonial quote
```

### Tutorial Brief

Additional sections for tutorials:

```markdown
### Tutorial Structure

**Prerequisites**
- What reader needs before starting
- Required tools/access
- Skill level assumed

**Steps**
1. Step 1: {Title} — {Brief description}
2. Step 2: {Title} — {Brief description}
3. Step 3: {Title} — {Brief description}
[etc.]

**Code samples needed**
- [ ] {Sample 1}
- [ ] {Sample 2}

**Common errors to address**
- Error 1: {What happens, how to fix}
- Error 2: {What happens, how to fix}

**Success criteria**
- How reader knows they did it right
```

---

## Example Session

**User:** `/do:content-brief`

**Claude:** "What type of content are you creating?"

**User:** "Case study about our pricing page redesign"

**Claude:** "Who's the target audience?"

**User:** "SaaS founders and product designers"

**Claude:** "What's the main goal?"

**User:** "Show our design process and generate leads"

**Claude:**

```markdown
## Content Brief: How We Redesigned Our Pricing Page

**Type:** Case Study
**Target audience:** SaaS founders, product designers
**Goal:** Demonstrate design process, generate leads
**Estimated length:** 1,200-1,500 words
**Publish channel:** Blog + email

---

### Hook (50 words)

Lead with the result, then rewind. "Pricing page conversion was 2.3%. After redesign: 4.1% (+78%). Here's exactly how we did it."

---

### Outline

**The Problem (150 words)**
- What wasn't working
- Data that proved it
- Hypothesis we formed

**Our Process (300 words)**
- Research phase (what we analyzed)
- Design explorations (variations tested)
- Testing methodology

**Key Decisions (250 words)**
- Decision 1: {What and why}
- Decision 2: {What and why}
- Decision 3: {What and why}

**Results (100 words)**
- Key metrics improvement
- Unexpected learnings
- What we'd do differently

**CTA (50 words)**
- "Want similar results? Let's talk."

---

### Required Assets

- [ ] Before/after screenshots
- [ ] Metrics data (anonymized if needed)
- [ ] Process photos or wireframes

### Brand Voice

- Show the messy middle, not just the win
- Be specific with numbers
- Credit the team, not just "we"
```

---

## Error Handling

| Error | Response |
|-------|----------|
| No topic provided | "What's the topic? Give me a title or general idea." |
| Too vague | "Can you be more specific? Who's reading this and why?" |
| No audience defined | "Who's the target audience? This helps me tailor the brief." |

---

*Version: 1.0*
