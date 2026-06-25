---
name: wiki-source-integration
description: 'USE THIS SKILL whenever the user wants to: decide how to store source
  documents in a wiki, embed documents inline, separate sources into files, or organize
  document references. Triggers on ''source integration'', ''embed document'', ''store
  sources'', or ''document organization''.'
---

# Wiki Source Document Integration Strategy

When adding source document content to the wiki, decide between:
1. **Inline content**: Embed full document text directly in the target wiki page (e.g., in a `## Employment` or `## Documents` section). Preferred for short/simple text docs (<30 lines).
2. **Separate source file**: Create a file in `sources/` and reference via wikilink. Preferred for large, multi-page, or binary files.

## Decision Framework

**Prefer INLINE content when:**
- Document is small (under ~30 lines of text, single page)
- Content is simple factual record (income certificates, simple letters, one-page forms)
- Document directly belongs in a specific wiki section (Employment, Identity, etc.)
- No binary/image components need preservation

**Create SEPARATE source file when:**
- Document is large (multi-page contracts, lengthy records)
- Original file must be preserved as-is for legal/proof reasons (Archive zone)
- Content doesn't fit naturally into any existing wiki section

## Implementation Steps (Inline Approach)

1. Insert the document content as a quoted block in the target wiki page's relevant section.
2. Add a provenance marker: `"**Source**: Source document archived in sources/docs/Archive/"`.
3. Add the source path to the `source_notes` array in frontmatter.

## Common Pitfalls

- Creating separate source files for small text documents (unnecessary fragmentation).
- Removing source references entirely (loses provenance trail).
- Leaving orphaned `source_notes` entries pointing to deleted files.
