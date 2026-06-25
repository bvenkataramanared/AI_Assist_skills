---
name: bug-fix
description: Diagnose and fix a bug in any codebase, with a regression test that proves the fix. Use when something is broken, throwing an error, or behaving incorrectly and the developer wants the root cause found and corrected. Triggers include "fix this bug", "this is throwing", "why is X failing", "debug this", or a pasted stack trace / error message. For building new functionality use implementation instead.
---

# Bug Fix

Find the **root cause** of a defect (not just the symptom), apply the smallest
correct fix, and add a regression test so it stays fixed. This skill is
**language- and stack-agnostic**: work within the project's existing language,
conventions, and test setup, which you discover from the repo.

## When to use

- Existing behavior is broken, errors out, or produces wrong results.
- There's a stack trace, failing test, error log, or repro steps.

## When NOT to use

- Building new functionality → use `implementation`.
- You only need a fast "what's likely causing this" pass → use `debug-triage`.
- Reviewing someone else's change → use `pr-review`.

## Workflow

### 1. Reproduce the bug
- Establish a reliable repro: exact steps, inputs, environment, expected vs.
  actual behavior. Capture the failure (error message, stack trace, wrong output).
- If you can't reproduce it, gather more information before changing code —
  fixing an unreproduced bug is guessing.

### 2. Discover the project's conventions
- Identify the language, build, and **test framework/command** from the repo's
  manifests, CI config, and existing tests (don't assume a stack).
- Note how the surrounding code handles errors, logging, and edge cases.

### 3. Find the root cause
- Trace from the symptom back to the underlying defect. Follow the actual code
  path; read the relevant `file:line` locations.
- Distinguish the root cause from its symptoms — the same bug may surface in
  several places. Confirm your hypothesis against the repro before fixing.
- Check whether the bug touches a sensitive surface: **secrets handling**, the
  **auth model**, or a **known perf-sensitive path** — these raise the stakes of
  both the bug and the fix.

### 4. Write a failing regression test first
- Add a test that reproduces the bug and **fails** for the current code, in the
  project's existing test style. This proves you've captured the defect.

### 5. Apply the smallest correct fix
- Fix the root cause, not the symptom. Prefer the minimal change that matches
  existing conventions over a broad rewrite.
- Avoid scope creep — note unrelated issues separately rather than fixing them here.

### 6. Verify
- Confirm the regression test now **passes**.
- Run the full build/lint/test suite (using the repo's commands) to ensure the
  fix didn't break anything else.

### 7. Summarize
- Explain the root cause, the fix, and why it's correct. Note any related risks
  or follow-ups. For branch/commit/PR mechanics, hand off to `git-workflow`
  (branch name `feature/<story_number_title>` if one is needed).

## Outputs

- A clear root-cause explanation (with `file:line` references)
- A regression test that failed before the fix and passes after
- The smallest correct fix, matching repo conventions
- A clean full test run
