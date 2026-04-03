# /project-health

Generate a project status report with health indicators.

## Trigger

User invokes `/project-health` to create a structured status report for a project, typically for stakeholder updates or internal tracking.

## Optional MCP Servers

- Notion (project tasks and milestones)
- Google Calendar (upcoming deadlines)

---

## Workflow

### Step 1: Gather Project Context

Ask:
- "Which project are you reporting on?"
- "What's the current phase? (discovery, design, development, etc.)"
- "When is the deadline / current milestone?"

### Step 2: Health Assessment

Ask about each dimension:

**Scope**
- "Is scope stable, growing, or shrinking?"
- "Any scope changes since last update?"

**Timeline**
- "Are you on track for the deadline?"
- "Any delays or concerns?"

**Budget** (if applicable)
- "How's budget tracking?"
- "Any unexpected costs?"

**Team/Resources**
- "Any blockers or resource constraints?"
- "Team health/capacity?"

**Stakeholder Alignment**
- "Any misalignments or surprises?"
- "When was last client/stakeholder touchpoint?"

### Step 3: Progress Details

Ask:
- "What was accomplished since last update?"
- "What's planned for next period?"
- "Any risks or blockers to flag?"

### Step 4: Generate Report

```
# Project Health Report: [Project Name]

**Report Date:** [Date]
**Phase:** [Current phase]
**Target Deadline:** [Date]

---

## Health Summary

| Dimension | Status | Notes |
|-----------|--------|-------|
| Scope | 🟢 / 🟡 / 🔴 | [Brief note] |
| Timeline | 🟢 / 🟡 / 🔴 | [Brief note] |
| Budget | 🟢 / 🟡 / 🔴 | [Brief note] |
| Resources | 🟢 / 🟡 / 🔴 | [Brief note] |
| Stakeholders | 🟢 / 🟡 / 🔴 | [Brief note] |

**Overall Health:** 🟢 On Track / 🟡 At Risk / 🔴 Off Track

---

## Progress Since Last Update

- [Accomplishment 1]
- [Accomplishment 2]
- [Accomplishment 3]

## Planned for Next Period

- [Planned item 1]
- [Planned item 2]
- [Planned item 3]

---

## Risks & Blockers

| Risk/Blocker | Severity | Mitigation |
|--------------|----------|------------|
| [Issue 1] | High/Med/Low | [Action] |
| [Issue 2] | High/Med/Low | [Action] |

---

## Key Decisions Needed

- [ ] [Decision 1] - Needed by: [Date]
- [ ] [Decision 2] - Needed by: [Date]

---

## Upcoming Milestones

| Milestone | Target Date | Status |
|-----------|-------------|--------|
| [Milestone 1] | [Date] | [On track / At risk] |
| [Milestone 2] | [Date] | [On track / At risk] |

---

## Notes for Stakeholders

[Any context, color, or communication for external readers]
```

### Step 5: Offer Follow-ups

- "Want me to create a shorter version for email/Slack?"
- "Should I save this to Notion?"
- "Any risks that need escalation?"

---

## Health Indicator Definitions

**🟢 Green (On Track)**
- No significant concerns
- Progressing as planned
- Stakeholders aligned

**🟡 Yellow (At Risk)**
- Minor delays or concerns
- Manageable scope creep
- Needs attention but recoverable

**🔴 Red (Off Track)**
- Significant delays
- Major scope/budget issues
- Requires intervention

---

## Tone Variants

**For internal team:**
- Direct, no sugar-coating
- Include granular details
- Focus on blockers and solutions

**For client/stakeholder:**
- Professional but honest
- Lead with progress, then concerns
- Always include next steps

**For executive summary:**
- Bullet points only
- One paragraph max
- Focus on health status and key decisions needed

---

## Example Output

```
# Project Health Report: Acme Corp Website Redesign

**Report Date:** March 29, 2024
**Phase:** Development
**Target Deadline:** April 15

---

## Health Summary

| Dimension | Status | Notes |
|-----------|--------|-------|
| Scope | 🟢 | Stable since discovery |
| Timeline | 🟡 | CMS integration taking longer than estimated |
| Budget | 🟢 | On track, 60% burned |
| Resources | 🟡 | Developer PTO next week |
| Stakeholders | 🟢 | Last sync: March 27 |

**Overall Health:** 🟡 At Risk

---

## Progress Since Last Update

- Homepage and About page development complete
- CMS structure finalized
- Client approved final copy

## Planned for Next Period

- Complete Services page development
- Begin CMS content migration
- Internal QA round 1

---

## Risks & Blockers

| Risk/Blocker | Severity | Mitigation |
|--------------|----------|------------|
| CMS integration complexity | Medium | Simplifying content types |
| Developer PTO April 1-3 | Medium | Front-loading critical work |

---

## Key Decisions Needed

- [ ] Final blog template approval - Needed by: April 1
- [ ] Go-live time preference (AM vs PM) - Needed by: April 10

---

## Upcoming Milestones

| Milestone | Target Date | Status |
|-----------|-------------|--------|
| Development complete | April 8 | At risk |
| QA & revisions | April 12 | On track |
| Launch | April 15 | On track |
```

---

*Version: 1.0*
