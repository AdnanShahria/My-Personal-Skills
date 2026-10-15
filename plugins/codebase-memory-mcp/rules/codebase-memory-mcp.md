---
trigger: always_on
description: Automatically execute the codebase-memory-mcp skill when /codebase-memory-mcp or /codebasememorymcp is invoked in chat.
---

# Codebase Memory MCP Slash Command Trigger

When the user enters `/codebase-memory-mcp` or `/codebasememorymcp` in the chat, or asks to use codebase-memory-mcp:
1. Immediately activate and follow the `codebase-memory-mcp` skill.
2. Identify the active project name / repository path. Run `list_projects` if needed to resolve the project identifier or call `index_repository(repo_path="...")` if not yet indexed.
3. Map the user request to the specialized codebase-memory-mcp tools:
   - **Architecture & Structure**: Call `get_architecture(project=..., aspects=["overview"|"all"])` to understand components, clusters, routes, and layers.
   - **Function Call Chains & Flow**: Call `trace_path(project=..., function_name=..., direction="inbound"|"outbound"|"both")` to trace callers and callees.
   - **Find Symbols & Implementations**: Call `search_graph(project=..., query=... | name_pattern=...)` for BM25 or regex discovery; then call `get_code_snippet(project=..., qualified_name=...)` to inspect exact source.
   - **Git Changes & Blast Radius**: Call `detect_changes(project=...)` to map modified files to impacted functions with risk levels.
   - **Complex Architecture / Hotspot Queries**: Call `query_graph(project=..., query="MATCH ...")` to run custom Cypher queries.
   - **3D Visualizer**: Inform the user they can launch the interactive 3D graph visualizer using `codebase-memory-mcp --ui=true --port=9749` and open `http://localhost:9749`.
4. Return high-signal, structured findings directly to the user with minimal token overhead.
