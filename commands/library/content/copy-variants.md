# /do:copy-variants

Generate and score copy variations for A/B testing. Creates multiple headline, CTA, and body copy options aligned with brand voice.

## Trigger

User invokes `/do:copy-variants` when they need multiple copy options for:
- Headlines and taglines
- CTA buttons and links
- Email subject lines
- Ad copy variations
- Landing page sections

---

## Workflow

### Step 1: Context Gathering

"What copy do you need variations for?"

**Input types:**
- Existing copy to improve
- New copy requirements
- Campaign context
- Target audience

### Step 2: Copy Type Selection

"What type of copy is this?"

**Options:**
- `Headline` — Primary attention grabber
- `CTA` — Call-to-action button/link
- `Subject line` — Email subject
- `Body copy` — Paragraph or section
- `Tagline` — Brand/campaign slogan
- `Ad copy` — Paid advertising text

### Step 3: Goal Clarification

"What's the primary goal?"

**Options:**
- Drive clicks/conversions
- Build brand awareness
- Educate the audience
- Create urgency
- Establish trust
- Differentiate from competitors

### Step 4: Generate Variations

```markdown
## Copy Variants: {Type}

**Context:** {User's context}
**Goal:** {Selected goal}
**Brand voice:** {From config or "friendly, technical, concise"}

---

### Headlines (ranked by brand alignment)

**1. "{Headline 1}"** — Rating: ★★★★★
- Why it works: {Specific reason}
- Trade-off: {Any downside}
- Best for: {Use case}

**2. "{Headline 2}"** — Rating: ★★★★☆
- Why it works: {Specific reason}
- Trade-off: {Any downside}
- Best for: {Use case}

**3. "{Headline 3}"** — Rating: ★★★☆☆
- Why it works: {Specific reason}
- Trade-off: {Any downside}
- Best for: {Use case}

**4. "{Headline 4}"** — Rating: ★★★☆☆
- Why it works: {Specific reason}
- Trade-off: {Any downside}
- Best for: {Use case}

**5. "{Headline 5}"** — Rating: ★★☆☆☆
- Why it works: {Specific reason}
- Trade-off: {Any downside}
- Best for: {Use case}

---

### CTAs (for pairing)

| CTA | Tone | Best paired with |
|-----|------|------------------|
| "Start building" | Active, empowering | Headlines 1, 2 |
| "Try it free" | Low commitment | Headlines 3, 4 |
| "See how it works" | Curious, exploratory | Headlines 4, 5 |
| "Get started" | Direct, clear | Any headline |
| "Join 5,000 makers" | Social proof | Headlines 1, 2 |

---

### Recommended Pairings

**High-conversion pairing:**
- Headline: "{Headline 1}"
- CTA: "{CTA 1}"
- Why: {Reason this combo works}

**Brand-building pairing:**
- Headline: "{Headline 2}"
- CTA: "{CTA 2}"
- Why: {Reason this combo works}

---

### A/B Test Suggestions

**Test 1: Value prop clarity**
- Control: "{Current or Headline 1}"
- Variant: "{Headline 3}"
- Hypothesis: {What you'll learn}
- Key metric: {What to measure}

**Test 2: CTA language**
- Control: "Get started"
- Variant: "Start building"
- Hypothesis: Active language may increase engagement
- Key metric: Click-through rate

---

### Brand Voice Scorecard

| Criterion | Score | Notes |
|-----------|-------|-------|
| Clarity | ★★★★★ | All options are direct and clear |
| Brand alignment | ★★★★☆ | Most match "steward" voice |
| Differentiation | ★★★☆☆ | Some options feel generic |
| Emotional resonance | ★★★★☆ | Strong on empowerment |
```

---

## Brand Voice Integration

When brand config exists, score against:

**Open Session voice guidelines:**
- Smart but not smug
- Technical but accessible
- Confident but humble
- "Steward, not advisor" positioning

**Scoring criteria:**
- Does it sound like us?
- Would our audience resonate?
- Does it differentiate from competitors?
- Is it memorable?

---

## Example Session

**User:** `/do:copy-variants`

**Claude:** "What copy do you need variations for?"

**User:** "Newsletter signup CTA for our blog"

**Claude:** "What type of copy? I'll generate headlines and CTAs."

**User:** "Both headline and CTA"

**Claude:** "What's the primary goal?"

**User:** "Drive signups, build our email list"

**Claude:**

```markdown
## Copy Variants: Newsletter Signup

**Context:** Blog newsletter signup
**Goal:** Drive signups, list building
**Brand voice:** Smart, accessible, steward positioning

---

### Headlines (ranked)

**1. "Join 5,000 designers building better products"** — ★★★★★
- Why: Specific number builds credibility, "building" aligns with maker identity
- Trade-off: Need to keep number updated
- Best for: Social proof-motivated signups

**2. "Design insights, weekly. No fluff."** — ★★★★★
- Why: Clear value prop, anti-fluff stance is differentiating
- Trade-off: May feel cold to some
- Best for: Efficiency-focused readers

**3. "Get weekly design insights delivered"** — ★★★★☆
- Why: Clear, direct, low-risk promise
- Trade-off: Somewhat generic
- Best for: Broad appeal

**4. "Level up your design practice"** — ★★★☆☆
- Why: Growth-oriented, aspirational
- Trade-off: "Level up" is overused
- Best for: Career-focused audience

**5. "Never miss a design trend"** — ★★★☆☆
- Why: FOMO angle
- Trade-off: Fear-based, less aligned with brand
- Best for: Trend-conscious designers

---

### CTAs

| CTA | Tone | Rating |
|-----|------|--------|
| "Start learning" | Active, growth-oriented | ★★★★★ |
| "Join the list" | Community feel | ★★★★☆ |
| "Subscribe free" | Transactional, low barrier | ★★★☆☆ |
| "Get weekly insights" | Value-focused | ★★★★☆ |

---

### Recommended Pairing

**Headline:** "Join 5,000 designers building better products"
**CTA:** "Start learning"
**Why:** Social proof + active CTA creates momentum
```

---

## Error Handling

| Error | Response |
|-------|----------|
| No context provided | "What's the copy for? Give me some context about the product/campaign." |
| Too broad | "Can you narrow it down? Are we talking headlines, CTAs, or body copy?" |
| No brand config | "No brand voice configured. I'll use general best practices." |

---

*Version: 1.0*
