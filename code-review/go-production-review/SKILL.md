---
name: go-production-review
description: production go codebase review against best practices distilled from the book production go. use when the user asks to audit, review, assess, compare, or harden a go repository/codebase/service for production readiness; asks whether go code follows go best practices; wants a checklist for go modules, gofmt/goimports, error handling, unicode/string handling, concurrency, tests, benchmarks, tooling, security, ci/cd, observability, or deployment readiness. produce evidence-backed findings, severity-ranked risks, and concrete remediation steps.
---

# Go Production Review

Use this skill to evaluate a Go codebase against production-focused practices distilled from *Production Go*. Treat the book-derived guidance as intent-level criteria: accept modern equivalents that satisfy the same reliability, correctness, security, and operability goals.

Do not reproduce long passages from the book. Produce an audit, checklist, remediation plan, or code review grounded in repository evidence.

## Core workflow

1. Identify the codebase scope: repository root, module roots, service packages, command packages, and any CI/deployment files.
2. Read `references/production-go-checklist.md` before scoring. Use the `PG-xx` IDs in findings.
3. If repository files are available, run the evidence script where possible:

```bash
bash scripts/collect_go_production_signals.sh /path/to/repo > go-production-signals.md
```

For deeper checks when the environment can support them:

```bash
RUN_RACE=1 RUN_BENCH=1 bash scripts/collect_go_production_signals.sh /path/to/repo > go-production-signals.md
```

4. Inspect command output and source files manually. Treat script output as signals, not verdicts.
5. Classify each checklist item as `pass`, `partial`, `fail`, `unknown`, or `not applicable`.
6. Rank findings as `p0`, `p1`, `p2`, or `p3` using the checklist severity guidance.
7. Produce the final report using `references/audit-report-template.md`, matching the user's language.

## Evidence rules

Always prefer evidence from the user's repository over generic advice.

For each finding, include:
- checklist ID, such as `PG-39`
- file path and line number when available
- command output when relevant
- production impact
- concrete fix
- verification command or test

Mark a result as `unknown` when evidence is unavailable. Do not invent CI, deployment, alerting, or observability details.

## Review focus areas

Cover these areas unless they are clearly out of scope:

1. modules, Go version, dependency reproducibility, and pinned tools
2. gofmt, gofmt `-s`, goimports, variable naming, declaration style, exported API shape, and godoc comments
3. type pitfalls: `uint`, nil maps, map iteration order, JSON tags, exported fields, interface nils, empty interfaces
4. explicit error returns, immediate error checks, contextual wrapping, lowercase error strings, ignored errors
5. string construction, Unicode/rune safety, Unicode-aware tests, normalization, `strings.EqualFold`, `unicode`, and `x/text`
6. goroutine lifecycle, `WaitGroup`, `errgroup`, channel balance, handler-spawned goroutines, pollers, map races, locks, atomics, race detector
7. tests, table-driven cases, failure messages, `httptest`, mocks via narrow interfaces, coverage, examples, fuzzing
8. benchmarks, `b.N`, `b.ResetTimer`, `-benchmem`, escape analysis, benchmark comparison discipline
9. `go vet`, staticcheck or equivalent, golangci-lint, errcheck, Go Report Card-style checks, documentation/navigation tooling
10. security: Go updates, CSRF, HSTS, CSP, SQL injection, user-generated HTML sanitization
11. production readiness: CI/CD, deployment repeatability, centralized logs, metrics, dashboards, alerting, redundancy

## Modern-equivalent handling

Some tooling names and commands from the source book may have modern replacements. Score the underlying practice, not the exact historical tool, unless the user explicitly asks for a book-literal audit.

Examples:
- Accept a maintained linter suite that includes vet/staticcheck-like checks.
- Accept native Go fuzz tests or another documented fuzzing workflow for input-heavy code.
- Accept current benchmark comparison tooling if it provides reliable before/after comparisons.
- Accept reverse-proxy enforcement of HSTS/CSP when the service architecture sets headers outside Go.

## Output discipline

Lead with the production-readiness verdict. Then provide the scorecard and findings.

Keep generic education short. Most space should go to repository-specific evidence and fixes.

For codebase audits, end with prioritized next actions, not a broad summary.
