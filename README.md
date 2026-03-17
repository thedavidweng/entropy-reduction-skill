# entropy-reduction

A Claude Code skill for systematic codebase entropy reduction.

Designed for AI-first and vibe coding teams where code accumulates disorder quickly. This skill guides Claude to identify and reduce **structural, semantic, behavioral, and evolutionary entropy** — making codebases easier to maintain and evolve.

## What It Does

| Entropy Axis | What It Finds | What It Does |
|---|---|---|
| **Structural** | Oversized files, util black holes, circular deps, layer violations | Split by responsibility, tighten dependency direction, relocate business logic |
| **Semantic** | Inconsistent naming, scattered state machines, ad-hoc models | Converge to unified naming, extract single-source-of-truth state definitions |
| **Behavioral** | Inconsistent error responses, divergent boundary handling | Unify error models, standardize boundary behavior across similar APIs |
| **Evolutionary** | Giant mixed-purpose PRs, missing design intent, unclear ownership | Encourage small single-purpose changes, surface design rationale |

## Workflow

```
Diagnose → Plan → Refactor → Verify
```

1. **Diagnose** — Scan for high-entropy symptoms, label by axis and severity
2. **Plan** — Propose 1–3 small, safe, reversible changes with clear goals and risks
3. **Refactor** — Execute changes that preserve external behavior
4. **Verify** — Run tests, confirm no new disorder introduced

## Installation

```bash
# via npx
npx skills add thedavidweng/entropy-reduction-skill

# or clone manually
git clone https://github.com/thedavidweng/entropy-reduction-skill.git ~/.claude/skills/entropy-reduction
```

## Usage

Invoke directly:

```
/entropy-reduction src/services/
```

Or describe what you want:

```
"Clean up the auth module — there's a lot of inconsistency and tech debt"
"Reduce entropy in the API error handling"
"This codebase is getting messy, help me organize it"
```

## Principles

- **Small, safe changes over big rewrites.** Each refactor should be independently committable and reversible.
- **High-entropy areas first.** Don't touch stable, well-functioning code for aesthetics.
- **Preserve behavior.** Every change must be behavior-preserving unless explicitly approved.
- **Ask when uncertain.** If a rename, abstraction, or boundary is ambiguous — ask, don't guess.

## License

MIT
