---
name: data-model-map
description: Map the data and contract layer of an application — domain entities, their relationships, the database schema/migrations, and the exposed API/interface surface — as a reference plus a diagram. Use when a developer needs to understand the "nouns" of a system: its data structures, persistence, and external contracts. Triggers include "what's the data model", "show the schema", "what entities are there", "map the API", "what are the endpoints", or "how is data structured". For control/data *flow* use flowchart; for a whole-repo overview use codebase-onboarding.
---

# Data Model Map

Map the structural backbone of an application — its **entities, relationships,
persistence, and contracts** — so a developer understands the data the system is
built around. This skill is **language- and stack-agnostic**: derive the model
from the actual code, schema, and interface definitions.

## When to use

- Understanding the domain entities and how they relate.
- Learning the database schema/migrations or the exposed API/interface surface.

## When NOT to use

- Control/data *flow* through the app → use `flowchart`.
- A whole-repo overview → use `codebase-onboarding`.

## Workflow

### 1. Locate the data definitions
- Find entity/model definitions (ORM models, structs/classes, type definitions,
  schema files) and any database migrations.
- Find the persistence layer: which datastore(s), tables/collections, and how
  models map to them.

### 2. Extract entities and relationships
- List the core entities with their key fields and types.
- Capture relationships (one-to-many, many-to-many, references, ownership) and
  constraints (keys, uniqueness, required fields).
- Note enums, value objects, and important invariants.

### 3. Map the contract surface
- Identify the exposed interfaces consumers depend on: API endpoints (REST/GraphQL/
  RPC), request/response shapes, public types, and emitted/consumed events/messages.
- Note versioning and where these contracts are defined.

### 4. Render the model
- Produce a clear reference (entities → fields → relationships; endpoints →
  shapes) **and** a diagram. Default to **Mermaid** (`erDiagram` for data models,
  `classDiagram` for type structures) in a fenced ```mermaid block.
- Keep it accurate: only include relationships verified in code/schema; mark
  anything uncertain. Split into multiple diagrams if too large to read.

### 5. Flag sensitive data
- Call out fields involving secrets/credentials or sensitive/PII data, and how
  access is controlled (ties into the **auth model** and **secrets handling**).

## Outputs

- **Entity reference:** core entities, key fields/types, relationships, constraints
- **Schema notes:** datastore(s), tables/collections, migrations
- **Contract surface:** API endpoints / interfaces / events with their shapes
- **Diagram:** Mermaid `erDiagram`/`classDiagram` of the model
- **Sensitive-data notes:** secret/PII fields and how access is governed
