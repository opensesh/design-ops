# /pre-mortem

"Imagine this failed—why?" Future-failure analysis before execution to identify risks and prevent problems.

## Trigger

User invokes `/pre-mortem` before launching a project, making a decision, or starting an initiative they want to de-risk.

---

## Purpose

A pre-mortem is the opposite of a post-mortem: instead of analyzing why something failed after the fact, we imagine the failure in advance and work backwards to identify what could cause it.

This technique:
- Surfaces risks people are hesitant to voice
- Overcomes optimism bias
- Identifies preventable failure modes
- Creates contingency plans before they're needed

---

## Workflow

### Step 1: Understand the Initiative

Ask:
- "What are you planning to do?"
- "What does success look like?"
- "When is this happening / what's the timeline?"

### Step 2: Set the Scene

Frame the exercise:

"Imagine it's [timeline end date]. This initiative has completely failed. Not just underperformed—failed.

Take a moment to consider: **What went wrong?**"

### Step 3: Generate Failure Scenarios

Systematically explore failure modes across categories:

**Execution Failures**
- What if we couldn't deliver on time?
- What if the quality wasn't good enough?
- What if key people were unavailable?

**Assumption Failures**
- What if our core assumption was wrong?
- What if the market/audience didn't want this?
- What if the timing was off?

**External Failures**
- What if a competitor beat us?
- What if circumstances changed?
- What if dependencies failed?

**Communication Failures**
- What if stakeholders weren't aligned?
- What if expectations weren't managed?
- What if we solved the wrong problem?

**Resource Failures**
- What if we ran out of budget?
- What if scope crept beyond capacity?
- What if we underestimated complexity?

### Step 4: Present Analysis

```
## Pre-Mortem: [Initiative Name]

**The scenario:** It's [future date]. This has failed completely.

### Most Likely Failure Modes

1. **[Failure Mode]**
   - What happened: [Description]
   - Warning signs: [Early indicators]
   - Prevention: [What we can do now]

2. **[Failure Mode]**
   - What happened: [Description]
   - Warning signs: [Early indicators]
   - Prevention: [What we can do now]

3. **[Failure Mode]**
   - What happened: [Description]
   - Warning signs: [Early indicators]
   - Prevention: [What we can do now]

### Hidden Assumptions to Validate

- [Assumption 1] - How to test: [Method]
- [Assumption 2] - How to test: [Method]

### Contingency Triggers

| If this happens... | Then we should... |
|--------------------|-------------------|
| [Warning sign 1] | [Response] |
| [Warning sign 2] | [Response] |

### Recommended Pre-Actions

1. [Action to take before starting]
2. [Action to take before starting]
3. [Action to take before starting]
```

### Step 5: Action Planning

After presenting:

- "Which of these risks feels most likely?"
- "Which would be most catastrophic if it happened?"
- "What can we do this week to mitigate the top risks?"

---

## Facilitation Tips

**Draw out specific scenarios:**
- "Be specific—what exactly went wrong?"
- "Who was involved in this failure?"
- "When did you first realize it was going wrong?"

**Push past the obvious:**
- "That's one way it could fail. What else?"
- "What if it failed in a completely different way?"
- "What's the failure mode nobody wants to talk about?"

---

## Example

**User:** `/pre-mortem`

**Claude:** "What are you planning to do?"

**User:** "We're launching a new product line—premium design templates for startups. Launching in 6 weeks."

**Claude:** "What does success look like?"

**User:** "$20k revenue in first month, 500 customers"

**Claude generates:**

```
## Pre-Mortem: Premium Design Templates Launch

**The scenario:** It's 6 weeks from now. The launch failed—barely $2k revenue, 50 customers.

### Most Likely Failure Modes

1. **Wrong Audience/Channel**
   - What happened: We marketed to designers who make their own templates, not to startup founders who buy them
   - Warning signs: High traffic, low conversion; lots of "cool but I don't need this" feedback
   - Prevention: Pre-launch interviews with 10 actual startup founders (not designers) to validate demand and messaging

2. **Price Anchoring Problem**
   - What happened: Premium pricing seemed unreasonable compared to cheap Envato alternatives
   - Warning signs: "Too expensive" in feedback; abandoned carts at payment
   - Prevention: Build clear value narrative (time saved, professional quality, support); consider launch discount

3. **Launch Window Visibility**
   - What happened: Launch got lost in the noise; no distribution channel established
   - Warning signs: Low traffic despite launch efforts; relying on "build it and they'll come"
   - Prevention: Start building email list NOW; line up 3-5 launch partners; prep Product Hunt

4. **Template Quality Gap**
   - What happened: Templates didn't feel "premium" enough to justify price; generic-looking
   - Warning signs: Returns or complaints about quality; unfavorable comparisons
   - Prevention: Get brutal feedback from 5 potential buyers BEFORE launch; ensure templates solve real problems

### Hidden Assumptions to Validate

- "Startups will pay premium for templates" - Test: Pre-sell to 10 founders
- "Our templates are differentiated" - Test: Blind comparison against top 3 competitors
- "6 weeks is enough time" - Test: Scope audit now—cut ruthlessly if needed

### Contingency Triggers

| If this happens... | Then we should... |
|--------------------|-------------------|
| Pre-sales < 20 | Delay launch, revisit positioning |
| Launch day traffic < 1000 | Activate paid acquisition immediately |
| Conversion < 1% | Emergency pricing/messaging test |

### Recommended Pre-Actions

1. This week: Interview 10 startup founders about template buying habits
2. Week 2: Pre-sell at 50% discount to validate demand
3. Week 3: Lock scope—no new templates, polish existing ones
4. Week 4: Build launch distribution (email, partners, PH prep)
```

---

*Version: 1.0*
