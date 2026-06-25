---
name: git-workflow
description: Help with git hygiene — clear commit messages, PR descriptions, splitting a messy diff into logical commits, and resolving merge conflicts. Use when a developer needs to craft commits, write a PR description, reorganize history, or resolve conflicts. Triggers include "write a commit message", "split this into commits", "write the PR description", "help me resolve this conflict", or "clean up my history". For reviewing someone's PR use pr-review.
---

# Git Workflow

Turn working changes into clean, reviewable history: well-scoped commits with
clear messages, strong PR descriptions, and safe conflict resolution. The parts
that make this a skill rather than a prompt are *splitting a real diff into
coherent commits* and *resolving conflicts by understanding both sides* — both
require reading repo state and iterating, not one-shot text.

## When to use

- Crafting commit messages or a PR description.
- Splitting a large/messy diff into coherent, self-contained commits.
- Resolving merge/rebase conflicts.

## When NOT to use

- Reviewing another developer's PR for correctness → use `pr-review`.

## Conventions (this package)

- **Branch naming:** `feature/<story_number_title>` (e.g. `feature/1234-add-export`).
- **Commit messages:** free-form — no Conventional Commits requirement. Still
  explain the *why*, not just the *what*.
- Always check the repo's own history/templates and match its actual style if it
  differs from the above.

## Workflow

### 1. Inspect the state and conventions
- Look at the working tree, the diff, and recent `git log` to learn the repo's
  commit style, and check for a PR template.

### 2. For commits — group by intent
- Partition the diff into logical, self-contained units (one concern per commit).
  Refactors, fixes, and feature work belong in separate commits where practical.
- Stage and commit each group; keep each commit independently reviewable and,
  ideally, green.

### 3. Write the messages
- A concise subject line, then a body explaining the reasoning, trade-offs, and
  anything non-obvious. Reference the story/ticket. Never put secrets in messages.

### 4. For a PR description
- Summarize intent, the key changes, how it was tested, and risks/rollout notes.
  Link the story and (if relevant) call out areas for reviewers to focus on.

### 5. For conflicts — understand before resolving
- Read *both* sides and the history behind them; don't blindly keep one. Resolve
  to preserve the intent of both changes, then run the build/tests to verify the
  resolution is correct.

## Outputs

- Well-scoped commits with clear, why-focused messages (matching repo style)
- A PR description linking intent, changes, testing, and risk
- Conflicts resolved with both intents preserved, verified by tests

## Guardrails

- Never bypass hooks, force-push shared branches, or rewrite shared history
  without explicit confirmation.
- Interactive git (`-i`, e.g. `rebase -i`, `add -i`) is unavailable in this
  environment — use non-interactive equivalents.
