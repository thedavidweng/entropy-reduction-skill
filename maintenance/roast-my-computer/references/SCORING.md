# Scoring

The scanner emits six 0-100 dimensions plus an overall shame index. Scores measure cleanup/roast intensity, not the user's competence or character.

## Dimensions

### Digital Landfill

Signals:

- installers and archives in Downloads/Desktop
- large files
- dependency/build graveyards
- cache-like piles

Roast target: digital clutter and storage waste.

### Abandoned Projects

Signals:

- Git repos with one or zero commits
- repos with no recent commits
- missing README
- empty template leftovers

Roast target: half-started projects and weekend founder energy.

### Secret Chaos

Signals:

- redacted token-like patterns
- sensitive config files
- `.env` / `.npmrc` / `.pypirc` / cloud config tracked by Git
- unsafe key metadata

Roast target: risky credential hygiene. Never reveal secret values.

### Git Shame

Signals:

- dirty worktrees
- low-signal last commit messages
- missing README
- missing `.gitignore`
- too many stale branches

Roast target: version-control hygiene.

### AI Slop

Signals:

- plan-era docs
- phase language
- generated-by-AI markers
- future-tense implementation promises
- TODO-heavy code
- scaffold-heavy repos with little evidence of shipped behavior

Roast target: vibe-coded residue and imaginary architecture.

### Tool Hoarder

Signals:

- many runtime managers
- duplicate package manager stores
- huge dependency dirs
- stale cache/build trees

Roast target: toolchain collecting and environment entropy.

## Severity bands

- 0-34: low
- 35-59: medium
- 60-79: high
- 80-100: critical

## Determinism

The script owns scores. The model may rewrite prose, tags, and jokes. It must not change counts, severity, score values, or paths.
