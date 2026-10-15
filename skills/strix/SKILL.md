---
name: strix
description: >-
  Autonomous AI penetration testing, vulnerability discovery, and auto-remediation powered by Strix (https://github.com/usestrix/strix).
  Trigger whenever the user types /strix or asks to pentest, scan security vulnerabilities, run security audits, or test OWASP Top 10 on web apps, APIs, codebases, domains, or repositories.
license: Apache-2.0
metadata:
  author: usestrix
  homepage: https://docs.strix.ai
---

# Strix AI Penetration Testing & Vulnerability Assessment

[Strix](https://github.com/usestrix/strix) is an open-source autonomous AI penetration testing agent that acts like an ethical hacker. Rather than relying on simple static analysis patterns that produce false positives, Strix dynamically interacts with your target, discovers attack surfaces, maps endpoints, and generates verified Proofs-of-Concept (PoCs) for real vulnerabilities.

---

## Slash Command Usage

When the user enters `/strix` in the chat, parse their arguments:

```text
/strix <target> [flags/instructions]
```

### Common Command Patterns:
- **Local Code Analysis (White-Box)**:
  ```powershell
  strix -n -t ./my-project --scan-mode standard --max-budget 10
  ```
- **Web App / API Pentest (Black-Box)**:
  ```powershell
  strix -n -t https://staging.example.com --max-budget 20
  ```
- **Code + Live Deployed App (Combined Coverage)**:
  ```powershell
  strix -n -t ./my-project -t https://staging.example.com --max-budget 25
  ```
- **Focused Testing with Credentials / Scope**:
  ```powershell
  strix -n -t https://staging.example.com --instruction "Focus on IDOR and broken object level authorization. Test user: user@example.com / password123"
  ```
- **API Spec Testing (OpenAPI / Swagger / Postman)**:
  ```powershell
  strix -n -t ./openapi.yaml -t https://api.staging.example.com
  ```
- **Strix Cloud (Managed, No Docker / No Local Compute)**:
  ```powershell
  strix cloud scans start --source . --yes --wait
  ```

---

## Execution Modes: Local OSS vs Strix Cloud

### 1. Local Open-Source CLI (`strix -n -t ...`)
- **Requirements**:
  1. **Docker**: Docker Desktop must be running (`docker ps`). If stopped on Windows, launch it with:
     ```powershell
     Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
     ```
  2. **LLM Provider**: Supported models via LiteLLM:
     ```powershell
     $env:STRIX_LLM = "openai/gpt-4o" # or anthropic/claude-3-7-sonnet-20250219, gemini/gemini-2.5-pro, etc.
     $env:LLM_API_KEY = "your-api-key"
     ```
     Or configure persistently in `~/.strix/cli-config.json`.
- **Sandbox**: Automatically pulls and isolates runs inside the Strix sandbox Docker container.

### 2. Managed Strix Cloud (`strix cloud ...`)
- **No Docker required**, no local LLM API key needed.
- Commands:
  ```powershell
  strix cloud login          # Authenticate / create workspace
  strix cloud domains add    # Register target domain
  strix cloud scans start    # Launch cloud pentest
  strix cloud vulns list     # Review findings
  ```

---

## Critical CLI Flags

| Flag | Description |
|---|---|
| `-n, --non-interactive` | **MANDATORY for AI agents.** Bypasses interactive TUI, preventing hangs. |
| `-t, --target <TARGET>` | Target URL, local path, git repo, domain, IP, or OpenAPI spec. Repeatable. |
| `--target-list <PATH>` | File containing one target per line. |
| `-m, --scan-mode` | `quick` (fast CI check), `standard` (~15-30m), `deep` (thorough, default). |
| `--max-budget <USD>` | Hard spending limit for LLM API cost in USD. Strix wraps up cleanly at limit. |
| `--instruction "<TEXT>"` | Focus areas, credentials, testing rules, or out-of-scope boundaries. |
| `--workspace-file <PATH>` | Copies auxiliary files (wordlists, specs) into `/workspace` inside sandbox. |
| `--fail-on <SEVERITY>` | Exit code `2` only when finding meets or exceeds severity (`critical`, `high`, `medium`, `low`). |
| `--resume [RUN_NAME]` | Resumes a previous scan from `strix_runs/`. |

---

## Reading & Reporting Results

When a scan completes, Strix outputs all artifacts under `strix_runs/<run-name>/`:

1. **`penetration_test_report.md`**:
   - Executive summary of discovered vulnerabilities.
   - Attack paths and risk ratings.
2. **`vulnerabilities/`**:
   - Individual markdown files for each validated finding.
   - Contains:
     - Vulnerability description & CVSS score
     - Step-by-step reproduction proof-of-concept (PoC)
     - Exact affected endpoint or source code line
     - Remediation patch guidance
3. **`vulnerabilities.json` / `vulnerabilities.csv`**:
   - Machine-readable structured vulnerability exports.
4. **`findings.sarif`**:
   - Standard SARIF report for GitHub Code Scanning / CI integration.

---

## Safety & Ethics
- Only scan applications and infrastructure that the user owns or has explicit written permission to test.
- Confirm target scope before initiating aggressive scans on external targets.
