# /case-study

Generate a case study draft from project data and outcomes.

## Trigger

User invokes `/case-study` to document a completed project as a portfolio piece or marketing asset.

---

## Workflow

### Step 1: Gather Project Information

Interview the user:

1. **Basic Info**
   - "What was the project/client name?"
   - "What was the timeline?"
   - "What was your role?"

2. **The Challenge**
   - "What problem were you solving?"
   - "Why did the client come to you?"
   - "What constraints or challenges existed?"

3. **The Process**
   - "Walk me through your approach (high-level steps)"
   - "Were there any pivots or unexpected changes?"
   - "What tools/methods did you use?"

4. **The Solution**
   - "What did you deliver?"
   - "What made your approach unique?"

5. **The Results**
   - "What were the measurable outcomes?"
   - "Any qualitative feedback from the client?"
   - "What's the before/after?"

6. **Assets**
   - "Do you have images, screenshots, or deliverables to include?"

### Step 2: Generate Case Study Draft

```
# [Project Name]

## Overview

**Client:** [Client name/industry]
**Timeline:** [Duration]
**Role:** [Your role]
**Services:** [What you provided]

[1-2 sentence summary of the project and outcome]

---

## The Challenge

[2-3 paragraphs describing:]
- Who the client was and their situation
- The specific problem they faced
- Why it mattered / stakes involved
- Constraints (budget, timeline, technical)

---

## The Approach

### Discovery
[How you understood the problem]

### Strategy
[Your plan of attack]

### Execution
[Key phases of work]

---

## The Solution

[2-3 paragraphs describing what you delivered]

[Visual placeholder: "INSERT: Key deliverable images here"]

**Key Features:**
- [Feature 1]
- [Feature 2]
- [Feature 3]

---

## The Results

### By the Numbers
- [Metric 1]: [Before] → [After] ([% change])
- [Metric 2]: [Before] → [After]
- [Metric 3]: [Result]

### Client Feedback
> "[Quote from client]"
> — [Name, Title]

---

## Key Takeaways

- [Insight 1 - what you learned]
- [Insight 2 - what worked well]
- [Insight 3 - what you'd do differently]

---

## Project Details

**Team:** [Who was involved]
**Tools:** [Software, frameworks used]
**Deliverables:** [List of outputs]
```

### Step 3: Refine

After generating:

- "Want me to adjust the tone? (more formal/casual)"
- "Should I expand any section?"
- "Missing any outcomes we should add?"
- "Want a shortened version for social media?"

---

## Writing Guidelines

**Voice:**
- First person plural ("We discovered...") for agency work
- First person singular ("I designed...") for freelance/personal
- Active voice throughout

**Length:**
- Full case study: 800-1200 words
- Summary version: 200-300 words

**Emphasis:**
- Lead with results when impressive
- Lead with challenge when story is compelling
- Always include specific numbers

**Avoid:**
- Jargon that doesn't add value
- Vague claims without evidence
- Overlong process descriptions

---

## Example Interview

**Claude:** "What was the project?"

**User:** "Redesigned an e-commerce checkout for a sustainable fashion brand"

**Claude:** "What was the problem?"

**User:** "Cart abandonment was really high—like 78%. The checkout was confusing and didn't build trust."

**Claude:** "What was your approach?"

**User:** "Audited the existing flow, did user testing, simplified to 3 steps, added trust signals"

**Claude:** "What were the results?"

**User:** "Abandonment dropped to 52%, AOV went up 18%, client was thrilled"

**Claude generates the case study...**

---

## Variations

**Short version (portfolio card):**
```
## Sustainable Fashion Checkout Redesign

Reduced cart abandonment from 78% to 52% and increased average order value by 18% through a streamlined 3-step checkout with strategic trust signals.

**Services:** UX Audit, UI Design, User Testing
**Timeline:** 6 weeks
```

**LinkedIn version:**
```
Just shipped a checkout redesign that dropped cart abandonment by 33%.

The old flow: 5 confusing steps, no trust signals, 78% abandonment.

The new flow:
→ 3 clear steps
→ Progress indicator
→ Trust badges at payment
→ Guest checkout option

Results after 30 days:
- Abandonment: 78% → 52%
- Average order value: +18%
- Mobile conversions: +24%

Sometimes the biggest wins come from simplifying what's already there.
```

---

*Version: 1.0*
