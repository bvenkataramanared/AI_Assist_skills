---
name: codebase-onboarding
description: Orient a developer who is new to a repository — produce a whole-repo overview of what the app does, its tech stack, structure, how to build/run/test it, external integrations, and key conventions, ending with a suggested reading order. Use on day one in an unfamiliar codebase or when someone asks "what is this repo", "give me the lay of the land", "help me understand this project", or "where do I start". For a visual diagram of the structure use flowchart; for getting it running locally use dev-environment-setup.
---

# Codebase Onboarding

Give a newcomer the **lay of the land** for an unfamiliar repository: what the app
is, how it's built, how it's organized, how to run it, and what to read first.
This skill is **language- and stack-agnostic** — it derives the picture from the
actual repo, using any README/docs as one input to cross-check, not as the source
of truth.

## When to use

- Day one in an unfamiliar codebase, or ramping up a new team member.
- Someone wants a whole-repo overview and a place to start.

## When NOT to use

- A visual diagram of flow/dependencies → use `flowchart`.
- Getting the app running locally, step by step → use `dev-environment-setup`.
- Mapping entities/schema/API contracts → use `data-model-map`.

## Workflow

### 1. Start from the docs, but trust the code
- Read the `README`, `docs/`, `CONTRIBUTING.md`, `CLAUDE.md`, ADRs, and any wiki
  links if present. Treat these as **claims to verify**, not ground truth.
- Note where docs are missing, vague, or contradicted by the code — those gaps
  are the most valuable part of the orientation.

### 2. Identify what the app is and its tech stack
- Determine the app's purpose and domain from docs, naming, and entry points.
- Detect the language(s), framework(s), and major libraries from manifests/config
  (`package.json`, `pyproject.toml`, `pom.xml`, `go.mod`, `*.csproj`, etc.).
- Identify runtime/infra signals: Dockerfiles, compose, CI config, IaC
  (Terraform/CDK), and external services (DBs, queues, 3rd-party/cloud APIs).

### 3. Map the structure
- Summarize the top-level directory layout and what each major folder is for
  (this is a single-app repo).
- Locate the **entry points**: app/server bootstrap, route/handler registration,
  CLI commands, scheduled jobs, background workers.
- Identify the architectural layering (e.g. interface → service → data) and where
  the core business logic lives.

### 4. Capture how to build, run, and test
- Extract the real build / run / lint / test commands from scripts, Makefile/
  Taskfile, CI, and docs. (For a full local setup walkthrough, hand off to
  `dev-environment-setup`.)

### 5. Surface conventions and sensitive areas
- Note naming, error-handling, logging, and testing conventions seen across the code.
- Flag the **secrets handling** mechanism, the **auth model**, and any obvious
  **perf-sensitive paths** — newcomers need these guardrails early.

### 6. Produce the orientation + a reading order
- Write a concise overview report (below) and end with a **suggested reading
  order**: the 5–10 files/areas to read first to become productive, in sequence,
  each with a one-line reason and `file:line` anchor.
- Point to sibling skills for next steps (`flowchart`, `data-model-map`,
  `change-impact-analysis`). For getting it running, hand off to
  `dev-environment-setup`.

## Outputs

- **What it is:** purpose, domain, and tech stack
- **Structure:** annotated directory map + entry points + architecture layers
- **Run it:** build / run / test commands (verified against the repo)
- **Conventions & guardrails:** style, secrets, auth, perf-sensitive paths
- **Doc gaps:** where the README/docs are missing, stale, or wrong
- **Suggested reading order:** the first 5–10 things to read, with reasons
