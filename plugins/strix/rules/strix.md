---
trigger: always_on
description: Automatically execute the strix penetration testing skill when /strix is invoked in chat.
---

# Strix Slash Command Trigger

When the user enters `/strix` in the chat, or asks to pentest, audit, or scan for vulnerabilities using Strix:
1. Immediately activate and follow the `strix` skill (or the relevant specialized sub-skill such as `penetration-testing-with-strix`, `find-security-vulnerabilities-in-code`, `fix-security-vulnerabilities-with-strix`, or `managed-pentesting-with-strix`).
2. Parse the user's prompt to identify:
   - **Target**: URL (e.g. `https://staging.example.com`), local codebase (e.g. `./` or a directory), GitHub repo (`https://github.com/org/repo`), domain, IP, or API specification (`openapi.yaml` / Postman collection).
   - **Execution Environment**:
     - **Local Open-Source CLI**: Self-hosted Docker sandbox, uses local LLM API key (`STRIX_LLM` & `LLM_API_KEY`).
     - **Strix Cloud**: Hosted managed pentest (`strix cloud ...`), no Docker or local LLM setup needed.
   - **Scan Parameters**:
     - Scan mode: `--scan-mode` (`quick`, `standard`, `deep`).
     - Spending cap: `--max-budget <USD>` (e.g. `--max-budget 10`).
     - Custom instructions: `--instruction "<details>"` (e.g. focus on auth, IDOR, SQLi, test credentials).
     - Workspace files: `--workspace-file <path>` (wordlists, specs).
3. Check and verify prerequisites:
   - For **Local OSS Runs**:
     - Check if Docker is running (`docker info` or `docker ps`). If Docker Desktop is stopped, help the user start it (`Start-Process 'C:\Program Files\Docker\Docker\Docker Desktop.exe'`).
     - Check if `STRIX_LLM` and `LLM_API_KEY` (or `OPENAI_API_KEY`, etc.) are configured. If missing, prompt the user or help them configure `~/.strix/cli-config.json`.
   - For **Cloud Runs**:
     - Check `strix cloud auth status` / `strix cloud login`.
4. Execute via the CLI:
   - **CRITICAL**: Always include `-n` (or `--non-interactive`) because Strix defaults to an interactive TUI which blocks in automated environments.
   - Example local command:
     ```powershell
     strix -n -t <TARGET> --scan-mode standard --max-budget 10
     ```
   - Run long-running scans asynchronously and monitor the output artifacts.
5. Review and report findings:
   - Read the executive report at `strix_runs/<run-name>/penetration_test_report.md`.
   - Check validated findings in `strix_runs/<run-name>/vulnerabilities/`.
   - Summarize by severity (Critical, High, Medium, Low), present the reproduction steps / proof of concept, and guide the user on remediation.
