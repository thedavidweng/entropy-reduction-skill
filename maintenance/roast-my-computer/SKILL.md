---
name: roast-my-computer
description: use when asked to roast, audit, score, shame, or clean up a local developer environment — messy project folders, home/downloads/desktop clutter, abandoned projects, poor git hygiene, AI slop, leaked-secret risk, unused tooling, dependency graveyards, or hackathon demos — on macOS, Linux, or Windows, without uploading private files.
---

# Roast My Computer

Generate a local-only developer environment roast. Run the deterministic scanner, then write a branded classic-Macintosh-style HTML report using `references/HTML_REPORT_FORMAT.md`.

## Operating rule

Run locally through the executing agent, using the user's filesystem. Treat memory, paths, dotfiles, source code, credentials, scan JSON, and generated reports as private. Secret values must stay redacted.

## Workflow

### 1. Pick one scope

Offer only these choices unless the user already chose:

1. **Project** — scan the current working directory. This fits restricted environments that can only read the active repo/workspace.
2. **Global** — let the agent use memory/context to add the user's high-frequency folders, then scan those plus common macOS/Linux/Windows developer locations. Tell the user this is more accurate and may require approving extra filesystem access.

Use Project for "this repo", "current workspace", "safe", or permission-limited runs. Use Global for "my computer", "full roast", "most accurate", or when the user wants the agent to use memory.

### 2. Build roots

For **Project**, use the current working directory. Add explicit paths only when the user supplied them.

For **Global**, first use the agent's memory/context to identify likely user folders: frequent repos, workspaces, design assets, downloads, monorepos, or tool-specific config locations. Then add common defaults from `references/DIRECTORY_TARGETS.md`.

Do not quote memory in the report unless the same path was observed on disk.

### 3. Run the scanner

Project:

```bash
python3 scripts/scan_dev_environment.py --scope project --output <tmpdir>/computer-roast-scan.json
```

Global with memory roots:

```bash
python3 scripts/scan_dev_environment.py --scope global --output <tmpdir>/computer-roast-scan.json --memory-root ~/dev --memory-root ~/work/special-repo
```

Extra paths can be passed naturally:

```bash
python3 scripts/scan_dev_environment.py --scope global --output <tmpdir>/computer-roast-scan.json ~/dev ~/Downloads
```

Useful options:

```bash
--scope project                  # current working directory
--scope global                   # memory roots + common platform roots
--memory-root <path>             # repeatable root inferred from memory/context
--root <path>                    # repeatable explicit root
--max-depth 4                    # default traversal depth (raise to 6 for deep monorepos; slower)
--max-seconds 60                 # wall-clock budget; scan stops and writes partial results when exceeded
--max-entries 200000             # hard cap on total entries scanned across all roots
--max-entries-per-dir 2000       # hard cap on entries listed from a single wide directory
--max-repos 80                   # max repositories inspected with git
--no-content-scan                # metadata-only mode (much faster; skips secret/AI-slop text scanning)
--metadata-only-sensitive-dirs   # advanced conservative mode for .ssh/.aws/.kube/etc.
--include-cache-dirs             # slower; traverse heavy dependency/cache dirs
```

The scanner has hard limits on wall-clock time, total entries, per-directory entries, and repository count. A scan never runs forever — when a limit is hit it stops, writes partial results, and sets `scan_policy.truncated` with the reason (`time_limit` or `entry_limit`). The HTML report should note when a scan was truncated so the roast reflects incomplete coverage rather than pretending the machine is clean.

Global mode defaults to the most accurate local scan: small text files, including sensitive config directories, are scanned for secret-like patterns. Values remain redacted; the JSON stores detector names, counts, paths, severity, and hashes.

### 4. Generate the HTML report

Read `references/HTML_REPORT_FORMAT.md`. Write one self-contained HTML file to the OS temp directory:

```txt
<tmpdir>/computer-roast-report-<timestamp>.html
```

Keep the report format simple and reproducible:

- one full-screen classic Macintosh app page
- top menu bar: `File Edit View Report Tools Help`
- black-and-white pixel-style UI
- four score cards: digital landfill, abandoned projects, secret chaos, git shame
- flexible `DIAGNOSIS` text pane for variable-length roast copy
- simple `HOTSPOTS` table with `Location` and `Items / Examples`
- compact `RED FLAGS` list
- compact `REDEMPTION` checklist
- bottom status bar

Do not use Tailwind, Mermaid, chart libraries, web fonts, external images, or JavaScript. Do not invent precise byte sizes for hotspots. If renderer code is needed, write it temporarily outside the skill package and keep the markdown spec as the design source of truth.

Open the report:

- macOS: `open <path>`
- Linux: `xdg-open <path>`
- Windows: `start <path>` or `Start-Process <path>`

### 5. Optional writing pass

Use `references/ROAST_WRITER_PROMPT.md` only when the report needs sharper prose. The writing pass may rewrite summary, diagnosis, finding labels, and cleanup copy. It must not change counts, scores, paths, severities, scope, or redaction behavior.

Default roast language is English. Use the user's language when the conversation is clearly in that language or they ask for it.

### 6. Cleanup loop

After showing the report, ask which finding the user wants to inspect.

Before any cleanup, propose exact commands and require explicit confirmation. Prefer quarantine over deletion. Never automatically remove source repos, password stores, browser profiles, `.ssh`, `.aws`, `.kube`, or other credential stores.

## Output files

- `computer-roast-scan.json` — deterministic local evidence
- `computer-roast-report-<timestamp>.html` — branded local report

## Reference files

- `references/HTML_REPORT_FORMAT.md` — canonical classic Macintosh HTML report format
- `references/PRIVACY_RULES.md` — privacy and cleanup constraints
- `references/DIRECTORY_TARGETS.md` — platform-specific Global scan targets
- `references/SCORING.md` — deterministic score model
- `references/ROAST_STYLE.md` — roast tone and safety boundaries
- `references/ROAST_WRITER_PROMPT.md` — bounded optional writing prompt
- `references/REPORT_SCHEMA.md` — JSON schema and report contract
