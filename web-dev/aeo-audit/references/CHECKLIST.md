# AEO Audit: Full Checklist Reference

This file contains the complete audit checklist that the agent iterates through. The main `SKILL.md` contains summaries; this reference expands every check with full detail.

## A. Discovery & Crawlability

### A1. Sitemap (`/sitemap.xml`)
- Must return valid XML with `<urlset>` or `<sitemapindex>`
- Must include all indexable pages
- Should include `<lastmod>` dates for content freshness signals

### A2. robots.txt (`/robots.txt`)
- Must not blanket `Disallow: /`
- Should include `Sitemap:` directive pointing to sitemap
- Should not block agent endpoints (`/llms.txt`, `/agent`, etc.)

### A3. HTTP Link Headers
- Set on the homepage (`/`)
- Must include: `</llms.txt>; rel="llms.txt"`, `</sitemap.xml>; rel="sitemap"`, `</robots.txt>; rel="robots"`
- Should include agent endpoints if they exist: `</agent>; rel="agent-catalog"`, `</index.md>; rel="index.md"`, `</llms-full.txt>; rel="llms-full.txt"`
- **Critical pitfall**: Only reference endpoints that return HTTP 200. A 404 in a Link header is worse than no header.

### A4. `/.well-known/llms.txt`
- Optional alias for `/llms.txt`
- Useful if other tools expect the `.well-known` path
- Can be a redirect or duplicate content

## B. LLM Discovery

### B1. `/llms.txt`
Format: plain text, top-level `# ` heading.

Required sections:
- `# {Name} — {Tagline}`
- `## Overview` — what the site does
- `## Services / Capabilities` — key offerings
- `## Contact` — email, location
- `## Machine-Readable Endpoints` — list of agent URLs

### B2. `/llms-full.txt`
- Complete site content in a single file
- Should be >2000 chars for sites with >3 pages
- Auto-generate from canonical content sources when possible
- Include: identity, services, projects, about, contact, navigation, agent endpoints

### B3. Per-section `llms.txt`
- Only create if the site has distinct sections (`/docs/`, `/api/`, `/blog/`)
- Each file provides scoped context for that section
- Do NOT create empty placeholders

### B4. `/.well-known/llms.txt`
- Alias for B1
- Optional, but recommended for standards compliance

## C. Agent Views

### C1. `?mode=agent` on Homepage
- Must return DIFFERENT content from normal homepage — not the same marketing HTML
- Must be semantic HTML: `<h1>`, `<h2>`, `<ul>`, `<li>`, `<a>` with direct hrefs
- No heavy CSS frameworks, no JavaScript-dependent content
- Light inline styles acceptable for readability
- Include: identity, services, projects, contact, navigation, machine-readable endpoints

### C2. `/agent` JSON Endpoint
Response schema:
```json
{
  "identity": { "name": "...", "roles": [...] },
  "services": [{ "name": "...", "description": "..." }],
  "projects": [{ "slug": "...", "title": "...", "url": "..." }],
  "contact": { "email": "...", "linkedIn": "..." },
  "meta": {
    "website": "...",
    "llmsTxt": "...",
    "agentEndpoint": "...",
    "markdownVersion": "..."
  }
}
```

Headers:
- `Content-Type: application/json; charset=utf-8`
- `X-Robots-Tag: noindex`
- `Cache-Control: public, max-age=3600`

### C3. `/index.md` Markdown Fallback
- Content-Type: `text/markdown; charset=utf-8`
- Body must start with `# ` (top-level heading)
- Mirrors homepage content in Markdown
- Include agent endpoint links at the bottom

### C4. Server-Side Rendering
- Raw HTML must contain meaningful content without JS execution
- Must have `<h1>` and >500 chars of text in the HTML response
- Next.js App Router satisfies this by default
- SPA frameworks (React Router, Vue Router) may need prerendering

## D. Structured Data (Schema.org)

### D1. Person / Organization Schema
Required fields:
- `name`, `url`, `description`
- `sameAs` — array of external profiles (LinkedIn, GitHub, etc.)
- `jobTitle` or `knowsAbout` for capabilities
- `email` (optional but standard)

### D2. WebSite Schema
- `name`, `url`, `description`, `inLanguage`
- Injected on every page (typically via root layout)

### D3. CreativeWork / BlogPosting Schema
- Per-page schema for projects, articles, blog posts
- `name`, `description`, `creator` (Person type), `dateCreated`, `keywords`
- `image` and `thumbnailUrl` if cover image exists

### D4. BreadcrumbList Schema
- For sites with hierarchical navigation
- Map each navigation level to `ListItem` with `name` and `item`

### D5. Service / Offer Schema
- Use `hasOfferCatalog` on Person/Organization
- Each service is an `Offer` with `itemOffered` → `Service`
- `name` and `description` for each service

### D6. NLWeb Schema Feed
- Only for sites with programmatic capabilities (API, MCP, etc.)
- Feed URL typically `/nlweb-schema.json`
- Describes capabilities in NLWeb format
- Skip for static portfolio, blog, documentation sites

## E. Meta & Open Graph

### E1. `<title>` Tag
- Unique per page
- Descriptive, not generic ("Home" is bad)

### E2. `<meta name="description">`
- 50-160 characters
- Descriptive, keyword-relevant
- Unique per page

### E3. Open Graph Tags (5 required)
- `og:title` — matches `<title>`
- `og:description` — matches meta description
- `og:type` — usually `website` or `article`
- `og:url` — canonical URL
- `og:image` — 1200×630 recommended

### E4. Twitter Card Tags
- `twitter:card` — `summary_large_image` recommended
- `twitter:title`, `twitter:description`
- Optional: `twitter:image`, `twitter:site`

### E5. Cross-Signal Consistency
All these signals must describe the same entity with consistent messaging:
- `<title>` tag
- `og:title`
- JSON-LD `name` (Person/WebSite)
- `<meta name="description">`
- `og:description`
- JSON-LD `description`

Minimum 3 signals must be aligned. Mismatches confuse agents.

## F. Semantic HTML & Accessibility

### F1. Heading Hierarchy
- Exactly one `<h1>` per page
- Logical progression: h1 → h2 → h3 (no skipped levels)
- No multiple h1s

### F2. Alt Text on Images
- All `<img>` tags must have `alt` attribute
- Decorative images: `alt=""`
- Content images: descriptive alt text

### F3. Visual Content Labeling
- Portfolio images: alt = project title + context
- Gallery containers: `role="list"` or `aria-label`
- Avoid generic alt like "image" or "photo"

### F4. Link Text
- No standalone "click here", "read more", "link"
- Use context-specific text: "Read FRAÜD case study"

## G. Agent-Card & API (Conditional)

### G1. `agent-card.json`
- Only for sites with API, MCP, or programmable interface
- Contains `name`, `description`, `capabilities`, `endpoints`
- See https://agent-card.org for spec

### G2. `pricing.md`
- Only for SaaS, product, or service-based business
- Clear tiers, features, limits
- Skip for personal portfolio, blog, free OSS

### G3. MCP Server Description
- Only if you actually run an MCP server
- Document in `/llms.txt` or dedicated endpoint
- Do not claim MCP if you don't have one

### G4. API Documentation
- Only for sites with public API
- Agent-readable format: OpenAPI spec, `/api/llms.txt`, or structured docs
- Include auth requirements and endpoint descriptions

## H. Content Freshness

### H1. Human-Agent Sync
- Agent files must reflect current human-visible content
- Check: project counts match, URLs valid, descriptions consistent
- Maintain `agents.md` documenting auto-sync vs manual-update files

### H2. No Placeholders
- No "Lorem ipsum", "TODO", "Coming soon"
- No outdated dates or broken links
