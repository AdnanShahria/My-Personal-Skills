---
name: geo-ready-website
description: >-
  Audit and optimize websites for Generative Engine Optimization (GEO), AI search engines
  (ChatGPT/SearchGPT, Perplexity, Google AI Overviews, Gemini, Claude), and local SEO indexing
  readiness. Use when evaluating a site's AI search visibility, llms.txt presence, Schema.org
  structured entities, semantic landmarks, content extractability, and local business signals.
---

# Generative Engine Optimization (GEO) & AI Readiness Audit

## Overview

Generative Engine Optimization (GEO) is the practice of optimizing digital content and technical architecture so generative AI search systems (Perplexity, ChatGPT Search, Google AI Overviews, Gemini, and Claude) can discover, parse, trust, and cite your website as a definitive source.

While traditional SEO focuses on rankings for keywords across "10 blue links", GEO optimizes for:
- **Direct Fact & Answer Extraction**: How easily an LLM can isolate concise, verifiable claims and data tables.
- **Knowledge Graph Entity Linking**: Schema.org JSON-LD with unambiguous `sameAs` entity identifiers (Wikidata, Wikipedia, LinkedIn, official profiles).
- **AI Agent Crawlability**: Explicit permissions for AI bots (`GPTBot`, `PerplexityBot`, `ClaudeBot`, `Google-Extended`) and machine-readable context (`/llms.txt`).
- **Semantic Structure**: Strict HTML5 landmarks (`<main>`, `<article>`) and heading hierarchy (H1 -> H2 -> H3) without skipped levels.
- **Local Business & Geo Footprint**: NAP (Name, Address, Phone) consistency, geo coordinates, and regional signals for localized generative answers.

---

## The 6 Pillars of a GEO Audit

### Pillar 1: AI Agent & Crawler Accessibility
1. **Robots.txt AI Directives**:
   - Check `/robots.txt` to verify whether AI crawlers are welcomed or unintentionally blocked:
     - `GPTBot` (OpenAI training/search)
     - `OAI-SearchBot` (ChatGPT real-time web search)
     - `PerplexityBot` (Perplexity search and citations)
     - `ClaudeBot` / `anthropic-ai` (Anthropic Claude search/browse)
     - `Google-Extended` (Google Gemini / Vertex AI controls)
     - `Applebot-Extended` (Apple Intelligence)
2. **`llms.txt` and `llms-full.txt`**:
   - Check if the site serves a standardized markdown index at `/llms.txt` (or `/llms-full.txt`).
   - Format includes project overview, primary documentation links, core entities, and contact information.
3. **Indexability & Canonical Hygiene**:
   - Verify that primary pages do not carry accidental `noindex` or `nofollow` robots meta tags.
   - Verify self-referencing canonical URLs (`<link rel="canonical" href="...">`) to eliminate duplicate content confusion for LLM scrapers.

### Pillar 2: Knowledge Graph & Structured Data (Schema.org)
1. **JSON-LD Presence & Validity**:
   - Inspect `<script type="application/ld+json">` tags. Ensure syntax parses cleanly without JSON errors.
2. **Core Entity Definitions**:
   - Must contain structured nodes for `@type: "Organization"` or `@type: "LocalBusiness"`.
   - Recommended nodes: `WebSite`, `WebPage`, `Article`, `Product`, `FAQPage`, `BreadcrumbList`.
3. **Entity Disambiguation (`sameAs`)**:
   - Ensure the entity has a `sameAs` array linking to external authority profiles:
     - Wikipedia / Wikidata IDs
     - LinkedIn organization URL
     - Official Twitter / X handle
     - GitHub, Crunchbase, or industry directories
4. **LocalBusiness Schema (for local sites)**:
   - Must include `PostalAddress` (`streetAddress`, `addressLocality`, `addressRegion`, `postalCode`, `addressCountry`).
   - Must include `telephone`, `geo` coordinates (`latitude`, `longitude`), and `openingHoursSpecification`.

### Pillar 3: Semantic Architecture & Accessibility Landmarks
1. **HTML5 Landmarks**:
   - Single `<main>` element enclosing primary content.
   - Distinct `<header>`, `<nav>`, `<article>`, `<section>`, and `<footer>` elements.
2. **Strict Heading Hierarchy**:
   - Exactly one `<h1>` per page summarizing the core topic.
   - Strict hierarchical order: `h1` -> `h2` -> `h3` (never skip from `h2` to `h4`).
3. **Accessibility Signals**:
   - ARIA landmarks (`role`, `aria-label`, `aria-labelledby`) where semantic HTML alone is ambiguous.
   - Image `alt` attribute coverage: at least 80% of images must have concise, descriptive alt text.

### Pillar 4: Content Extractability & Information Gain
1. **Inverted Pyramid & Direct Answers**:
   - Key definitions, answers, and summaries should appear in the first 1–2 sentences under headings.
   - Avoid fluffy transitional text; state the answer first, then provide supporting context.
2. **Readability & Sentence Cadence**:
   - Target Flesch Reading Ease score of **50–70** (plain English, high factual density).
   - Paragraph length: 30–70 words per paragraph.
3. **Structured Quotable Data**:
   - Use comparison markdown tables, bulleted lists, and step-by-step procedures. LLMs prioritize tabular data for comparative queries.

### Pillar 5: Local Signals & Geo Footprint (Local SEO Readiness)
1. **NAP Consistency**:
   - Name, Address, and Phone number in the visible DOM must match the JSON-LD schema verbatim.
2. **Geo Metadata**:
   - Look for `geo.region`, `geo.placename`, `geo.position`, `ICBM` meta tags or Open Graph `og:locale`.
3. **Hreflang & Multi-Region Support**:
   - For multi-market websites, verify `<link rel="alternate" hreflang="..." href="...">` tags.
4. **Local Entity Density**:
   - Presence of relevant geographic landmarks, city names, and neighborhood mentions.

### Pillar 6: The 100-Point GEO Scoring Framework

| Component | Max Points | Evaluation Criteria |
| :--- | :--- | :--- |
| **Schema & JSON-LD** | 30 | Full LocalBusiness/Organization JSON-LD = 30; Basic JSON-LD = 15; None = 0 |
| **Address & NAP** | 15 | Address in JSON-LD = 15; City/address in body text only = 6; None = 0 |
| **Phone Number** | 15 | Valid phone in schema/DOM with click-to-call link = 15; None = 0 |
| **Geo Coordinates** | 10 | Latitude/Longitude in schema or meta tags = 10; None = 0 |
| **Geo Meta Tags** | 5 | `geo.position` / `geo.region` / `og:locale` present = 5 |
| **Hreflang & Regional**| 10 | Valid hreflang or localized language headers = 10; None = 0 |
| **Local Entity Density**| 10 | 3+ local geographic entity mentions = 10; 1-2 mentions = 4; None = 0 |
| **AI Signals (`llms.txt`)**| 5 | `llms.txt` present = 5; basic crawler allowance = 2 |
| **Total Possible** | **100** | **Score >= 80: GEO Ready; 50-79: Moderate; < 50: Poor** |

---

## Step-by-Step Audit Workflow

1. **Input Collection**:
   - Target website URL (e.g., `https://example.com`).
   - Primary business type, target geography, and key brand entities.
2. **Crawl & Inspection**:
   - Fetch the homepage, key product/landing pages, and `/robots.txt` + `/llms.txt`.
   - Run the included audit script:
     ```bash
     node scripts/geoaudit.js https://example.com
     ```
     *(If `SCRAPING_KEY` is provided in `.env`, the script utilizes Scrapeless cloud browser for JavaScript-heavy single-page apps; otherwise it executes via standard HTTP fetch).*
3. **Analyze Results**:
   - Check the 6 pillars against the scraped DOM and structured data.
   - Calculate the GEO Score (0–100) and identify critical deficiencies.
4. **Generate Prioritized Action Plan**:
   - Group recommendations by **Critical (immediate indexability blockers)**, **High (entity/schema fixes)**, and **Medium/Low (content formatting & microdata)**.

---

## Output Report Template

When delivering a GEO audit report to the user, format it as follows:

```markdown
# GEO Readiness & Local SEO Audit: <Target Domain>

**Overall GEO Score**: <Score>/100 [<Rating: Excellent / GEO Ready / Needs Optimization / At Risk>]
**AI Crawlability Status**: <Allowed / Partially Blocked / Disallowed>
**Knowledge Graph Readiness**: <High / Moderate / Low>

---

## Score Breakdown
- **Structured Data & Entity Graph**: X/30
- **Address & NAP Consistency**: X/15
- **Contact & Phone Verification**: X/15
- **Geographic Coordinates**: X/10
- **Geo Meta Tags & Regional Targeting**: X/5
- **Hreflang & Multi-Language Signals**: X/10
- **Local Entity Density**: X/10
- **AI Agent Discoverability (`llms.txt`)**: X/5

---

## Critical Findings & Remediation

### 1. AI Crawler Accessibility (`robots.txt` & `llms.txt`)
- **Status**: <Findings>
- **Fix**: <Exact robots.txt or llms.txt snippet to deploy>

### 2. Entity Disambiguation & Schema.org JSON-LD
- **Status**: <Findings>
- **Fix**: <Exact JSON-LD script ready to copy-paste>

### 3. Semantic Structure & Heading Architecture
- **Status**: <Findings on H1-H6, landmarks, and ARIA>
- **Fix**: <Structural changes needed>

### 4. Content Quality for LLM Citations
- **Status**: Flesch Readability Score = <Score> (<Label>)
- **Fix**: <Specific direct-answer formatting and tabular suggestions>

---

## Prioritized Action Checklist
1. [ ] **Immediate**: <Top issue>
2. [ ] **Quick Win**: <Fast fix>
3. [ ] **Strategic**: <Durable optimization>
```
