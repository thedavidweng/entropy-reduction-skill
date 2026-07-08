# Directory Targets

Use these targets for **Global** scans only. **Project** scans use the current working directory, plus explicit user-supplied paths.

Global scans should prefer user-specific memory/context before generic defaults. Add frequent repos, workspaces, downloads, design assets, and tool folders the agent knows the user actually uses. Then add relevant defaults below.

## Common home roots

- `~/Downloads`
- `~/Desktop`
- `~/Documents`
- `~/dev`, `~/Dev`
- `~/code`, `~/Code`
- `~/projects`, `~/Projects`
- `~/src`, `~/repos`, `~/workspace`
- `~/work`, `~/Work`

## Sensitive config roots

These are scanned for small text secret-like patterns in Global mode by default. Values stay redacted. Use `--metadata-only-sensitive-dirs` only for conservative runs.

- `~/.ssh`
- `~/.aws`
- `~/.azure`
- `~/.kube`
- `~/.gnupg`

## Other config/tool roots

- `~/.config`
- `~/.docker`
- `~/.local/share`
- `~/.cache` when cache scanning is requested
- `~/.npm`, `~/.pnpm-store`, `~/.cargo`, `~/.rustup`, `~/.nvm`, `~/.pyenv`, `~/.asdf`, `~/.mise`, `~/.bun`, `~/.deno`

## macOS

- `~/Library/Application Support`
- `~/Library/Caches` when cache scanning is requested

`/Applications` is **not** a default root. App bundles inflate Digital Landfill with dylibs the user cannot clean (Affinity, Final Cut, etc.) and produce public-key false positives from bundled `*.pem`/`*.key` files. If the user explicitly wants app coverage, pass `--root /Applications --max-depth 1` and prefer `--no-content-scan` there — metadata-only, shallow.

## Linux

- `~/.local/share`
- `~/.cache` when cache scanning is requested
- `/opt`

## Windows

- `%USERPROFILE%\Downloads`
- `%USERPROFILE%\Desktop`
- `%USERPROFILE%\Documents`
- `%USERPROFILE%\source`
- `%USERPROFILE%\OneDrive\Desktop`
- `%USERPROFILE%\OneDrive\Documents`
- `%APPDATA%`
- `%LOCALAPPDATA%`
- `%ProgramFiles%`
- `%ProgramFiles(x86)%`

## Traversal rules

- Do not follow symlinks.
- Keep the default traversal shallow.
- Skip heavy dependency/cache folders unless `--include-cache-dirs` is set.
- Do not read large files.
- Do not include raw file contents in reports.
