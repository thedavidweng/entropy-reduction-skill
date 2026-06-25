---
name: wiki-source-document-ingest
description: 'USE THIS SKILL whenever the user wants to: ingest a certificate, contract,
  employment letter, or other text-based document into a wiki''s sources layer and
  integrate its facts into a wiki page. Triggers on ''add certificate to wiki'', ''ingest
  document into sources'', ''create source document from text'', or ''add employment
  info to wiki from document''.'
---

# Source Document Ingestion

Take a raw document (certificate, contract, income proof, employment letter) provided as text and systematically integrate it into the wiki as both a source document and structured wiki data.

## Step-by-Step Process

### Step 1: Decide Source Location

Consult `sources/[category]/` structure. Common locations:

| Document Type | Location | Rationale |
|---|---|---|
| Identity documents (ID, passport, visa) | `sources/identity/` | Already existing pattern |
| Employment/income certificates | `sources/docs/Archive/` | High-value official docs, keep forever |
| Academic transcripts | `sources/identity/` or `sources/docs/Archive/` | Identity-adjacent |
| Contracts/agreements | `sources/docs/Archive/` | Legal documents |
| Low-value OCR docs | `sources/docs/OCR-Only/` | Searchable but not worth keeping |

Naming: `[slug]-[descriptor].md` e.g. `zhang-san-income-cert.md`

### Step 2: Create Source Markdown Document

Create the source document with proper frontmatter:

```yaml
---
layer: source
kind: document
created: YYYY-MM-DD  # Date on document, not today
updated: YYYY-MM-DD  # Today's date
source_type: manual    # or 'ocr', 'import'
source_uri: "Document title - Person name"
tags: [category1, category2]
---
```

Body:
1. Original document text (preserve exactly)
2. Metadata section with wikilinks to related wiki pages
3. Structured extracted facts (bullet points)

```markdown
# Document Title

Full original text...

## Metadata

- **Person**: [[person-slug|Person Name]]
- **Organization**: [[org-slug|Org Name]]
- **Document type**: Type
- **Key fact**: Value (with units/dates)
- **Date issued**: YYYY-MM-DD
```

### Step 3: Update Person/Entity Page

#### 3.1 Add to `source_notes` frontmatter
Add the new source path to the `source_notes` array (create if missing):

```yaml
source_notes:
  - "sources/previous/doc.md"
  - "sources/docs/Archive/new-doc.md"
```

#### 3.2 Add structured data section
Add a new section (`## Employment`, `## Income`, `## Education`, etc.) after existing sections. Format:

```markdown
## Section Name

Brief narrative sentence.

- **Field name**: Value with [[wikilinks]] (bold for fields)
- **Another field**: Value
- **Source**: Link to source document inline
```

#### 3.3 Clean up content
Check for:
- Duplicate information already present elsewhere on the page
- Orphaned leftover text from previous edits
- Inconsistent formatting vs existing sections

### Step 4: Validate

Run quick checks:
```python
from hermes_tools import search_files
assert search_files(pattern="new-doc.md", path="sources/").get('total_count',0) > 0
assert search_files(pattern="new-doc.md", path="wiki/people/").get('total_count',0) == 0
```

Verify the person page renders cleanly with all wikilinks resolved.

## Constraints

- **Archive vs OCR-Only:** Save to `sources/docs/Archive/` for permanent/legal provenance; save to `sources/docs/OCR-Only/` if only plaintext searchability is needed.
- **Biographical Dupes:** Avoid repeating bio details already in the page introduction. The new section must be concise and structured.
- **Date Format:** Use `YYYY-MM-DD` for metadata dates. Narrative dates in text can use Chinese `YYYY年M月D日`.
