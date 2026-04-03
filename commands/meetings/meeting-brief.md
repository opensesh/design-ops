# /meeting-brief

Interactive workflow to create a focused meeting agenda through guided questions.

## Trigger

User invokes `/meeting-brief` before an upcoming meeting to prepare an effective agenda.

## Optional MCP Servers

- Google Calendar (to update the event with the agenda)

---

## Workflow

### Step 1: Interview

Ask these questions one at a time, adapting based on answers:

1. **Meeting Context**
   "What's this meeting for? (e.g., project kickoff, status check, decision-making, brainstorm)"

2. **Attendees**
   "Who's attending and what are their roles?"

3. **Topics**
   "What topics need to be covered? List them in order of priority."

4. **Outcomes**
   "What decisions or outcomes do you need from this meeting?"

5. **Time**
   "How long is the meeting? (helps with time allocation)"

6. **Prep Required**
   "Is there anything attendees should review beforehand?"

### Step 2: Generate Agenda

Based on the interview, create a structured agenda:

```
## [Meeting Title]

**Date:** [If known]
**Duration:** [X minutes]
**Attendees:** [Names]

### Pre-Meeting
- [Any prep work or materials to review]

### Agenda

| Time | Topic | Owner | Goal |
|------|-------|-------|------|
| 0:00 | Opening & context | [Host] | Align on purpose |
| 0:05 | [Topic 1] | [Owner] | [Specific outcome] |
| ... | ... | ... | ... |
| [End-5] | Action items & next steps | All | Clear owners & deadlines |

### Desired Outcomes
- [ ] [Outcome 1]
- [ ] [Outcome 2]

### Parking Lot
(For topics that arise but aren't agenda items)
```

### Step 3: Offer Follow-ups

After presenting the agenda, ask:

- "Want me to add this agenda to your calendar event?"
- "Should I draft a pre-meeting email to attendees?"
- "Any adjustments to the timing or topics?"

---

## Time Allocation Guidelines

Use these defaults when allocating time:

| Meeting Length | Opening | Main Topics | Wrap-up |
|---------------|---------|-------------|---------|
| 30 min | 2 min | 23 min | 5 min |
| 60 min | 5 min | 45 min | 10 min |
| 90 min | 5 min | 70 min | 15 min |

For multiple topics, weight by priority:
- High priority: 40% of topic time
- Medium priority: 35% of topic time
- Low priority: 25% of topic time

---

## Agenda Best Practices

Built into the output:

1. **Every topic has an owner** - Someone responsible for leading it
2. **Every topic has a goal** - "Discuss X" is weak; "Decide X" is strong
3. **Time-boxed** - Prevents runaway discussions
4. **Outcomes are specific** - Checkboxes, not vague hopes
5. **Buffer exists** - Always end 5 min early for wrap-up

---

## Example Interaction

**User:** `/meeting-brief`

**Claude:** "What's this meeting for?"

**User:** "Quarterly planning with the design team"

**Claude:** "Who's attending and what are their roles?"

**User:** "Me (Creative Director), Sarah (Lead Designer), Jake (Junior Designer), Lisa (Project Manager)"

**Claude:** "What topics need to be covered? List them in order of priority."

**User:** "Review Q1 results, set Q2 goals, discuss new tooling"

**Claude:** "What decisions or outcomes do you need from this meeting?"

**User:** "Agree on Q2 priorities, decide if we're adopting Figma AI"

**Claude:** "How long is the meeting?"

**User:** "60 minutes"

**Claude:** "Is there anything attendees should review beforehand?"

**User:** "Q1 metrics dashboard"

**Claude generates:**

```
## Q2 Design Team Planning

**Duration:** 60 minutes
**Attendees:** Alex (CD), Sarah (Lead), Jake (Junior), Lisa (PM)

### Pre-Meeting
- Review Q1 metrics dashboard

### Agenda

| Time | Topic | Owner | Goal |
|------|-------|-------|------|
| 0:00 | Opening | Alex | Set context for Q2 planning |
| 0:05 | Q1 Review | Sarah | Identify wins, gaps, and learnings |
| 0:20 | Q2 Goal Setting | Alex | Align on top 3 priorities for the quarter |
| 0:40 | Tooling: Figma AI | Jake | Decide: adopt, pilot, or skip |
| 0:50 | Action Items | Lisa | Assign owners & deadlines |
| 0:55 | Buffer | All | Address overflow or end early |

### Desired Outcomes
- [ ] Q2 priorities agreed (top 3)
- [ ] Figma AI decision made
- [ ] Action items assigned with owners

### Parking Lot
(For topics that arise but aren't agenda items)
```

---

*Version: 1.0*
