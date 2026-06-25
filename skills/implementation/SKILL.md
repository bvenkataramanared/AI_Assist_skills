---
name: implementation
description: Implement a new feature or task in any codebase, following its existing conventions and language. Use when a developer has a user story, ticket, or task description and wants to write the code — including tests — to make it work. Triggers include "implement this", "build this feature", "add support for", or "code up this story". For fixing broken behavior use bug-fix instead.
---

# Implementation

Take a feature or task description and turn it into working, convention-matching
code with tests — in small, reviewable steps. This skill is **language- and
stack-agnostic**: discover how the project is built and follow its existing
patterns rather than imposing any particular language or tool.

## When to use

- A new feature, endpoint, capability, or task needs to be built.
- The work adds or changes behavior that does not yet exist.

## When NOT to use

- Diagnosing or fixing broken behavior → use `bug-fix`.
- Reviewing someone else's change → use `pr-review`.
- Restructuring working code without changing behavior → use `refactor`.

## Workflow

### 1. Understand the task
- Restate the task in your own words and confirm the acceptance criteria. If the
  story is ambiguous or underspecified, ask before coding — don't guess at scope.
- Identify what "done" means: observable behavior, edge cases, and constraints.

### 2. Discover the project's conventions (do this every time)
Never assume the language or toolchain — read it from the repo:
- **Language & build:** look for manifest/config files (e.g. `package.json`,
  `pyproject.toml`, `pom.xml`, `go.mod`, `Cargo.toml`, `*.csproj`, `Gemfile`).
- **How code is run, built, linted, tested:** check scripts in those manifests,
  CI config, Makefile/Taskfile, and any `CONTRIBUTING.md` / `CLAUDE.md`.
- **Patterns to match:** read a few neighboring files to learn naming, structure,
  error handling, logging, dependency-injection, and layering conventions.
- **Tests:** find the existing test directory and framework; mirror its style.

### 3. Plan the change
- Locate the files/components to touch (this is a single-app repo).
- Sketch the smallest design that satisfies the criteria; note affected modules,
  data flow, and any new dependencies (prefer existing dependencies over new ones).
- Flag the security- and performance-sensitive surfaces up front: **secrets
  handling**, the **auth model**, and any **known perf-sensitive paths** the
  change touches.

### 4. Implement incrementally
- Make small, coherent changes; keep the project buildable at each step.
- Match the conventions found in step 2 — the change should look like it was
  written by the team.
- Handle errors and edge cases the way the surrounding code does.
- Never hardcode secrets or credentials; follow the repo's secrets mechanism.

### 5. Add tests
- Cover the new behavior and its important edge cases, using the project's test
  framework and style. Assert behavior, not implementation details.

### 6. Verify
- Run the project's build, linter/formatter, and test suite using whatever
  commands the repo defines. Fix anything you introduced.
- Re-check the change against the acceptance criteria.

### 7. Prepare for handoff
- Summarize what changed and why, and call out any deviations from the original
  plan or follow-ups left open.
- If creating a branch, name it `feature/<story_number_title>` (e.g.
  `feature/1234-add-export-button`). For commits/PR mechanics, hand off to
  `git-workflow`.

## Outputs

- Working code that satisfies the acceptance criteria, matching repo conventions
- Tests covering the new behavior, in the project's existing style
- A clean build / lint / test run (using the repo's own commands)
- A short summary of the change, decisions, and any follow-ups
