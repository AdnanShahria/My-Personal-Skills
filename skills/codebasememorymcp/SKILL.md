---
name: codebase-memory-mcp
description: >-
  Structural code intelligence engine and knowledge graph for codebases powered by codebase-memory-mcp.
  Trigger whenever the user types /codebase-memory-mcp, /codebasememorymcp, or asks to inspect architecture,
  trace call chains, search functions/classes/routes, detect git diff impact, run Cypher queries,
  or launch the 3D visualizer UI with 99% fewer tokens than file grep.
---

# Codebase Memory MCP Skill

`codebase-memory-mcp` is a high-performance code intelligence engine that indexes codebases into a persistent, structural knowledge graph using tree-sitter. It allows AI assistants to query code architecture and relationships directly, using up to 99% fewer tokens than traditional file reading and grep searches.

---

## When to Activate

Activate this skill immediately when:
- The user types `/codebase-memory-mcp` or `/codebasememorymcp` in the prompt.
- The user asks architectural questions (e.g. *"What are the entry points and routes?"*, *"Show me the module structure"*).
- The user asks to trace dependencies or callers (e.g. *"Who calls `createTask`?"*, *"Trace outbound calls from `handleRequest`"*).
- The user wants an impact analysis of uncommitted or committed Git changes.
- The user wants to run complex graph or Cypher queries over the codebase.
- The user asks about the 3D visualizer UI or wants to view their code as an interactive graph.

---

## Slash Command Usage

Users can invoke codebase-memory-mcp anytime using `/codebase-memory-mcp` or `/codebasememorymcp`:

- `/codebase-memory-mcp architecture` — Get high-level architecture overview, packages, and Leiden clusters.
- `/codebase-memory-mcp trace <FunctionName>` — Trace inbound and outbound callers for a function.
- `/codebase-memory-mcp find <SymbolName>` — Find function, class, or route definitions in the graph.
- `/codebase-memory-mcp changes` — Run impact analysis on uncommitted git changes.
- `/codebase-memory-mcp ui` — Instructions and launcher for the 3D graph visualizer.
- `/codebase-memory-mcp index` — Force manual indexing of the current repository.
- `/codebase-memory-mcp cypher <Query>` — Run custom Cypher graph query.

---

## Core MCP Tools Reference

The `codebase-memory-mcp` server provides 14 specialized tools via MCP:

### 1. `get_architecture`
Returns a structural overview of the project.
- **Parameters**:
  - `project` (string, required): The project identifier (from `list_projects`).
  - `aspects` (array of string, optional): `["all"]`, `["overview"]`, or subset of `["structure", "dependencies", "routes", "languages", "packages", "entry_points", "hotspots", "boundaries", "layers", "file_tree", "clusters"]`.
  - `path` (string, optional): Directory prefix to scope architecture analysis.
- **Tip**: Includes Leiden community detection (`clusters`) to surface de-facto architectural boundaries that cross folder structures.

### 2. `trace_path`
Traces paths through the code graph (callers, callees, data flows).
- **Parameters**:
  - `project` (string, required): Project identifier.
  - `function_name` (string, required): Target function or method.
  - `direction` (string, optional): `"inbound"` (who calls it), `"outbound"` (what it calls), or `"both"` (default).
  - `depth` (integer, optional): Maximum hop depth (default: 3).
  - `mode` (string, optional): `"calls"` (follow calls), `"data_flow"` (follow argument propagation), or `"cross_service"` (cross HTTP/route boundaries).
  - `risk_labels` (boolean, optional): Adds risk classification (`CRITICAL`, `HIGH`, `MEDIUM`, `LOW`) based on hop distance.
  - `include_tests` (boolean, optional): Whether to include test callers.

### 3. `search_graph`
Searches for symbols (functions, classes, routes, variables) in the graph.
- **Parameters**:
  - `project` (string, required): Project identifier.
  - `query` (string, optional): Natural language or BM25 ranked search with camelCase splitting and structural boosting.
  - `name_pattern` (string, optional): Exact regex pattern (e.g. `.*Handler.*`).
  - `semantic_query` (array of strings, optional): Vector cosine search (e.g. `["publish", "event"]`).
  - `label` (string, optional): Filter by node label (`Function`, `Class`, `Route`, etc.).
  - `file_pattern` (string, optional): Regex on file path.
  - `min_degree` / `max_degree` (integer, optional): Degree connectivity filter.
  - `offset` / `limit` (integer, optional): Pagination parameters (default limit 200). Check `has_more` in response.

### 4. `get_code_snippet`
Reads source code for a specific function, class, or symbol.
- **Parameters**:
  - `project` (string, required): Project identifier.
  - `qualified_name` (string, required): Exact qualified name from `search_graph`.
  - `include_neighbors` (boolean, optional): Includes surrounding context/callers.

### 5. `detect_changes`
Impact analysis for code changes.
- **Parameters**:
  - `project` (string, required): Project identifier.
  - `since` (string, optional): Git ref or tag to compare against (e.g. `HEAD~1`, `main`).
  - `depth` (integer, optional): Traversal depth for impact calculation.
  - `base_branch` (string, optional): Base branch for comparison (default: `main`).

### 6. `query_graph`
Executes raw Cypher queries on the knowledge graph for complex patterns and metrics.
- **Parameters**:
  - `project` (string, required): Project identifier.
  - `query` (string, required): Cypher query string.
  - `max_rows` (integer, optional): Row ceiling.
- **Hotpath signals available on nodes**:
  - `complexity` (cyclomatic), `cognitive`, `loop_count`, `loop_depth`, `transitive_loop_depth`.
  - `linear_scan_in_loop` (O(n^2) hidden scans), `alloc_in_loop`, `recursion_in_loop`.
- **Example Cypher**:
  ```cypher
  MATCH (f:Function)
  WHERE f.transitive_loop_depth >= 3 OR f.linear_scan_in_loop >= 1
  RETURN f.qualified_name, f.transitive_loop_depth, f.linear_scan_in_loop
  ORDER BY f.transitive_loop_depth DESC
  ```

### 7. `search_code`
Graph-augmented grep search.
- **Parameters**:
  - `project` (string, required): Project identifier.
  - `pattern` (string, required): Search pattern or regex.
  - `mode` (string, optional): `"compact"` (signatures only - token efficient), `"full"` (with source), or `"files"`.
  - `path_filter` (string, optional): Regex to scope file paths.
  - `limit` (integer, optional): Default 10.

### 8. `index_repository`
Indexes or re-indexes a repository into the knowledge graph.
- **Parameters**:
  - `repo_path` (string, required): Absolute path to repository.
  - `mode` (string, optional): `"full"`, `"moderate"`, `"fast"`, or `"cross-repo-intelligence"`.
  - `persistence` (boolean, optional): Writes compressed artifact to `.codebase-memory/graph.db.zst` for team sharing.

### 9. `list_projects` & `index_status`
- `list_projects`: Lists all indexed repositories, node counts, edge counts, and project identifiers.
- `index_status`: Returns current indexing state and freshness.

### 10. `manage_adr`
Stores and queries Architecture Decision Records (ADRs) to maintain design context across sessions.

---

## Running the 3D Graph Visualizer

The UI variant provides an interactive 3D WebGL graph visualizer of the codebase.

**Launch command (PowerShell / Terminal):**
```powershell
codebase-memory-mcp --ui=true --port=9749
```
Open **`http://localhost:9749`** in your browser to explore:
- Interactive 3D node clusters (classes, functions, routes).
- Color-coded dependency and call edges.
- Architectural boundaries and community detection groupings.

---

## Workflow Recipes

### Recipe 1: Initial Discovery of an Unfamiliar Codebase
1. Run `list_projects` to find the registered project name matching the current workspace root.
2. If not indexed, call `index_repository(repo_path="<CWD>", mode="full")`.
3. Call `get_architecture(project="<NAME>", aspects=["overview", "packages", "routes", "clusters"])`.
4. Summarize key subsystems, entry points, and module clusters for the user.

### Recipe 2: Safe Refactoring / Impact Analysis
1. Before modifying a function, call `trace_path(project="<NAME>", function_name="<TARGET>", direction="inbound", risk_labels=true)`.
2. Inspect every caller at depth 1 and 2 to anticipate breaking changes.
3. Call `get_code_snippet(project="<NAME>", qualified_name="<CALLER_QN>")` if callers require interface adjustments.
4. After editing, call `detect_changes(project="<NAME>")` to verify blast radius.

### Recipe 3: Investigating Complexity & Bottlenecks
Run a Cypher query using `query_graph`:
```cypher
MATCH (f:Function)
WHERE f.cognitive > 15 OR f.loop_depth >= 2
RETURN f.name, f.qualified_name, f.cognitive, f.loop_depth
ORDER BY f.cognitive DESC
LIMIT 10
```

---

## Token Efficiency Rules

- **DO NOT** use `grep_search` or open raw files when looking for function definitions, call chains, or routes. Use `search_graph` and `trace_path`.
- **DO NOT** read an entire file just to view one method. Use `get_code_snippet` with the exact `qualified_name`.
- Use fallback grep/file-viewing ONLY for non-code files (Dockerfiles, raw JSON/YAML configs, markdown documentation) or if MCP graph tools return empty results.
