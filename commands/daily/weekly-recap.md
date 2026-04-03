# /weekly-recap

End-of-week summary for personal reflection and planning.

## Trigger

User invokes `/weekly-recap` at the end of a week to review accomplishments, identify patterns, and prepare for the next week.

## Optional MCP Servers

- Google Calendar (completed meetings)
- Notion (completed tasks)
- Gmail (sent/received email volume)

---

## Workflow

### Step 1: Gather Data

If MCP servers available, fetch:
- Meetings attended this week
- Tasks completed (vs planned)
- Email activity
- Any project milestones

If not available, ask:
"What were the highlights of your week? (can be bullet points)"

### Step 2: Reflection Questions

Guide the user through reflection:

1. "What did you accomplish this week that you're most satisfied with?"
2. "What didn't get done that should have?"
3. "What drained your energy vs. gave you energy?"
4. "Any patterns you noticed?"

### Step 3: Generate Recap

```
## Week of [Date Range]

### Accomplishments
- [Major accomplishment 1]
- [Major accomplishment 2]
- [Major accomplishment 3]

### Metrics (if available)
- Meetings: [X] ([change from typical])
- Tasks completed: [X of Y planned]
- [Other relevant metrics]

### Energy Audit
**Energizing:** [What gave energy]
**Draining:** [What drained energy]

### Didn't Get To
- [Item 1] - [Why / What to do about it]
- [Item 2]

### Patterns & Insights
[Observations about the week, trends, realizations]

### Wins to Celebrate
[Something to feel good about, even if small]

### Focus for Next Week
- [Priority 1]
- [Priority 2]
- [Priority 3]
```

### Step 4: Offer Follow-ups

- "Want me to block time for these priorities next week?"
- "Should I save this recap somewhere?"
- "Anything you want to carry forward to Monday's daily brief?"

---

## Reflection Prompts

Use these when energy audit is thin:

**For accomplishments:**
- What moved the needle most?
- What would you do again?

**For drains:**
- What felt like a waste of time?
- What would you delegate or automate?

**For patterns:**
- Did this week feel typical or unusual?
- What would make next week better?

---

## Example Output

```
## Week of March 25-29

### Accomplishments
- Shipped homepage redesign to staging
- Closed deal with Acme Corp ($12k project)
- Hired freelance developer for Q2 overflow

### Metrics
- Meetings: 11 (3 more than usual - lots of client calls)
- Tasks completed: 8 of 12 planned (67%)
- Emails sent: 47

### Energy Audit
**Energizing:** Design deep work on Wednesday, closing the Acme deal
**Draining:** Too many context switches, that 90-min meeting that could've been 30

### Didn't Get To
- Figma AI exploration - keep getting bumped (block time next week)
- Q1 case study writeup - need uninterrupted 2hrs

### Patterns & Insights
Meeting-heavy weeks kill my creative output. Need to protect Wednesday design time better.

### Wins to Celebrate
New client + new hire in the same week. Growth mode.

### Focus for Next Week
- Onboard new developer
- Finish case study (block Thursday AM)
- Start Acme discovery
```

---

*Version: 1.0*
