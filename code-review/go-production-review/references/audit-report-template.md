# Go production review report template

Use this structure for the final answer. Match the user's language.

## Production readiness verdict

State one of:
- `production-ready with minor issues`
- `production-ready after targeted fixes`
- `not production-ready yet`
- `insufficient evidence`

Give a 2-4 sentence rationale tied to the highest-severity evidence.

## Evidence inspected

List the codebase paths, modules, and commands used. Include command failures.

Example:

| Evidence | Result |
|---|---|
| `go test ./...` | pass/fail/unknown |
| `go vet ./...` | pass/fail/unknown |
| `gofmt -l` | pass/fail/unknown |
| `go test -race ./...` | pass/fail/skipped |
| CI config | present/missing/unknown |

## Scorecard

| Area | Status | Key evidence |
|---|---|---|
| modules/toolchain | pass/partial/fail/unknown | ... |
| formatting/style | pass/partial/fail/unknown | ... |
| error handling | pass/partial/fail/unknown | ... |
| strings/unicode | pass/partial/fail/unknown | ... |
| concurrency | pass/partial/fail/unknown | ... |
| testing/coverage | pass/partial/fail/unknown | ... |
| benchmarks/performance | pass/partial/fail/unknown | ... |
| tooling/static analysis | pass/partial/fail/unknown | ... |
| security | pass/partial/fail/unknown | ... |
| ci/cd/observability | pass/partial/fail/unknown | ... |

## Findings

Sort by severity, then by confidence.

### P0/P1/P2/P3: [short finding title]

- Checklist: `PG-xx`
- Evidence: file path, line number, command output, or code snippet
- Impact: concrete production risk
- Fix: specific remediation
- Verification: command or test to prove the fix

## Positive practices already present

List strong evidence-backed practices. Keep this short and concrete.

## Unknowns and manual review targets

Use when the repository, environment, or command output does not give enough evidence.

## Recommended next actions

Give a prioritized list of 3-7 actions. Each action should be concrete and testable.
