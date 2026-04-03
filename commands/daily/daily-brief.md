# /daily-brief

Morning briefing that aggregates your email, calendar, tasks, and social analytics into a focused daily overview.

## Trigger

User invokes `/daily-brief` to start their day with a consolidated view of what matters.

## Required MCP Servers

- Gmail (email summaries)
- Google Calendar (today's schedule)
- Notion (tasks and project updates)
- LinkedIn, Instagram, Substack APIs (optional - social analytics)

---

## Workflow

### Step 1: Gather Data

Fetch in parallel:

1. **Calendar** - Today's meetings and events
2. **Email** - Unread/flagged emails from last 24 hours
3. **Tasks** - Due today or overdue from Notion
4. **Social** (if available) - Recent engagement metrics

### Step 2: Synthesize Briefing

Present a single, scannable briefing:

```
## Good morning

### Today's Schedule
[List meetings with times, attendees summary, and any prep needed]

### Email Requiring Attention
[Urgent/important emails grouped by sender or topic]
[Flag anything time-sensitive]

### Tasks Due Today
[Priority-ordered list from Notion]
[Include any overdue items]

### Social Pulse (if available)
[Brief engagement summary: new followers, top-performing content, notable interactions]

### Heads Up
[Any conflicts, double-bookings, or concerns for the day]
```

### Step 3: Offer Follow-ups

After presenting the briefing, ask:

- "Would you like me to draft replies to any of these emails?"
- "Should I prep you for any of these meetings?"
- "Want me to block focus time around your meetings?"

---

## Output Style

- Concise, scannable
- No fluff or commentary
- Use bullet points
- Bold key names, times, and action items
- Personal tone ("You have 3 meetings today" not "There are 3 meetings scheduled")

---

## Fallback Behavior

If an MCP server is unavailable:

- Skip that section
- Note it briefly: "Email unavailable - Gmail not connected"
- Continue with available data

---

## Example Output

```
## Good morning

### Today's Schedule
- **9:00 AM** - Design review with Sarah (Figma link in calendar)
- **11:30 AM** - Client call: Acme Corp (prep: review proposal)
- **2:00 PM** - 1:1 with Jake

### Email Requiring Attention
- **[Urgent]** Sarah Chen - "Logo feedback needed by noon"
- **[Client]** Mike @ Acme - Question about timeline (reply needed)
- 4 other unread, none urgent

### Tasks Due Today
- [ ] Finalize homepage wireframes
- [ ] Send invoice to Acme
- [ ] Review PR from Jake

### Heads Up
- 30-min gap between meetings at 10:30 - could use for logo feedback
- Acme call conflicts with your usual lunch - consider eating early
```

---

*Version: 1.0*
