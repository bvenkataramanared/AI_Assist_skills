---
name: refactor
description: Restructure existing code to improve clarity, reduce duplication, or simplify — without changing its observable behavior. Use when a developer wants to clean up, extract, rename, deduplicate, or simplify code that already works. Triggers include "refactor this", "clean up", "simplify", "extract this into", "reduce duplication", or "improve the structure". For new behavior use implementation; for fixing a defect use bug-fix.
---

# Refactor

Improve the internal structure of working code — clarity, duplication, naming,
cohesion — while keeping observable behavior **identical**, with tests as the
safety net. This skill is **language- and stack-agnostic**: match the project's
existing conventions, which you discover from the surrounding code. The
discipline that makes this a skill (not a prompt) is *behavior preservation
verified at every step* — easy to claim, easy to get wrong.

## When to use

- Code works but is hard to read, duplicated, or overly complex.
- Preparing the ground before adding a feature or fixing a bug.

## When NOT to use

- Changing behavior or adding features → use `implementation`.
- Fixing broken behavior → use `bug-fix`.
- A large multi-file structural change is really several behavior changes → split
  it; refactor the parts that are pure restructuring.

## Workflow

### 1. Define the behavior to preserve
- Be explicit about the observable behavior (inputs → outputs, side effects,
  public contracts) that must stay the same. Refactoring changes structure, never
  behavior.

### 2. Establish the safety net
- Confirm tests cover the behavior you're about to move. If coverage is thin,
  add characterization tests **first** (or hand off to `test-gap-audit` for a
  risk-ranked view) so you can prove nothing changed.
- Note the build/lint/test commands the repo uses.

### 3. Refactor in small, reversible steps
- Make one focused transformation at a time (extract, rename, inline,
  deduplicate, simplify a conditional). Keep each step small enough to verify.
- Match existing naming, structure, and idioms — the result should look native to
  the codebase.

### 4. Verify after each step
- Run the tests (and build/lint) after every step, not just at the end. If a step
  changes behavior, revert it — that's a bug, not a refactor.

### 5. Know when to stop
- Stop once clarity/duplication is meaningfully improved. Avoid scope creep into
  feature work or speculative generality. Don't touch the **auth model**,
  **secrets handling**, or **perf-sensitive paths** beyond pure restructuring
  without flagging it.

## Outputs

- Cleaner, equivalent code (no observable behavior change)
- Green tests (and build/lint) proving behavior is preserved, run step by step
- Any added characterization tests
- A summary of what changed structurally and why
