---
trigger: always_on
description: Route and execute GitHub Spec Kit workflows whenever /spec, /specify, /speckit, or any /spec-* or /speckit-* slash commands are typed in chat.
---

# GitHub Spec Kit Slash Command Trigger

When the user enters `/spec`, `/specify`, `/speckit`, or any `/spec <command>`, `/spec.<command>`, `/spec-<command>`, `/spec/<command>`, or `/speckit-<command>` in the chat interface:
1. Immediately activate and follow the `spec-kit` skill or the matching specialized skill (`speckit-specify`, `speckit-plan`, `speckit-tasks`, `speckit-implement`, `speckit-converge`, `speckit-constitution`, `speckit-bug-assess`, etc.).
2. Workspace Detection & Initialization:
   - Check if `.specify/` exists in the current project root.
   - If not found and the user is running an SDD workflow or `/spec init`:
     Execute `specify init --here --integration agy --script ps` (or `--script sh` in a bash environment) using `run_command` to set up the project infrastructure.
3. Subcommand Routing:
   - `/spec` or `/specify` (no args): Provide current project status (active spec, plan, constitution) and interactive command guide.
   - `/spec init`: Initialize Spec Kit in the workspace with `specify init --here --integration agy --script ps`.
   - `/spec constitution`: Activate `speckit-constitution`. Establish or update project principles and quality standards.
   - `/spec specify <feature>` or `/speckit-specify <feature>`: Activate `speckit-specify`. Write feature specification in `specs/<feature>/spec.md`.
   - `/spec clarify`: Activate `speckit-clarify`. De-risk ambiguities before planning.
   - `/spec plan`: Activate `speckit-plan`. Create architectural and technical implementation plan.
   - `/spec checklist`: Activate `speckit-checklist`. Validate requirements completeness.
   - `/spec tasks`: Activate `speckit-tasks`. Generate actionable task lists.
   - `/spec analyze`: Activate `speckit-analyze`. Check cross-artifact consistency.
   - `/spec implement`: Activate `speckit-implement`. Execute code changes following tasks and contracts.
   - `/spec converge`: Activate `speckit-converge`. Check git diff, run test suites, verify acceptance criteria.
   - `/spec taskstoissues`: Activate `speckit-taskstoissues`. Convert tasks into issues.
   - `/spec bug-assess`: Activate `speckit-bug-assess`. Assess root causes and remediation.
   - `/spec bug-fix`: Activate `speckit-bug-fix`. Implement scoped bug fix.
   - `/spec bug-test`: Activate `speckit-bug-test`. Run verification and record verdict.
   - `/spec assess-*`: Activate the respective `speckit-assess-*` skill for idea assessment.
4. Formatting & Outcomes:
   - Maintain the standard Spec Kit markdown artifacts under `.specify/` and `specs/`.
   - Keep outcomes structured, concise, and documented.
