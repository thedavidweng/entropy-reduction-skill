# Doc Hygiene Rules

Use this reference for ambiguous docs.

## Action matrix

| Doc contains | Action |
| --- | --- |
| completed plan, phase checklist, checkpoint, handoff, pause/resume | delete |
| future feature, backlog item, TODO roadmap | move to issue tracker, then delete or trim |
| agent instruction, prompt, owner/status metadata | delete or rewrite for humans |
| duplicate implementation explanation | delete; code carries the detail |
| useful setup, operations, deploy, troubleshooting, usage info | keep and tighten |
| stable API, event, command, schema, payload, env var | keep as contract |
| release-level history | keep in changelog |

## Stale language patterns

Treat these as cleanup signals:

- `phase 1`, `phase 2`, `milestone`, `implementation plan`, `migration plan`
- `will be added`, `will add`, `planned`, `future work`, `roadmap`, `backlog`
- `owner`, `status`, `assigned to`, `next steps`, `remaining work`
- `agent`, `handoff`, `resume`, `checkpoint`, `pause-and-resume`
- `completed`, `done`, `shipped` inside reference docs

## Current-state reference test

A reference passes when a new human contributor can answer:

- what exists
- how to use it
- which interface is stable
- how to validate it

A reference fails when it mainly answers:

- how we got here
- what an agent planned to do
- what a future feature might become
- who owned a temporary task

## Changelog boundary

Use `CHANGELOG.md` for release-level human history. Use git for detailed history. Use issues for future work.
