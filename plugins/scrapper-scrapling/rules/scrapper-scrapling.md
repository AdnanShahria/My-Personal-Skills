---
trigger: always_on
description: Automatically execute the scrapper-scrapling skill when /scrapper-scrapling or /scrapling is invoked in chat.
---

# Scrapper-Scrapling Slash Command Trigger

When the user enters `/scrapper-scrapling` or `/scrapling` in the chat, or asks to scrape web content using Scrapling:
1. Immediately activate and follow the `scrapper-scrapling` skill.
2. Parse the user's prompt to identify:
   - Target URL(s) to scrape or crawl.
   - Specific data fields, CSS selectors, or extraction goals.
   - Protection level required (e.g. Cloudflare Turnstile, Datadome, dynamic JavaScript, or basic HTTP).
   - Desired output format (structured JSON, markdown, raw text, or saved file).
3. Execute the extraction using Scrapling via:
   - **Scrapling CLI**: `scrapling extract stealthy-fetch --solve-cloudflare --ai-targeted <URL> <OUTPUT_FILE>` (or `get`/`fetch`).
   - **Scrapling MCP Tools**: `stealthy_fetch`, `fetch`, `make_request`, `open_session`, etc.
   - **Scrapling Python API**: `from scrapling import Fetcher, StealthyFetcher, Adaptor`.
4. Return clean, formatted results directly to the user or save to the specified file.
