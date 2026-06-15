#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-.}"
MAX_HITS="${MAX_HITS:-80}"

if [ ! -d "$REPO" ]; then
  echo "repo path does not exist: $REPO" >&2
  exit 1
fi

cd "$REPO"

printf '# Stale Docs Audit\n\n'
printf 'Repo: `%s`\n' "$(pwd)"
printf 'Generated: `%s`\n\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"

printf '## Section A — Issue tracker\n\n'
remote_text="$(git remote -v 2>/dev/null || true)"
if printf '%s\n' "$remote_text" | grep -Eiq 'github\.com[:/]|github\.com/'; then
  printf 'Detected: GitHub remote.\n'
  printf 'Suggested tracker: GitHub Issues.\n'
  if command -v gh >/dev/null 2>&1; then
    printf 'CLI: `gh` found.\n\n'
  else
    printf 'CLI: `gh` missing.\n\n'
  fi
elif printf '%s\n' "$remote_text" | grep -Eiq 'gitlab\.com[:/]|gitlab\.'; then
  printf 'Detected: GitLab remote.\n'
  printf 'Suggested tracker: GitLab Issues.\n'
  if command -v glab >/dev/null 2>&1; then
    printf 'CLI: `glab` found.\n\n'
  else
    printf 'CLI: `glab` missing.\n\n'
  fi
else
  printf 'Detected: no GitHub/GitLab remote.\n'
  printf 'Choose: GitHub Issues, GitLab Issues, local markdown under `.scratch/<feature>/`, or another tracker workflow.\n\n'
fi

printf '### Git remotes\n\n'
if [ -n "$remote_text" ]; then
  printf '```\n%s\n```\n\n' "$remote_text"
else
  printf '_no remotes found_\n\n'
fi

DOC_LIST="$(mktemp)"
trap 'rm -f "$DOC_LIST"' EXIT

find . \
  \( -path './.git' -o -path './.scratch' -o -path './node_modules' -o -path './vendor' -o -path './dist' -o -path './build' -o -path './coverage' -o -path './.next' -o -path './.turbo' -o -path './target' -o -path './out' \) -prune \
  -o -type f \
  \( -iname '*.md' -o -iname '*.mdx' -o -iname '*.rst' -o -iname '*.adoc' -o -iname '*.txt' \) \
  -print | sort > "$DOC_LIST"

doc_count="$(wc -l < "$DOC_LIST" | tr -d ' ')"
printf '## Doc inventory\n\n'
printf 'Doc files scanned: `%s`\n\n' "$doc_count"

print_matches() {
  title="$1"
  pattern="$2"
  printf '## %s\n\n' "$title"
  if [ "$doc_count" = "0" ]; then
    printf '_no doc files found_\n\n'
    return
  fi
  matches="$({ while IFS= read -r file; do grep -nHIE "$pattern" -- "$file" || true; done < "$DOC_LIST"; } | head -n "$MAX_HITS" || true)"
  if [ -n "$matches" ]; then
    printf '```\n%s\n```\n\n' "$matches"
  else
    printf '_no matches_\n\n'
  fi
}

print_matches 'Plan-era language' '\b(phase[[:space:]]+[0-9ivxlcdm]+|milestone|implementation plan|migration plan|rollout plan|launch plan|checkpoint|pause-and-resume|resume point|handoff)\b'
print_matches 'Forward-looking language' '\b(will be added|will add|we will|planned|future work|roadmap|backlog|todo|next steps|remaining work|follow-up|follow up)\b'
print_matches 'Agent instructions' '\b(agent|cursor|claude|chatgpt|codex|prompt|system prompt|handoff|resume|continue from here|context for agent)\b'
print_matches 'Owner/status sections' '^#{1,6}[[:space:]]*(owner|owners|status|assigned|assignee|next steps|remaining work)\b|\b(owner|status|assigned to|assignee):'
print_matches 'History in references' '\b(completed|done|shipped|implemented|was added|we added|previously|history|completion)\b'

printf '## Archive-folder smells\n\n'
archive_dirs="$(find . -type d \( -iname 'archive' -o -iname 'archives' -o -iname 'old' -o -iname 'deprecated' -o -iname 'completed' \) -not -path './.git/*' -not -path './.scratch/*' | sort | head -n "$MAX_HITS" || true)"
if [ -n "$archive_dirs" ]; then
  printf '```\n%s\n```\n\n' "$archive_dirs"
else
  printf '_no matches_\n\n'
fi

printf '## Contract files containing journey language\n\n'
contract_matches="$({ while IFS= read -r file; do if grep -qiE '\b(contract|api|schema|payload|event|command|endpoint)\b' -- "$file"; then grep -nHIE '\b(phase|implementation plan|will be added|future work|roadmap|owner|status|checkpoint|handoff)\b' -- "$file" || true; fi; done < "$DOC_LIST"; } | head -n "$MAX_HITS" || true)"
if [ -n "$contract_matches" ]; then
  printf '```\n%s\n```\n\n' "$contract_matches"
else
  printf '_no matches_\n\n'
fi

printf '## Suggested pass\n\n'
printf '1. Delete completed plans, phase docs, handoffs, archive folders, and duplicate implementation docs.\n'
printf '2. Move future work into the selected issue tracker.\n'
printf '3. Rewrite useful human docs into current-state guides.\n'
printf '4. Keep contracts focused on commands, payloads, events, schemas, endpoints, and env vars.\n'
