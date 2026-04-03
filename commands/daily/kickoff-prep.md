# /kickoff-prep

Generate project kickoff materials from a brief or proposal.

## Trigger

User invokes `/kickoff-prep` after winning a project to prepare for the kickoff meeting and project start.

---

## Workflow

### Step 1: Gather Project Information

Ask:
- "What's the project? (share brief, proposal, or describe)"
- "Who's on the team? (internal and client-side)"
- "When is the kickoff meeting?"
- "What's the project timeline?"

### Step 2: Generate Kickoff Package

Create three outputs:

1. **Kickoff Agenda** - Meeting structure
2. **Project Brief** - One-page summary for alignment
3. **Questions List** - Discovery questions for kickoff

---

## Output 1: Kickoff Agenda

```
## Project Kickoff: [Project Name]

**Date:** [Date]
**Duration:** [60-90 minutes recommended]
**Attendees:** [List]

### Agenda

| Time | Topic | Owner | Goal |
|------|-------|-------|------|
| 0:00 | Introductions | All | Know who's who |
| 0:10 | Project overview | [Lead] | Align on scope and goals |
| 0:20 | Success criteria | All | Define what "done" looks like |
| 0:30 | Timeline & milestones | [PM] | Confirm key dates |
| 0:40 | Roles & responsibilities | All | Clarify who does what |
| 0:50 | Communication & process | [PM] | Set working rhythms |
| 1:00 | Discovery questions | [Lead] | Fill knowledge gaps |
| 1:15 | Next steps & action items | [PM] | Clear immediate to-dos |

### Pre-Meeting Prep
- [ ] Share project brief 24hrs ahead
- [ ] Confirm attendees and calendar
- [ ] Prepare discovery questions

### Meeting Materials Needed
- Project brief (below)
- Timeline/roadmap visual
- Questions list
```

---

## Output 2: Project Brief

```
# [Project Name] - Project Brief

## Overview

**Client:** [Client name]
**Project Lead:** [Name]
**Timeline:** [Start] - [End]
**Budget:** [If applicable]

## Background

[2-3 sentences on client context and why this project exists]

## Objectives

1. [Primary objective]
2. [Secondary objective]
3. [Tertiary objective]

## Scope

### In Scope
- [Deliverable 1]
- [Deliverable 2]
- [Deliverable 3]

### Out of Scope
- [Exclusion 1]
- [Exclusion 2]

## Success Criteria

| Metric | Target |
|--------|--------|
| [Metric 1] | [Target] |
| [Metric 2] | [Target] |

## Key Milestones

| Milestone | Date | Owner |
|-----------|------|-------|
| Kickoff | [Date] | All |
| [Phase 1 complete] | [Date] | [Owner] |
| [Phase 2 complete] | [Date] | [Owner] |
| Final delivery | [Date] | [Owner] |

## Team

### Client Side
- [Name] - [Role] - [Responsibilities]
- [Name] - [Role] - [Responsibilities]

### Our Team
- [Name] - [Role] - [Responsibilities]
- [Name] - [Role] - [Responsibilities]

## Communication

- **Primary channel:** [Slack/Email/etc.]
- **Check-ins:** [Frequency and format]
- **Approvals:** [Who approves what]

## Risks & Dependencies

| Risk/Dependency | Impact | Mitigation |
|-----------------|--------|------------|
| [Item] | [Impact] | [Plan] |

## Assumptions

- [Assumption 1]
- [Assumption 2]
- [Assumption 3]
```

---

## Output 3: Discovery Questions

```
## Discovery Questions for [Project Name]

### Business Context
- What's driving this project now? Why is the timing important?
- Who are the key stakeholders beyond this room?
- What does success look like from your CEO's perspective?
- What happens if we don't hit [primary goal]?

### Users & Audience
- Who is the primary audience? Secondary?
- What do we know about them already?
- Any existing research, analytics, or personas to share?
- What's the main job-to-be-done for users?

### Current State
- What exists today? What's working, what's not?
- What have you tried before? What did you learn?
- Any sacred cows or things we shouldn't change?
- What technical constraints should we know about?

### Brand & Creative
- Any brand guidelines or design system to follow?
- References or competitors you admire (or want to avoid)?
- What tone/feeling should this evoke?
- Who needs to approve creative decisions?

### Process & Logistics
- Who's our primary point of contact?
- How do you prefer to give feedback?
- Any blackout dates, vacations, or constraints?
- What's the approval process for key decisions?

### Success & Measurement
- How will we measure if this worked?
- When will we know if it's successful? (30 days? 6 months?)
- What would make you regret doing this project?
- What would make you want to work with us again?
```

---

## Step 3: Offer Follow-ups

After generating:

- "Want me to add these to a Notion project space?"
- "Should I draft the kickoff meeting invite?"
- "Any sections you want me to expand?"
- "Want a client-facing version (less internal detail)?"

---

## Customization

**For internal projects:**
- Skip "client side" team section
- Replace "client" language with "stakeholder"
- Add internal approvals process

**For recurring clients:**
- Reference previous project context
- Focus on what's different this time
- Streamline discovery questions to new areas only

---

*Version: 1.0*
