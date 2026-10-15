# ADNAN SKILLS & PLUGINS

Custom skills, plugins, slash commands, and configuration presets for Google Antigravity.

---

## 🌟 Highlights

### `/spin_subagents` (Unified Multi-Agent Orchestrator)
Located at [`plugins/spin-subagents/`](plugins/spin-subagents/) and [`skills/spin-subagents/`](skills/spin-subagents/).

Synthesizes eight core agentic subsystems into a single autonomous command:
* **Antigravity Harness Native Subagents**: `invoke_subagent` (concurrent mass dispatch), `define_subagent`, `manage_subagents`, `send_message`.
* **`/teamwork-preview`**: Dynamic work-package partitioning, role-specialized team generation, and parallel orchestrator/worker execution.
* **`/boost`**: Deep thinking, multi-perspective strategic planning, adversarial stress-testing, and rigorous verification contracts.
* **`/grill-me`**: Rapid up-front de-risking and clarification to resolve critical decision forks before burning compute.
* **`/plan`**: Architectural design, milestone sequencing, and dependency graphs.
* **`Spec-Kit` (SDD)**: Spec-Driven Development: functional specs (`spec.md`), work breakdown (`tasks.md`), contracts, and convergence auditing (`converge`).
* **`apple-design`**: Human Interface Guidelines (HIG), craft, visual hierarchy, touch targets, contrast ratios, and design excellence.
* **`codebase-memory-mcp`**: Zero-waste structural AST discovery (`search_graph`, `trace_path`, `get_architecture`) consuming 99% fewer tokens than file searches.

**Fleet Capability**: Capable of scaling from 2 to 6 focused subagents up to **20 to 30 concurrent subagents** in a single turn.

---

## 🔗 Connected Upstream GitHub Repositories

All external skills and plugins in this repository are mapped to their authoritative open-source upstream repos in [`upstream-remotes.json`](upstream-remotes.json):

| Skill / Plugin | Upstream GitHub Repository | Purpose |
| :--- | :--- | :--- |
| **`apple-design-skill`** | [dickwu/apple-design-skill](https://github.com/dickwu/apple-design-skill) | 120+ pages Apple HIG & Liquid Glass review |
| **`cloudflare-security-audit`** | [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) | 6-phase source-first vulnerability auditor |
| **`spec-kit`** | [github/spec-kit](https://github.com/github/spec-kit) | Spec-Driven Development (SDD) suite |
| **`strix`** | [usestrix/strix](https://github.com/usestrix/strix) | Autonomous AI pentest & vulnerability remediation |
| **`codebase-memory-mcp`** | [DeusData/codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) | Tree-Sitter AST code knowledge graph |
| **`open-seo`** | [every-app/open-seo](https://github.com/every-app/open-seo) | Search engine optimization & competitor analysis |
| **`scrapper-scrapling`** | [D4Vinci/Scrapling](https://github.com/D4Vinci/Scrapling) | Undetectable web scraping & Turnstile bypass |
| **`humanizer`** | [blader/humanizer](https://github.com/blader/humanizer) | Removes AI-writing tells from prose |
| **`geo-ready-website`** | [scrapelesshq/GEO-Ready-Website](https://github.com/scrapelesshq/GEO-Ready-Website) | Generative Engine Optimization for AI search |
| **`mcp-gsc`** | [AminForou/mcp-gsc](https://github.com/AminForou/mcp-gsc) | Google Search Console MCP server |
| **`chrome-devtools-plugin`** | [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Browser debugging & a11y testing |
| **`flutter`** | [flutter/agent-plugins](https://github.com/flutter/agent-plugins) | Flutter development tools & accessibility agent |
| **`data-agent-kit-plugin`** | [GoogleCloudPlatform/data-agent-kit-plugin](https://github.com/GoogleCloudPlatform/data-agent-kit-plugin) | GCP BigQuery, Spark, Airflow pipelines |
| **`gemini-api`** | [google-gemini/gemini-skills](https://github.com/google-gemini/gemini-skills) | Google Gemini API & Live API SDK tooling |

---

## 🔄 How Updates Work

### 1. Local One-Click Sync
To update all skills and plugins to the latest commits from their source repositories while protecting your custom `/spin_subagents` skill, run:

```powershell
# Update all skills and plugins from upstream
.\sync-upstream.ps1

# Check for updates without modifying files
.\sync-upstream.ps1 -CheckOnly

# Update only a single specific skill
.\sync-upstream.ps1 -Target "apple-design-skill"
```

### 2. Automated Weekly GitHub Action
This repo includes a pre-configured GitHub Actions workflow ([`.github/workflows/auto-update.yml`](.github/workflows/auto-update.yml)):
* Runs **automatically every Monday at 04:00 UTC**.
* Runs `sync-upstream.ps1` in the cloud.
* If any upstream repository pushed new updates, it **automatically opens a Pull Request** in your GitHub repository detailing the updates, so you can review and merge with 1 click!

---

## 📁 Repository Structure

```text
ADNAN SKILLS/
├── README.md                  # Repository documentation & guide
├── .gitignore                 # Standard clean ignore file
├── upstream-remotes.json      # Mapping of all original GitHub upstream repos
├── sync-upstream.ps1          # One-click upstream sync script
├── .github/
│   └── workflows/
│       └── auto-update.yml    # Automated weekly GitHub Actions sync workflow
├── configs/                   # Active configuration & MCP definitions
│   ├── config.json            # Antigravity plugin and settings configuration
│   └── mcp_config.json        # MCP server connection definitions
├── plugins/                   # Packaged Antigravity plugins
│   ├── spin-subagents/        # Custom /spin_subagents orchestrator plugin
│   ├── spec-kit/              # GitHub Spec Kit (SDD, tasks, plan, converge)
│   ├── strix/                 # Autonomous pentesting & vulnerability discovery
│   ├── humanizer/             # Style & AI-tell removal rewriting engine
│   ├── scrapper-scrapling/    # Undetectable web scraping & extraction
│   ├── codebase-memory-mcp/   # AST knowledge graph intelligence engine
│   └── ...                    # Other bundled tools & extensions
└── skills/                    # Standalone skills and definitions
    ├── spin-subagents/        # Mirrored skill directory for /spin_subagents
    ├── apple-design-skill/    # Full Apple HIG (120+ pages) review system
    ├── cloudflare-security-audit/ # Multi-phase security audit workflow
    └── ...
```

---

## 🚀 Publishing to Your New GitHub Repository

When you are ready to publish this folder to GitHub:

```powershell
# 1. Navigate to this directory
cd "C:\Users\Adnan\Desktop\Orbit SaaS\ADNAN SKILLS"

# 2. Initialize git
git init

# 3. Stage all files
git add .

# 4. Create initial commit
git commit -m "feat: Initial commit of Adnan Skills and Plugins bundle including /spin_subagents"

# 5. Set main branch
git branch -M main

# 6. Add your GitHub remote (replace with your repo URL)
git remote add origin https://github.com/<your-username>/<your-repo-name>.git

# 7. Push to GitHub
git push -u origin main
```
