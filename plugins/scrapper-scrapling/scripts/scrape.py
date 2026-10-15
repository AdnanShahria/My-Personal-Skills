#!/usr/bin/env python3
"""
Scrapling execution script for Antigravity.
Supports stealth, dynamic, and standard requests with anti-bot bypass.
"""
import argparse
import sys
import json
from scrapling import Fetcher, StealthyFetcher, DynamicFetcher, Adaptor

def main():
    parser = argparse.ArgumentParser(description="Scrapling web scraper runner")
    parser.add_argument("url", help="Target URL to scrape")
    parser.add_argument("--mode", choices=["stealth", "dynamic", "get"], default="stealth", help="Fetcher mode")
    parser.add_argument("--selector", "-s", help="CSS selector to extract specific elements", default=None)
    parser.add_argument("--solve-cloudflare", action="store_true", default=True, help="Automatically solve Cloudflare challenges")
    parser.add_argument("--output", "-o", help="Save output to file path", default=None)
    parser.add_argument("--format", choices=["markdown", "text", "html"], default="markdown", help="Output format")
    
    args = parser.parse_args()

    try:
        if args.mode == "stealth":
            response = StealthyFetcher.fetch(
                args.url,
                solve_cloudflare=args.solve_cloudflare,
                headless=True
            )
        elif args.mode == "dynamic":
            response = DynamicFetcher.fetch(args.url, headless=True)
        else:
            fetcher = Fetcher()
            response = fetcher.get(args.url)

        adaptor = Adaptor(response.text)

        if args.selector:
            elements = adaptor.css(args.selector)
            content = "\n".join([el.text for el in elements if el.text])
        else:
            content = response.text

        if args.output:
            with open(args.output, "w", encoding="utf-8") as f:
                f.write(content)
            print(f"Content saved to {args.output}")
        else:
            print(content[:4000])

    except Exception as e:
        print(f"Error scraping {args.url}: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
