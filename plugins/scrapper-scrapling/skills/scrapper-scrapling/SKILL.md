---
name: scrapper-scrapling
description: >-
  Adaptive, undetectable web scraping, content extraction, and anti-bot bypassing powered by Scrapling (https://github.com/D4Vinci/Scrapling).
  Trigger whenever the user types /scrapper-scrapling, /scrapling, or asks to scrape web pages, bypass Cloudflare/Turnstile/Datadome protections, extract structured data from websites, or crawl dynamic JS sites.
---

# Scrapling Web Scraper & Anti-Bot Bypass

This skill provides undetectable, adaptive web scraping capabilities powered by [Scrapling](https://github.com/D4Vinci/Scrapling).

Scrapling solves major web scraping challenges:
1. **Anti-Bot Protections**: Bypasses Cloudflare Turnstile, Datadome, Kasada, and bot detection systems via TLS fingerprint impersonation, canvas noise injection, and WebRTC masking.
2. **Dynamic JavaScript Rendering**: Renders modern SPA and JavaScript-heavy pages using stealth Chromium instances.
3. **Adaptive Auto-Healing Selectors**: Element fingerprinting locates target elements even after websites update their HTML/CSS layout.
4. **AI-Targeted Token Reduction**: Automatically strips hidden boilerplate, navigation noise, and scripts, returning clean markdown or structured text.

---

## When to Activate

Activate this skill immediately when:
- The user inputs `/scrapper-scrapling` or `/scrapling` in the prompt.
- The user requests to scrape, extract, or crawl any website or URL using Scrapling.
- Standard HTTP fetching or reading fails due to Cloudflare, bot challenges, or JavaScript execution requirements.

---

## Execution Methods

### Method 1: Scrapling CLI (`scrapling extract`)

The CLI is installed globally at `C:\Users\Adnan\.local\bin\scrapling.exe` and is accessible on the system PATH.

#### 1. Stealthy Fetch (For Cloudflare, Turnstile, Protected Sites)
```powershell
scrapling extract stealthy-fetch --solve-cloudflare --ai-targeted "<URL>" output.md
```
Key options:
- `--solve-cloudflare`: Automatically solve Cloudflare challenges.
- `--ai-targeted`: Sanitize hidden elements and extract main content only for token-efficient LLM consumption.
- `-s, --css-selector <SELECTOR>`: Extract specific elements matching the selector.
- `--wait-selector <SELECTOR>`: Wait for a specific element before extracting.
- `--block-webrtc`: Prevent WebRTC IP leaks.
- `--hide-canvas`: Spoof canvas fingerprinting.
- `--timeout <MS>`: Request timeout in milliseconds (default: 30000).

#### 2. Dynamic Fetch (For JavaScript-Rendered Sites)
```powershell
scrapling extract fetch --ai-targeted "<URL>" output.md
```

#### 3. Fast HTTP Request (For Static / Low-Protection Sites)
```powershell
scrapling extract get --ai-targeted "<URL>" output.md
```

Output formats are determined automatically by the file extension:
- `.md`: Clean Markdown
- `.txt`: Plain Text
- `.html`: Raw/Cleaned HTML

---

### Method 2: Scrapling MCP Server

Scrapling includes an official Model Context Protocol (MCP) server located at `C:\Users\Adnan\.local\bin\scrapling-mcp.exe`.

Available MCP tools:
- `stealthy_fetch`: Stealth browser fetch with anti-bot bypass and Cloudflare solver.
- `fetch`: Headless browser fetch for dynamic JavaScript rendering.
- `make_request`: High-speed plain HTTP request (GET, POST, PUT, DELETE).
- `bulk_stealthy_fetch` / `bulk_fetch` / `bulk_get`: Parallel multi-URL fetching.
- `open_session`, `session_fetch`, `close_session`: Maintain cookies and browser state across sequential calls.
- `screenshot`: Capture full-page visual screenshots.

---

### Method 3: Python Automation Script

For custom data parsing, pagination, or multi-field structured extraction, use the Python API via `uv run`:

```python
from scrapling import StealthyFetcher, Fetcher, Adaptor

# Stealth fetch with anti-bot solver
page = StealthyFetcher.fetch(
    "https://example.com",
    solve_cloudflare=True,
    headless=True
)

# Adaptive extraction (auto-heals if classes/attributes change)
items = page.css(".product-card")
results = []
for item in items:
    title = item.css(".title::text").get()
    price = item.css(".price::text").get()
    results.append({"title": title, "price": price})

print(results)
```

Run directly:
```powershell
uv tool run --from "scrapling[ai]" python -c "..."
```

---

## Workflow for `/scrapper-scrapling` Prompts

When a user prompts with `/scrapper-scrapling`:

1. **Analyze Input**:
   - Extract the target URL(s).
   - Identify the user's extraction goal (e.g., text summary, specific fields, tables, links, or full content).
   - Check if the site is known for heavy bot protection (e.g. Cloudflare) or dynamic content.

2. **Select Tool**:
   - For protected or unknown modern sites: Use `stealthy-fetch` with `--solve-cloudflare` and `--ai-targeted`.
   - For fast content retrieval: Use `get` with `--ai-targeted`.
   - For specific elements: Pass `-s` with the CSS selector.

3. **Execute & Retrieve**:
   - Save the output to a temporary markdown file in scratch (e.g., `scratch/scrape_<timestamp>.md`).
   - Read the extracted content.
   - Clean up temporary files if no longer needed.

4. **Deliver Results**:
   - Present the extracted information clearly in Markdown or structured tables/JSON as requested.
   - If the site blocked access or required extra interaction, explain the bypass flags used.
