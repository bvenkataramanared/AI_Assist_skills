---
name: change-impact-analysis
description: For a given ticket, feature, or file, find where to make the change and what it will affect — the relevant code plus the blast radius (callers, dependents, tests, config, downstream effects) — before editing. Use when a developer is unsure where to start in an unfamiliar codebase or wants to assess the risk of a change. Triggers include "where do I start", "where is X implemented", "what will this change break", "what's affected if I change Y", or "what's the blast radius". For actually writing the change use implementation or bug-fix.
---

# Change Impact Analysis

Answer the two questions a developer faces before touching unfamiliar code:
**"where do I make this change?"** and **"what will it break?"** This skill is
**language- and stack-agnostic** — it locates the work and maps its blast radius
by reading the actual code and its connections.

## When to use

- Starting a ticket in a codebase you don't fully know.
- Assessing the risk/scope of a proposed change before (or during) review.

## When NOT to use

- Writing the change itself → use `implementation` or `bug-fix`.
- A whole-repo overview → use `codebase-onboarding`.

## Workflow

### 1. Pin down the target
- Restate the task and identify the concrete behavior/area it concerns.
- Translate it into searchable anchors: feature names, routes, symbols, strings,
  config keys, error messages.

### 2. Locate the relevant code
- Search for those anchors and follow them to the primary code that implements
  the behavior. Confirm by reading, not just matching names.
- Identify the smallest set of files where the change actually belongs.

### 3. Map the blast radius
Trace outward from the change site:
- **Callers / dependents:** who calls or imports this; what relies on its behavior.
- **Contracts:** public APIs, interfaces, shared types/schemas, events — anything
  consumers depend on (breaking these has the widest blast radius).
- **Tests:** existing tests that cover or must change with this code.
- **Config & data:** env vars, feature flags, migrations, fixtures touched.
- **Downstream / cross-boundary:** other services, jobs, or persisted data affected.
- Flag impact on the sensitive surfaces: **secrets handling**, **auth model**, and
  **known perf-sensitive paths**.

### 4. Assess risk and sequence
- Rate the blast radius (localized vs. wide-reaching) and call out the riskiest edges.
- Recommend an order of attack and where new/updated tests will be needed.

## Outputs

- **Where to change:** the specific file(s)/functions, with `file:line` anchors
- **Blast radius:** callers, dependents, contracts, tests, config/data, downstream
- **Risk assessment:** how far-reaching, riskiest edges, sensitive-surface impact
- **Suggested approach:** order of work and tests to add/update
- Hand off to `implementation` / `bug-fix` to make the change
