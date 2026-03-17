# entropy-reduction

A Claude Code skill for systematic codebase entropy reduction.

Designed for AI-first and vibe coding teams where code accumulates disorder quickly. This skill guides Claude to identify and reduce **structural, semantic, behavioral, and evolutionary entropy** — making codebases easier to maintain and evolve.

## Why This Exists

Entropy, in thermodynamics, is the measure of disorder in a system. The second law of thermodynamics says it only goes up — the universe trends toward chaos, and nothing you do can stop it.

Codebases are no different. Except worse. Because the universe doesn't have product managers.

Every feature adds a little disorder. Every "just ship it" PR adds a little more. Every time someone names the same concept `user` in one module, `member` in another, and `account` in a third — congratulations, you've just invented semantic entropy. Every time a function grows from 20 lines to 200 because "it's easier to just add it here" — that's structural entropy. Every time the same error returns a 400 in one endpoint, a 422 in another, and a 500 with a passive-aggressive message in a third — that's behavioral entropy.

And then there's **vibe coding**.

Vibe coding is beautiful. You describe what you want, AI writes it, you ship it. Incredible velocity. Revolutionary productivity. The future of software engineering.

It's also an entropy accelerator.

When AI writes code, it doesn't remember what it named things last time. It doesn't check if there's already a `formatDate()` util before writing a new one. It doesn't know that your team decided on `snake_case` for API fields three months ago. Every AI-generated PR is a small, confident, locally-reasonable contribution to global chaos.

Left unchecked, a vibe-coded repo eventually reaches **thermodynamic equilibrium** — a state of maximum entropy where every change is equally likely to break something, no one understands why anything is the way it is, and the only viable path forward is a rewrite (which will, of course, begin accumulating entropy immediately).

This skill is the Maxwell's Demon of your codebase. It sorts the fast molecules from the slow ones. It fights the second law. It will lose eventually — entropy always wins — but it can buy you time. Probably a lot of time.

Or, put simply: **your AI writes the code, this AI cleans up after it.**

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
