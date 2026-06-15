---
name: stale-docs-cleanup
description: clean up stale documentation and plan debris in code repositories after agentic coding work. use when reviewing or editing a codebase that contains completed plans, phase docs, roadmap fragments, agent handoff notes, owner/status sections, forward-looking references, archive folders, or docs that duplicate code. use to delete obsolete docs, convert future work into the repo's issue tracker, preserve human-facing guides, and keep contracts limited to frozen interfaces.
---

# Stale Docs Cleanup

## Prime directive

Delete stale docs. Git history is the archive. Code is the source of truth. Docs are for humans.

Use short, sharp review prose. Make decisions. Spend context on evidence and edits.

## Workflow

1. Run the audit script from the repository root when tools are available:

```bash
bash path/to/skill/scripts/audit_stale_docs.sh . > .scratch/stale-docs-audit.md
```

2. Start the report with `Section A — Issue tracker`.
3. Classify every suspect doc as `delete`, `move to issue`, `rewrite`, or `keep`.
4. Apply edits directly when the user asked for cleanup. Delete completed plans; avoid archive folders.
5. Move future work into the chosen issue tracker. Then delete the plan doc or trim it into a human guide.
6. Leave a compact report with files changed, issues created, and remaining decisions.

## Section A — Issue tracker

Pick where future work lives for this repo.

Default posture:

- Git remote points at GitHub: propose GitHub Issues. Use `gh issue create`.
- Git remote points at GitLab, including self-hosted GitLab: propose GitLab Issues. Use `glab issue create`.
- Other remote or no remote: offer these choices and record the answer:
  - GitHub — issues live in the repo's GitHub Issues, via `gh`.
  - GitLab — issues live in the repo's GitLab Issues, via `glab`.
  - Local markdown — issues live under `.scratch/<feature>/`.
  - Other — Jira, Linear, or another tracker; record the one-paragraph workflow as prose.

For local markdown issues, use this shape:

```markdown
# <issue title>

## Problem
<current user-facing or developer-facing problem>

## Scope
<smallest useful change>

## Acceptance criteria
- <observable outcome>
- <test or validation signal>
```

## Deletion rules

Delete these when found:

- completed plans, implementation plans, phase docs, checkpoints, handoff docs, pause/resume notes
- `docs/archive`, `docs/old`, `docs/deprecated`, and similar dead-doc folders
- docs that describe agent tasks, prompts, ownership, status, or unfinished execution state
- docs that duplicate current code structure or implementation details
- current-state references containing completion history, backlog, or forward-looking language

Preserve history through git and an existing `CHANGELOG.md`. Create or update a changelog only for human-readable release history.

## Keep rules

Keep docs that help humans:

- README, setup, deployment, operations, troubleshooting, contribution, and usage guides
- architecture notes that explain stable boundaries or hard-won decisions
- ADRs that capture durable decisions and current constraints
- contracts that freeze interfaces: command names, payloads, events, schemas, endpoints, env vars
- changelogs that record release-level changes

Contracts describe interfaces. Strip implementation journeys, phases, owners, and future work.

## Rewrite rules

For useful docs with stale language, rewrite to current state:

- Replace phase/status/owner sections with stable facts.
- Replace future work with issue links.
- Replace agent instructions with human-readable guidance.
- Replace implementation journey with current behavior and interfaces.
- Keep examples executable and aligned with code.

## Report shape

Use `references/report-template.md` for final reports. Load `references/doc-hygiene-rules.md` when a cleanup decision is ambiguous.
