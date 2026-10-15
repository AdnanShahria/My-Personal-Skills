---
trigger: always_on
description: Automatically execute the spin-subagents orchestration engine when /spin_subagents is invoked in chat.
---

# Spin Subagents Slash Command Trigger

When the user enters `/spin_subagents`, `/spinsubagents`, `/spin-subagents`, `/spin_agents` in the chat, or asks to spin/dispatch a team of subagents:

1. **Activate the `spin-subagents` skill** immediately.
2. **Execute the Unified 5-Phase Multi-Agent Pipeline** merging:
   - **`/grill-me`**: Rapidly clarify and de-risk critical ambiguities (max 2-3 focused choices) before planning.
   - **`codebase-memory-mcp`**: Perform zero-waste structural discovery (`get_architecture`, `search_graph`, `trace_path`) across existing codebase symbols.
   - **`/plan` & `Spec-Kit`**: Generate formal specification (`spec.md`), architectural plan (`plan.md`), and an atomic work breakdown (`tasks.md`).
   - **`/boost`**: Conduct multi-perspective deep reasoning (Architectural integrity, Security/Threats, Performance, UX, Verification contracts).
   - **`apple-design`**: Enforce Apple Human Interface Guidelines, visual hierarchy, layout typography, touch targets, and WCAG accessibility standards for all UI/UX components.
   - **`/teamwork-preview` & Subagent System**:
     - Decompose work into discrete, parallel work packages (WPs).
     - Dynamically declare custom specialized roles using `define_subagent` if required.
     - Mass-dispatch subagents (2 to 30+ concurrent agents) in a single batch call to `invoke_subagent`.
     - Assign each subagent an isolated scope, specific input artifacts, and target output paths.
   - **Inter-Agent Supervision**: Monitor and route communications via `manage_subagents` and `send_message`.
   - **Verification & Convergence**: Re-verify completed work packages against acceptance criteria and deliver an aggregated Antigravity Artifact with clickable markdown links.
