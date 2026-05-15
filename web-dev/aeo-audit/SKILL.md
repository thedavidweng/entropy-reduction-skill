---
name: aeo-audit
description: Audit any website for Agent Experience Optimization (AEO). Checks llms.txt, agent views, schema.org, sitemap, agent-card.json, pricing.md, NLWeb feeds, semantic HTML, visual labeling, and cross-platform consistency. Provides applicability judgment and explicit fix plans.
triggers:
  - user says "audit AEO"
  - user says "agent experience optimization"
  - user says "check agent readable"
  - user says "SEO/AEO audit"
  - user says "make site AI discoverable"
  - user says "agent audit"
  - before publishing any marketing site, portfolio, or product site
---

# AEO Audit — Agent Experience Optimization

Audit a website for AI agent discoverability, ingestibility, and consistency. This is the agent-native equivalent of an SEO audit.

## Pre-audit: Site Classification

Before running checks, classify the site. This determines which items are **required**, **conditional**, or **irrelevant**.

| Site Type | Examples | Key Conditional Items |
|---|---|---|
| **Personal portfolio** | Creative, developer, photographer | No pricing, no API, no MCP |
| **SaaS / Product** | App landing, dashboard, tool | pricing.md, API docs, agent-card.json |
| **Blog / Publication** | Personal blog, newsletter, magazine | No pricing, no MCP, per-section llms.txt per category |
| **E-commerce** | Store, marketplace | Product schema, pricing, inventory feeds |
| **Documentation** | API docs, knowledge base | Per-section llms.txt, NLWeb schema, agent-card.json |
| **Open-source project** | GitHub Pages, library site | MCP server docs, agent-card.json, API endpoints |

**Rule**: Never recommend `pricing.md`, `agent-card.json`, MCP references, or API authentication docs for a site that has no pricing, no API, and no MCP server.

---

## Audit Checklist

Run every check that is **required** or **conditional-applicable** for the site's classification. For each item, record: `status` (pass / fail / skip / missing), `severity` (critical / warning / info), and `fix` (explicit action).

### A. Discovery & Crawlability

#### A1. Sitemap exists (`/sitemap.xml`)
- **Required for**: all sites
- **Check**: `curl -s https://<site>/sitemap.xml | head -n 5`
- **Pass**: Returns valid XML with `<urlset>` or `<sitemapindex>`
- **Fail**: 404, empty, or invalid XML
- **Fix**: Generate sitemap from all routes. Next.js: `app/sitemap.ts`. Static: use generator script.

#### A2. robots.txt exists (`/robots.txt`)
- **Required for**: all sites
- **Check**: `curl -s https://<site>/robots.txt`
- **Pass**: Returns text, includes `Sitemap:` directive, does not blanket-disallow `/`
- **Fail**: 404, missing `Sitemap:` line, or `Disallow: /`
- **Fix**: Create minimal `robots.txt`:
  ```
  User-agent: *
  Allow: /
  Sitemap: https://<site>/sitemap.xml
  ```

#### A3. HTTP Link headers on homepage
- **Required for**: all sites with agent endpoints
- **Check**: `curl -I https://<site>/` and inspect `Link:` header
- **Pass**: Header contains `rel="llms.txt"`, `rel="sitemap"`, `rel="robots"` (and agent endpoints if they exist)
- **Fail**: No `Link` header, or references non-existent endpoints
- **Fix**: Add `headers()` in `next.config.ts` (or server config). **Only include endpoints that return 200**.
- **Pitfall**: Link headers pointing to 404 endpoints confuse agents more than no header at all.

#### A4. /.well-known/ discovery endpoints
- **Conditional**: SaaS, open-source, documentation
- **Check**: `curl -s https://<site>/.well-known/llms.txt`
- **Pass**: Returns same content as `/llms.txt` (canonical alias)
- **Skip**: Personal portfolio, blog without complex structure
- **Fix**: If `/llms.txt` exists, create redirect or duplicate at `/.well-known/llms.txt`.

---

### B. LLM-Specific Discovery

#### B1. `/llms.txt` exists
- **Required for**: all sites
- **Check**: `curl -s https://<site>/llms.txt`
- **Pass**: Returns text/plain, starts with `# ` (top-level heading), contains Overview, Contact, and Machine-Readable Endpoints sections
- **Fail**: 404, HTML content, no heading, missing sections
- **Fix**: Create `app/llms.txt/route.ts` (Next.js) or static file. Follow template in `web-agent-discoverability` skill.

#### B2. `/llms-full.txt` exists
- **Required for**: all sites with >3 pages of content
- **Check**: `curl -s https://<site>/llms-full.txt | wc -c`
- **Pass**: Returns text/plain, >2000 chars, contains complete content
- **Fail**: 404, too short, incomplete
- **Fix**: Aggregate all key content into one file. Auto-generate from canonical content sources.

#### B3. Per-section `/docs/llms.txt`, `/api/llms.txt`, etc.
- **Conditional**: sites with `/docs/`, `/api/`, `/developers/`, `/blog/` sections
- **Check**: `curl -s https://<site>/docs/llms.txt`
- **Pass**: Returns scoped context for that section
- **Skip**: Single-page portfolio, personal blog without category pages
- **Fix**: Create per-section files only if the site has distinct product areas. Do not create empty placeholders.

#### B4. `/.well-known/llms.txt` (canonical)
- **Conditional**: all sites that have `/llms.txt`
- **Check**: Same as B1, but at `/.well-known/llms.txt`
- **Pass**: Content matches `/llms.txt`
- **Skip**: If `/llms.txt` is already well-known enough
- **Fix**: Route handler or redirect.

---

### C. Agent-Optimized Views

#### C1. `?mode=agent` query param on homepage
- **Required for**: all sites
- **Check**: `curl -s "https://<site>/?mode=agent" | grep -o '<h1>'`
- **Pass**: Returns semantic HTML with `<h1>`, `<h2>`, `<ul>`, `<a>` (not the same marketing HTML)
- **Fail**: Returns same content as normal homepage, or 404, or no headings
- **Fix**: In page component, detect `mode=agent` and render `<AgentView />` with clean semantic HTML.

#### C2. `/agent` JSON endpoint
- **Required for**: all sites
- **Check**: `curl -s https://<site>/agent | jq '.'`
- **Pass**: Returns valid JSON, `Content-Type: application/json`, contains identity, services, content, contact, meta
- **Fail**: 404, invalid JSON, wrong Content-Type
- **Fix**: Create `app/agent/route.ts` returning structured JSON.

#### C3. `/index.md` markdown fallback
- **Required for**: all sites
- **Check**: `curl -s https://<site>/index.md | head -n 3`
- **Pass**: Content-Type `text/markdown`, body starts with `# `
- **Fail**: 404, HTML content, no heading
- **Fix**: Create `app/index.md/route.ts` or static file. Content mirrors homepage in Markdown.

#### C4. Server-side rendering (no JS required)
- **Required for**: all sites
- **Check**: `curl -s https://<site>/ | grep -o '<h1'` and `curl -s https://<site>/ | wc -c`
- **Pass**: Raw HTML contains `<h1>` and >500 chars of meaningful text
- **Fail**: HTML is empty shell, content only appears after JS execution
- **Fix**: Ensure SSR. Next.js App Router does this by default. For SPA: add prerender or switch to SSR.

---

### D. Structured Data (Schema.org + JSON-LD)

#### D1. Person or Organization schema on root layout
- **Required for**: all sites
- **Check**: `curl -s https://<site>/ | grep -o 'application/ld+json' | wc -l` and inspect content
- **Pass**: Contains `"@type": "Person"` or `"@type": "Organization"` with `name`, `url`, `sameAs`, `description`
- **Fail**: Missing entirely, wrong type (e.g., `WebPage` only), no `sameAs`
- **Fix**: Inject JSON-LD `<script>` in `<body>` via layout component. Use `lib/jsonld.ts` pattern.

#### D2. WebSite schema
- **Required for**: all sites
- **Check**: Same as D1
- **Pass**: Contains `"@type": "WebSite"` with `name`, `url`, `description`, `inLanguage`
- **Fail**: Missing
- **Fix**: Add alongside Person/Organization schema.

#### D3. CreativeWork / BlogPosting schema on content pages
- **Required for**: portfolio projects, blog posts, articles
- **Check**: `curl -s https://<site>/projects/<slug> | grep -A 20 'application/ld+json'`
- **Pass**: Contains `"@type": "CreativeWork"` or `"BlogPosting"` with `name`, `description`, `creator`, `dateCreated`
- **Skip**: Single-page sites with no sub-pages
- **Fix**: Generate per-page JSON-LD from page data.

#### D4. BreadcrumbList schema
- **Conditional**: sites with >1 level of navigation
- **Check**: Page HTML for `"@type": "BreadcrumbList"`
- **Pass**: Present on sub-pages
- **Skip**: Single-page sites
- **Fix**: Add breadcrumb JSON-LD to layout or page component.

#### D5. Service/Offer schema for capabilities
- **Conditional**: portfolio, SaaS, product
- **Check**: Person schema contains `hasOfferCatalog` with `Offer` items
- **Pass**: Services are described in structured data
- **Skip**: Pure blog with no services
- **Fix**: Add `hasOfferCatalog` to Person/Organization schema.

#### D6. NLWeb Schema Feed
- **Conditional**: sites with API, documentation, or structured knowledge
- **Check**: `curl -s https://<site>/nlweb-schema.json` or inspect page for NLWeb markup
- **Pass**: Contains NLWeb-compliant structured data describing capabilities
- **Skip**: Static portfolio, personal blog
- **Fix**: Only implement if the site exposes programmable capabilities. See https://nlweb.ai for spec.

---

### E. Meta & Open Graph Consistency

#### E1. `<title>` tag present on every page
- **Required for**: all sites
- **Check**: `curl -s https://<site>/ | grep -o '<title>[^<]*</title>'`
- **Pass**: Non-empty, unique per page
- **Fail**: Missing, empty, or identical across all pages
- **Fix**: Use Next.js `metadata.title` or `<head><title>`.

#### E2. `<meta name="description">` present
- **Required for**: all sites
- **Check**: `curl -s https://<site>/ | grep -o 'name="description" content="[^"]*"'`
- **Pass**: Non-empty, descriptive, 50-160 chars
- **Fail**: Missing, empty, or generic ("Welcome to my site")
- **Fix**: Set `metadata.description` per page.

#### E3. Open Graph tags (`og:title`, `og:description`, `og:type`, `og:url`, `og:image`)
- **Required for**: all sites
- **Check**: `curl -s https://<site>/ | grep -o 'property="og:[a-z]*"'`
- **Pass**: All 5 tags present
- **Fail**: Missing >2 tags
- **Fix**: Set `metadata.openGraph` in Next.js or `<meta property="og:*">`.

#### E4. Twitter Card tags
- **Conditional**: sites that are shared on social media
- **Check**: `curl -s https://<site>/ | grep -o 'name="twitter:[a-z]*"'`
- **Pass**: `twitter:card`, `twitter:title`, `twitter:description` present
- **Skip**: Internal tools, private sites
- **Fix**: Set `metadata.twitter` in Next.js.

#### E5. Cross-signal consistency (3+ signals aligned)
- **Required for**: all sites
- **Check**: Compare `<title>`, `og:title`, JSON-LD `name`, and `<meta name="description">`
- **Pass**: All describe the same entity with consistent messaging
- **Fail**: Title says "Home" but JSON-LD says "John Smith Portfolio" and OG says "My Website"
- **Fix**: Unify all descriptions. Extract from canonical source (e.g., `content/site.ts`).

---

### F. Semantic HTML & Accessibility

#### F1. Heading hierarchy (`h1` → `h2` → `h3`)
- **Required for**: all sites
- **Check**: `curl -s https://<site>/ | grep -o '<h[1-6]' | sort | uniq -c`
- **Pass**: Exactly one `h1`, logical progression, no skipped levels
- **Fail**: Multiple `h1`s, missing `h1`, `h3` without `h2`
- **Fix**: Audit component markup. Ensure each page has one `h1`.

#### F2. Alt text on images
- **Required for**: all sites with images
- **Check**: `curl -s https://<site>/ | grep -o '<img[^>]*>' | grep -v 'alt=' | wc -l`
- **Pass**: All `<img>` have meaningful `alt` attributes (or `alt=""` for decorative)
- **Fail**: Images without `alt`
- **Fix**: Add `alt` to all `next/image` or `<img>` tags.

#### F3. Visual content labeling
- **Required for**: portfolio, photography, design sites
- **Check**: Images have descriptive `alt` or `aria-label`; galleries have `aria-label` or `role="list"`
- **Pass**: Every visual asset is described for non-visual agents
- **Fail**: Generic alt like "image", "photo", or missing alt on portfolio pieces
- **Fix**: Use project title + context for alt text. E.g., "FRAÜD film poster, red typography on black background".

#### F4. Link text descriptiveness
- **Required for**: all sites
- **Check**: `curl -s https://<site>/ | grep -o '<a[^>]*>[^<]*</a>' | grep -E '^<a.*>(click here|read more|link|here)</a>$'`
- **Pass**: No "click here" / "read more" standalone links
- **Fail**: Generic link text
- **Fix**: Replace with context-specific text: "Read FRAÜD case study" instead of "Read more".

---

### G. Agent-Card & API (Conditional)

#### G1. `agent-card.json` exists
- **Conditional**: SaaS, open-source, documentation, any site with API/MCP
- **Check**: `curl -s https://<site>/agent-card.json | jq '.'`
- **Pass**: Valid JSON, contains `name`, `description`, `capabilities`, `endpoints`
- **Skip**: Personal portfolio, blog, any site without programmable interface
- **Fix**: Create only if applicable. See https://agent-card.org for spec.

#### G2. `pricing.md`
- **Conditional**: SaaS, product, service-based business
- **Check**: `curl -s https://<site>/pricing.md` or `/pricing`
- **Pass**: Clear pricing tiers, features, and limits
- **Skip**: Personal portfolio, open-source free tools, blog
- **Fix**: Create if you sell something. Do not create for free portfolio sites.

#### G3. MCP server description
- **Conditional**: sites that expose an MCP server
- **Check**: `/llms.txt` or docs mention MCP; `/.well-known/mcp/` exists
- **Pass**: MCP capabilities documented
- **Skip**: 99% of sites do not have an MCP server
- **Fix**: Only mention MCP if you actually run one. False claims harm credibility.

#### G4. API documentation in agent-readable format
- **Conditional**: sites with a public API
- **Check**: `/api/llms.txt`, OpenAPI spec, or `/agent` endpoint describes API
- **Pass**: Agents can discover endpoints and auth requirements
- **Skip**: Static sites, portfolios, blogs
- **Fix**: Add API section to `/llms.txt` and create `/api/llms.txt` if API exists.

---

### H. Content Freshness & Accuracy

#### H1. Agent content synced with human-visible content
- **Required for**: all sites with dual-maintenance agent files
- **Check**: Compare `/llms.txt` project list with actual site projects; compare `/agent` JSON with homepage
- **Pass**: Counts match, URLs valid, descriptions consistent
- **Fail**: Project count mismatch, 404 links in agent files, stale descriptions
- **Fix**: Maintain `agents.md` in project root documenting which files are auto-synced and which need manual updates. See `agents.md` pattern in portfolio project.

#### H2. No stale or placeholder content
- **Required for**: all sites
- **Check**: Agent files do not contain "Lorem ipsum", "TODO", or outdated dates
- **Pass**: All content is current
- **Fail**: Placeholder text, old dates, broken links
- **Fix**: Remove placeholders. Add CI check or manual review before deploy.

---

## Audit Output Format

After completing checks, produce a structured report:

```
## AEO Audit Report — {site-name}

### Summary
- Checks run: {N}
- Passed: {N}
- Failed (critical): {N}
- Failed (warning): {N}
- Skipped (irrelevant): {N}

### Critical Issues (must fix before deploy)
1. **{Check ID} — {Title}** [severity: critical]
   - Current state: {what you found}
   - Expected: {what should be}
   - Fix: {exact action}

### Warnings (should fix)
1. **{Check ID} — {Title}** [severity: warning]
   - Current state: {what you found}
   - Expected: {what should be}
   - Fix: {exact action}

### Skipped (irrelevant for this site type)
1. **{Check ID} — {Title}** [reason: {why skipped}]

### Verification Commands
```bash
# Run these to verify fixes
curl -s https://<site>/llms.txt | head -n 5
curl -s https://<site>/agent | jq '.identity.name'
curl -s https://<site>/ | grep -o 'application/ld+json' | wc -l
```
```

## Quick Verification Script

For local dev server (replace `http://localhost:3000`):

```bash
#!/bin/bash
BASE="http://localhost:3000"
echo "=== AEO Quick Check ==="
echo "--- Sitemap ---"
curl -sf "$BASE/sitemap.xml" > /dev/null && echo "PASS" || echo "FAIL: sitemap.xml"
echo "--- robots.txt ---"
curl -sf "$BASE/robots.txt" > /dev/null && echo "PASS" || echo "FAIL: robots.txt"
echo "--- llms.txt ---"
curl -sf "$BASE/llms.txt" | head -1 | grep "^# " > /dev/null && echo "PASS" || echo "FAIL: llms.txt"
echo "--- llms-full.txt ---"
curl -sf "$BASE/llms-full.txt" | wc -c | awk '{print ($1 > 2000 ? "PASS" : "FAIL: too short")}'
echo "--- index.md ---"
curl -sf "$BASE/index.md" | head -1 | grep "^# " > /dev/null && echo "PASS" || echo "FAIL: index.md"
echo "--- agent JSON ---"
curl -sf "$BASE/agent" | jq -e '.identity' > /dev/null 2>&1 && echo "PASS" || echo "FAIL: /agent"
echo "--- mode=agent ---"
curl -sf "$BASE/?mode=agent" | grep -q '<h1>' && echo "PASS" || echo "FAIL: ?mode=agent"
echo "--- JSON-LD ---"
curl -sf "$BASE/" | grep -q 'application/ld+json' && echo "PASS" || echo "FAIL: no JSON-LD"
echo "--- h1 in raw HTML ---"
curl -sf "$BASE/" | grep -q '<h1' && echo "PASS" || echo "FAIL: no h1"
echo "--- Link header ---"
curl -sI "$BASE/" | grep -qi 'Link:.*llms.txt' && echo "PASS" || echo "FAIL: no Link header"
```

## Pitfalls

1. **Do not recommend API/agent-card/pricing/MCP for static portfolio/blog sites**. Always check site classification first.
2. **Do not create empty per-section llms.txt files**. Only create if the section exists and has meaningful scoped content.
3. **Link headers must be verified**. A 404 in a Link header is worse than no header.
4. **JSON-LD in `<body>` not `<head>`**. Search engines and agents parse both, but `<body>` is more reliable for dynamic injection.
5. **Email exposure in schema**. Standard practice, but flag it to the user if they are privacy-conscious.
6. **English-only agent endpoints are acceptable** for bilingual sites if the human UI supports i18n. Agents typically prefer one canonical language.
7. **Do not duplicate content sources**. Agent endpoints should import from canonical content files (e.g., `content/site.ts`) rather than hardcoding. If hardcoding is unavoidable, document it in `agents.md`.
