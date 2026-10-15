---
name: "spec-kit"
description: "GitHub Spec Kit: Spec-Driven Development (SDD), Bug fixing, and Idea assessment workflows. Triggered whenever the user enters /spec, /specify, /speckit, or any /spec <command>."
compatibility: "Works across any repository with or without an existing .specify directory"
metadata:
  author: "github-spec-kit"
  source: "https://github.com/github/spec-kit"
---

# GitHub Spec Kit (Spec-Driven Development Toolkit)

GitHub Spec Kit gives AI coding agents structured processes, reusable templates, and documented outcomes for:
1. **Spec-Driven Development (SDD)**: Define what and why before deciding how to build it.
2. **Bug Fixing Pipeline**: Independent diagnose, repair, and verification loop.
3. **Idea Assessment Pipeline**: Intake, research, definition, shaping, and evidence-backed go/kill decision.

---

## Command Routing & Invocation

When the user enters `/spec`, `/specify`, `/speckit`, or any sub-command in the chat, map and route it as follows:

| Chat Invocation | Specialized Skill | Purpose & Next Steps |
| :--- | :--- | :--- |
| `/spec` or `/specify` | `spec-kit` | Display workspace status, active feature, and command guide |
| `/spec init` | `specify init` | Initialize Spec Kit in workspace (`specify init --here --integration agy --script ps`) |
| `/spec constitution` | `speckit-constitution` | Establish or update project principles and quality constraints |
| `/spec specify <text>` | `speckit-specify` | Create baseline functional specification under `specs/<feature>/spec.md` |
| `/spec clarify` | `speckit-clarify` | Identify and resolve ambiguities before planning |
| `/spec plan` | `speckit-plan` | Generate implementation plan, architecture, and contracts |
| `/spec checklist` | `speckit-checklist` | Generate quality checklists to validate requirements |
| `/spec tasks` | `speckit-tasks` | Generate actionable dependency-ordered tasks |
| `/spec analyze` | `speckit-analyze` | Cross-artifact consistency & alignment verification |
| `/spec implement` | `speckit-implement` | Execute implementation against tasks and contract definitions |
| `/spec converge` | `speckit-converge` | Assess codebase progress and converge remaining tasks |
| `/spec taskstoissues` | `speckit-taskstoissues` | Export tasks to GitHub Issues or issue tracker |
| `/spec bug-assess <text>` | `speckit-bug-assess` | Assess bug report, root cause, and remediation |
| `/spec bug-fix slug=...` | `speckit-bug-fix` | Apply remediation and record changes |
| `/spec bug-test slug=...` | `speckit-bug-test` | Validate bug resolution against initial symptom |
| `/spec assess-intake <idea>` | `speckit-assess-intake` | Capture and normalize an idea into an intake note |
| `/spec assess-research` | `speckit-assess-research` | Gather evidence, prior art, market, and user data |
| `/spec assess-define` | `speckit-assess-define` | Define problem, affected users, and success metrics |
| `/spec assess-shape` | `speckit-assess-shape` | Shape solution concept, scope, appetite, and trade-offs |
| `/spec assess-decide` | `speckit-assess-decide` | Apply go / needs-clarification / kill decision gate |

---

## Execution Flow

### Step 1: Environment & Project Detection
1. Check if the current workspace root has a `.specify/` directory.
2. If `.specify/` is **NOT present**:
   - If the user ran `/spec init` or wants to start a spec workflow:
     Run `specify init --here --integration agy --script ps` (or `sh` if in POSIX shell) using `run_command`.
   - If the user ran `/spec` alone: Show a friendly onboarding card explaining that Spec Kit is ready and prompt to initialize.
3. If `.specify/` is **present**:
   - Inspect `.specify/feature.json` or `specs/` to identify the active feature.
   - Read `.specify/memory/constitution.md` if available for project principles.

### Step 2: Phase Execution
Follow the structured process required by the user's subcommand:
- **Constitution**: Ensure principles in `.specify/memory/constitution.md` reflect the project's quality, architecture, and testing standards.
- **Specify**: Generate or update `specs/<feature-dir>/spec.md` with prioritized user stories (P1, P2, P3...), acceptance scenarios (Given-When-Then), and functional requirements.
- **Plan**: Create `specs/<feature-dir>/plan.md` checking constitution gates, data models, contracts, and research notes.
- **Tasks**: Create `specs/<feature-dir>/tasks.md` with actionable checklist tasks tagged with story IDs (e.g., `[US1]`, `[P]`).
- **Implement**: Complete tasks in small verifiable batches, executing tests after each change.
- **Converge**: Inspect git diff, run test suites, check against acceptance criteria, and update tasks until complete.

### Step 3: Script Execution Guidance
- On Windows: Run `.specify/scripts/powershell/<script>.ps1` or run equivalent python scripts if available.
- On Linux/macOS/Git Bash: Run `.specify/scripts/bash/<script>.sh`.
- The CLI tool `specify` is installed and globally available in PATH (`specify --help`).
