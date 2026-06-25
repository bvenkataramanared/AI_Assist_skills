---
name: refactor
description: Restructure existing code to improve clarity, reduce duplication, or simplify — without changing its observable behavior. Use when a developer wants to clean up, extract, rename, deduplicate, or simplify code that already works. Triggers include "refactor this", "clean up", "simplify", "extract this into", "reduce duplication", or "improve the structure". For new behavior use implementation; for fixing a defect use bug-fix.
---

# Refactor

> Status: scaffold — content to be implemented.

Improves the internal structure of working code — clarity, duplication,
naming, cohesion — while keeping observable behavior identical, with tests as
the safety net.

## When to use

- Code works but is hard to read, duplicated, or overly complex.
- Preparing the ground before adding a feature or fixing a bug.

## When NOT to use

- Changing behavior or adding features → use `implementation`.
- Fixing broken behavior → use `bug-fix`.

## Workflow

_To be implemented._

1. Confirm the behavior to preserve and that tests cover it (add them if not).
2. Make small, behavior-preserving changes in steps.
3. Run tests after each step to prove behavior is unchanged.
4. Stop when clarity is improved; avoid scope creep into feature work.

## Outputs

- Cleaner, equivalent code (no behavior change)
- Green tests proving behavior is preserved
- A summary of what changed and why
