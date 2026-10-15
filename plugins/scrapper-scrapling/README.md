# Scrapper-Scrapling Plugin for Antigravity

Adaptive, undetectable web scraper and MCP server integration powered by [Scrapling](https://github.com/D4Vinci/Scrapling).

## Features
- **Anti-Bot Protection Bypass**: Bypasses Cloudflare Turnstile, Datadome, Kasada, and headless browser detectors.
- **Dynamic JavaScript Support**: Renders SPAs and complex interactive pages seamlessly.
- **Adaptive Auto-Healing Selectors**: Fingerprints elements so scrapers don't break when CSS/HTML layout changes.
- **AI-Optimized Content Extraction**: Automatically strips boilerplate and extracts clean markdown or structured text for LLMs.
- **MCP Server & CLI**: Operates both as a Model Context Protocol (MCP) server (`scrapling-mcp`) and a powerful CLI (`scrapling`).

## Trigger
Use the slash command in chat:
```text
/scrapper-scrapling <URL> [optional extraction goal or selector]
```

## Examples
- `/scrapper-scrapling https://example.com`
- `/scrapper-scrapling https://news.ycombinator.com extract top 5 headlines and URLs`
- `/scrapper-scrapling https://quotes.toscrape.com -s .quote`
