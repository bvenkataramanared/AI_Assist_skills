---
name: dev-environment-setup
description: Get an unfamiliar application running locally — detect prerequisites, required environment variables and config, then lay out exact install, build, run, and "verify it works" steps, with common gotchas. Use when a developer has cloned a repo and needs it running on their machine. Triggers include "how do I run this locally", "set up the dev environment", "get this running", "how do I start the app", or "what do I need installed". For auditing or upgrading dependencies use dependency-health-audit.
---

# Dev Environment Setup

Take a fresh checkout of an unfamiliar app and produce the exact path to running
it locally: prerequisites, configuration, and verified run steps. This skill is
**language- and stack-agnostic** — it detects what the project needs from the
repo rather than assuming any toolchain.

## When to use

- A developer has cloned a repo and needs it building/running on their machine.
- Onboarding: turning "I have the code" into "it runs locally".

## When NOT to use

- Auditing or upgrading dependencies → use `dependency-health-audit`.
- Whole-repo orientation → use `codebase-onboarding`.

## Workflow

### 1. Detect prerequisites
- Identify the language runtime(s) and required versions from manifests and
  version files (`.nvmrc`, `.python-version`, `go.mod`, `engines`, toolchain files).
- Detect required tooling and services: package manager, Docker/compose, a
  database, message broker, or cloud credentials — from compose files, IaC, CI
  config, and docs.

### 2. Find the configuration the app needs
- Locate config and environment requirements: `.env.example`, sample config
  files, settings modules, and references to env vars in code.
- List each required variable/secret, what it's for, and a safe local default or
  where to obtain it. **Never invent or hardcode real secrets** — follow the
  repo's secrets mechanism and point to it.

### 3. Determine the setup sequence
- Derive the real commands in order from scripts, Makefile/Taskfile, compose, and
  docs: install dependencies → build → run any required services (DB/migrations/
  seed data) → start the app.
- Prefer the project's own scripts over hand-rolled commands.

### 4. Verify it works
- Provide a concrete "it's up" check: a health endpoint, a homepage, a CLI
  command, or the expected startup log line.
- Where possible, run the steps and confirm; report exactly what succeeded.

### 5. Capture gotchas
- Note common failure modes and fixes (missing service, port conflicts, wrong
  runtime version, unset env var, platform-specific issues).

## Outputs

- **Prerequisites:** runtimes, tools, and services with required versions
- **Configuration:** required env vars / config, each explained, secrets sourced safely
- **Setup steps:** ordered install → build → services → run commands (from the repo)
- **Verification:** how to confirm the app is actually running
- **Gotchas:** likely pitfalls and their fixes
