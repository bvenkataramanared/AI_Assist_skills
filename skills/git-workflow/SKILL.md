---
name: git-workflow
description: Help with git hygiene — clear commit messages, PR descriptions, splitting a messy diff into logical commits, and resolving merge conflicts. Use when a developer needs to craft commits, write a PR description, reorganize history, or resolve conflicts. Triggers include "write a commit message", "split this into commits", "write the PR description", "help me resolve this conflict", or "clean up my history". For reviewing someone's PR use pr-review.
---

# Git Workflow

> Status: scaffold — content to be implemented.

Turns working changes into clean, reviewable history: well-scoped commits with
clear messages, strong PR descriptions, and safe conflict resolution.

## When to use

- Crafting commit messages or PR descriptions.
- Splitting a large diff into coherent commits.
- Resolving merge/rebase conflicts.

## When NOT to use

- Reviewing another developer's PR → use `pr-review`.

## Workflow

_To be implemented._

1. Inspect the working tree / diff and the repo's commit conventions.
2. Group changes into logical, self-contained commits.
3. Write messages that explain the why, not just the what.
4. For conflicts: understand both sides before resolving; verify with tests.

## Outputs

- Well-scoped commits with clear messages (matching repo style)
- A PR description linking intent, changes, and testing
- Cleanly resolved conflicts, verified

## Notes

- Never bypass hooks or rewrite shared history without explicit confirmation.
- Interactive git (`-i`) is not available in this environment; use non-interactive equivalents.
