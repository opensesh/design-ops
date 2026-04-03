# /meeting-recap

Post-meeting documentation workflow that generates summaries with action items, owners, and deadlines.

## Trigger

User invokes `/meeting-recap` after a meeting to create structured documentation.

## Optional MCP Servers

- Notion (to store the recap)
- Google Calendar (to attach to the event)

---

## Workflow

### Step 1: Gather Notes

Ask the user for meeting notes:

"How would you like to provide the meeting notes?"
- Paste them here
- Share a file path
- Share a recording transcript link

### Step 2: Clarify Context (if needed)

If the notes are sparse, ask:
- "What was the main purpose of this meeting?"
- "Who were the key attendees?"
- "Were there any decisions made that aren't captured?"

### Step 3: Generate Recap

Process the notes into a structured recap:

```
## Meeting Recap: [Title]

**Date:** [Date]
**Attendees:** [Names]
**Duration:** [If known]

### Summary
[2-3 sentence overview of what was discussed and decided]

### Key Decisions
- **[Decision 1]** - [Context if needed]
- **[Decision 2]** - [Context if needed]

### Discussion Highlights
- [Key point 1]
- [Key point 2]
- [Key point 3]

### Action Items

| Action | Owner | Due Date |
|--------|-------|----------|
| [Task 1] | [Name] | [Date] |
| [Task 2] | [Name] | [Date] |
| [Task 3] | [Name] | [Date] |

### Open Questions / Parking Lot
- [Unresolved item 1]
- [Unresolved item 2]

### Next Meeting
[Date/time if scheduled, or "TBD"]
```

### Step 4: Offer Follow-ups

After presenting the recap, ask:

- "Where would you like me to save this? (Notion, file, clipboard)"
- "Should I create tasks for each action item?"
- "Want me to draft a follow-up email to attendees?"
- "Any corrections or additions?"

---

## Processing Guidelines

When extracting from raw notes:

**Finding Decisions:**
- Look for: "we agreed", "decided", "will do", "going with"
- Distinguish between discussions and actual commitments

**Identifying Action Items:**
- Must have: What + Who + When
- If who/when is missing, flag it: "[Owner TBD]" or "[Date TBD]"
- Active voice: "Sarah will..." not "It was discussed that Sarah might..."

**Summary Quality:**
- Lead with outcomes, not process
- Good: "Agreed to launch beta on June 1 with reduced scope"
- Bad: "We spent an hour discussing launch timing"

---

## Example

**User:** `/meeting-recap`

**Claude:** "How would you like to provide the meeting notes?"

**User:**
```
design review call today with sarah and jake
- looked at homepage redesign
- sarah likes the hero but wants to explore different cta colors
- jake pointed out accessibility issues with the contrast
- need to fix contrast before next review
- decided to go with option B for the nav
- sarah will send mood board by friday
- next review tuesday
```

**Claude generates:**

```
## Meeting Recap: Design Review - Homepage Redesign

**Date:** [Today's date]
**Attendees:** Sarah, Jake, [You]

### Summary
Reviewed homepage redesign progress. Approved Option B for navigation. Identified accessibility concerns with CTA contrast that need resolution before next review.

### Key Decisions
- **Navigation:** Going with Option B
- **Hero:** Approved, but exploring alternative CTA colors

### Discussion Highlights
- Sarah positive on hero design overall
- Jake flagged contrast/accessibility issues with current CTA
- CTA color exploration needed to meet accessibility standards

### Action Items

| Action | Owner | Due Date |
|--------|-------|----------|
| Send mood board for CTA color exploration | Sarah | Friday |
| Fix CTA contrast to meet accessibility standards | [Owner TBD] | Before Tuesday |
| Schedule accessibility audit if needed | [Owner TBD] | [Date TBD] |

### Open Questions
- What WCAG level are we targeting for contrast?
- Are there brand constraints on CTA colors?

### Next Meeting
Tuesday (design review)
```

---

*Version: 1.0*
