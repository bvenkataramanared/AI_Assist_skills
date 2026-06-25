---
name: write-tests
description: Add or strengthen test coverage for existing code in this codebase, following its test conventions. Use when a developer wants to backfill missing tests, cover edge cases, or raise coverage for code that already exists. Triggers include "write tests for", "add coverage", "test this function/module", or "what tests are missing". For tests that accompany a new feature use implementation; for a regression test on a defect use bug-fix.
---

# Write Tests

> Status: scaffold — content to be implemented.

Backfills meaningful test coverage for existing code: identifies what's
untested, writes tests that assert real behavior and edge cases, and follows the
repo's existing test patterns.

## When to use

- Existing code lacks coverage or misses edge cases.
- Raising confidence before a refactor or release.

## When NOT to use

- Tests for brand-new code → use `implementation`.
- A regression test pinning a fixed bug → use `bug-fix`.

## Workflow

_To be implemented._

1. Identify the code under test and its current coverage gaps.
2. Enumerate behaviors and edge cases worth asserting.
3. Match the repo's test framework, structure, and naming.
4. Write focused, meaningful tests (avoid asserting implementation details).
5. Run the suite and confirm the new tests pass and add value.

## Outputs

- New/extended tests following repo conventions
- Coverage of key behaviors and edge cases
- Passing test run
