# Privacy Rules

The scan runs on the user's machine through their own agent. Treat all paths, dotfiles, source code, credentials, scan JSON, and generated reports as private.

## Hard rules

- Do not upload file contents.
- Do not print raw secret values.
- Do not include source snippets, personal documents, email contents, browser history, or private chat logs in the report.
- Do not follow symlinks.
- Do not delete or modify files without explicit confirmation.
- Write generated reports to the stable report directory (`${TMPDIR:-/tmp}/roast-my-computer` on Unix, `%TEMP%\roast-my-computer` on Windows) unless the user chooses another location. This directory persists across sessions so the workflow can offer to recycle or clean up previous reports, but it is still inside the OS temp tree and will be cleared by the OS on its normal schedule.

## Secret handling

Secret detection may read small text files locally. Findings must contain only:

- detector name
- risk severity
- path
- path hash
- match count
- redacted flag

High-sensitive directories such as `.ssh`, `.aws`, `.azure`, `.kube`, and `.gnupg` are content-scanned by default in Global mode for accuracy. Use `--metadata-only-sensitive-dirs` only when the user wants a conservative scan.

Private-key-like files may be detected by filename/path metadata even when content scanning is disabled.

## Cleanup constraints

Before cleanup, present exact commands and expected effects. Require explicit confirmation.

Never automatically remove:

- source repositories
- `.ssh`, `.aws`, `.azure`, `.kube`, `.gnupg`
- password stores
- browser profiles
- user documents
- anything outside the confirmed cleanup scope

Prefer quarantine over permanent deletion.
