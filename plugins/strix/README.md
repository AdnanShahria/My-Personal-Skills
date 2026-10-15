# Strix Plugin for Antigravity

Autonomous AI penetration testing, vulnerability discovery, and auto-remediation powered by [Strix](https://github.com/usestrix/strix).

## Features
- **Autonomous Multi-Agent Pentesting**: Cooperating AI agents emulate ethical hackers to explore applications, map APIs, and probe attack surfaces.
- **Validated Proof-of-Concepts (PoCs)**: Generates and executes working exploit PoCs to verify real vulnerabilities instead of false positives.
- **Dual Execution**: Run self-hosted locally in an isolated Docker sandbox with BYO-LLM, or connect to managed Strix Cloud (`strix cloud`).
- **Comprehensive Findings**: Full penetration test reports, SARIF export, CVSS ratings, and automated remediation suggestions.

## Slash Command
Trigger directly in chat:
```text
/strix <target> [options]
```

### Examples:
- `/strix ./my-app`
- `/strix https://staging.example.com --max-budget 15`
- `/strix ./backend -t https://api.staging.example.com`
- `/strix https://example.com --instruction "Focus on SQLi and auth bypass"`
- `/strix cloud scans start --source .`
